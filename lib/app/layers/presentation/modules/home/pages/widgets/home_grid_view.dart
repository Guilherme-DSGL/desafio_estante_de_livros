import '../../../../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/theme/app_sizes.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onRefresh,
  });
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final isLandScape =
          MediaQuery.orientationOf(context) == Orientation.landscape;
      return Padding(
        padding: const EdgeInsets.all(AppSizes.size10),
        child: RefreshIndicator(
          color: AppColors.whiteColor,
          onRefresh: onRefresh,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent:
                    isLandScape ? AppSizes.size300 : AppSizes.size210,
                maxCrossAxisExtent: isLandScape
                    ? MediaQuery.sizeOf(context).width / 4
                    : MediaQuery.sizeOf(context).width / 1),
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          ),
        ),
      );
    });
  }
}
