import 'package:flutter/material.dart';
import 'package:personal_security_officer/app/general_imports.dart';

class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator({
    required this.onRefreshCallback,
    required this.child,
    required this.displacment,
    super.key,
  });
  final Widget child;
  final Function onRefreshCallback;
  final double displacment;

  @override
  Widget build(final BuildContext context) => RefreshIndicator(
        displacement: displacment,
        color: context.colorScheme.accentColor,
        onRefresh: () async {
          onRefreshCallback();
        },
        child: child,
      );
}
