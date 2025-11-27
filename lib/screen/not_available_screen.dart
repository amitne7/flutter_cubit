import 'package:personal_security_officer/app/general_imports.dart';
import 'package:flutter/material.dart';

class NotAvailableScreen extends StatelessWidget {
  const NotAvailableScreen({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: NoDataFoundWidget(
            titleKey: "weAreNotAvailableHere".translate(context: context),
          ),
        ),
      );
}
