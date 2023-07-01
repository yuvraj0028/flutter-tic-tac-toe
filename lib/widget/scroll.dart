import 'package:flutter/material.dart';

class Scroll extends ScrollBehavior {
  final int androidSDKVersion;

  const Scroll({required this.androidSDKVersion}) : super();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    if (androidSDKVersion > 30) {
      return StretchingOverscrollIndicator(
        axisDirection: details.direction,
        child: child,
      );
    } else {
      return GlowingOverscrollIndicator(
        axisDirection: details.direction,
        color: Theme.of(context).colorScheme.secondary,
        child: child,
      );
    }
  }
}
