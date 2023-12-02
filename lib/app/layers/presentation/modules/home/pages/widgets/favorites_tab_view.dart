import 'package:flutter/material.dart';

import 'home_grid_view.dart';

class FavoritesTabView extends StatelessWidget {
  const FavoritesTabView(
      {super.key, required this.itemBuilder, required this.itemCount});
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return HomeGridView(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
