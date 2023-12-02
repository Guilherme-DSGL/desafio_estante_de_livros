import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_theme.dart';

class AppTitleText extends StatelessWidget {
  const AppTitleText({super.key, required this.title, this.textStyle});
  final String title;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: AppTextTheme.primaryTheme.displaySmall!
          .merge(textStyle)
          .apply(color: AppColors.titleColor),
    );
  }
}
