import 'package:flutter/material.dart';

import 'home_grid_view.dart';

class FavoritesTabView extends StatelessWidget {
  const FavoritesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeGridView(
      itemCount: 10,
      itemBuilder: (context, index) => Container(
        height: 200,
        width: 200,
        color: Colors.black,
      ),
    );
  }
}
