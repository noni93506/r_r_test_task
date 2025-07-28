import 'package:flutter/material.dart';
import 'package:r_r_t_app/resources/app_colors.dart';
import 'package:r_r_t_app/resources/app_text_styles.dart';

class ShowPasswordButton extends StatelessWidget {
  final bool show;
  final VoidCallback onTap;

  const ShowPasswordButton({required this.show, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
      child: Text(
        show ? "hide" : "show",
        style: AppTextStyles.bodyM.copyWith(color: AppColors.blue),
      ),
    );
  }
}
