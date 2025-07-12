import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_theme.dart';

class AppTitleText extends StatelessWidget {
  const AppTitleText({
    required this.title,
    this.textStyle,
    this.softWrap = true,
    this.maxLines = 1,
    super.key,
  });

  final String title;
  final bool? softWrap;
  final int? maxLines;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: softWrap,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: AppTextTheme.primaryTheme.titleLarge!
          .apply(color: AppColors.titleColor)
          .merge(textStyle),
    );
  }
}
