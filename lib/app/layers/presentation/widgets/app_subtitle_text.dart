import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_theme.dart';

class AppSubTitleText extends StatelessWidget {
  const AppSubTitleText({super.key, required this.subTitle, this.textStyle});
  final String subTitle;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: AppTextTheme.primaryTheme.labelMedium!
          .apply(
            color: AppColors.labelColor,
          )
          .merge(textStyle),
    );
  }
}
