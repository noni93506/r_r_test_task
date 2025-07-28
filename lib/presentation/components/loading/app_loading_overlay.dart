import 'package:flutter/material.dart';
import 'package:r_r_t_app/presentation/components/loading/app_loading_indicator.dart';

class AppLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Duration visibilityChangeDuration;
  final EdgeInsets margin;
  final Color? indicatorColor;
  final Color? backgroundColor;
  final double? height;

  const AppLoadingOverlay({
    this.isLoading = true,
    this.visibilityChangeDuration = Duration.zero,
    this.margin = EdgeInsets.zero,
    this.indicatorColor,
    this.backgroundColor,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isLoading,
      child: Container(
        height: height,
        color: backgroundColor ?? Colors.transparent,
        alignment: Alignment.center,
        child: const AppLoadingIndicator(),
      ),
    );
  }
}
