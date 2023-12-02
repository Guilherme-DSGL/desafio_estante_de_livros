import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/theme/app_sizes.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.size10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            mainAxisExtent: AppSizes.size210,
            maxCrossAxisExtent: MediaQuery.sizeOf(context).width / 1),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
