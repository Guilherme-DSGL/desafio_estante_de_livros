import 'package:flutter/material.dart';

import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_sizes.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({
    required this.itemCount,
    required this.itemBuilder,
    required this.onRefresh,
    super.key,
    this.scrollController,
  });

  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final Future<void> Function() onRefresh;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraint) {
          final isLandScape =
              MediaQuery.orientationOf(context) == Orientation.landscape;
          return Padding(
            padding: const EdgeInsets.all(AppSizes.size10),
            child: RefreshIndicator(
              color: AppColors.whiteColor,
              onRefresh: () async => onRefresh(),
              child: GridView.builder(
                controller: scrollController,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent:
                      isLandScape ? AppSizes.size300 : AppSizes.size210,
                  maxCrossAxisExtent: isLandScape
                      ? MediaQuery.sizeOf(context).width / 4
                      : MediaQuery.sizeOf(context).width / 1,
                ),
                itemCount: itemCount,
                itemBuilder: itemBuilder,
              ),
            ),
          );
        },
      );
}
