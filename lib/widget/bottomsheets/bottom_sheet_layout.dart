import 'package:personal_security_officer/app/general_imports.dart';
import 'package:flutter/material.dart';

class BottomSheetLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final bool? topPadding;

  const BottomSheetLayout(
      {super.key, required this.title, required this.child, this.topPadding});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: context.colorScheme.primaryColor,
      borderRadiusStyle: const BorderRadius.only(
          topRight: Radius.circular(UiUtils.borderRadiusOf20),
          topLeft: Radius.circular(UiUtils.borderRadiusOf20)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomContainer(
              width: context.screenWidth,
              padding: const EdgeInsets.all(15.0),
              color: context.colorScheme.secondaryColor,
              borderRadiusStyle: const BorderRadius.only(
                  topRight: Radius.circular(UiUtils.borderRadiusOf20),
                  topLeft: Radius.circular(UiUtils.borderRadiusOf20)),
              child: CustomText(
                title.translate(context: context),
                fontSize: 20.0,
                maxLines: 1,
                color: context.colorScheme.blackColor,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                textAlign: TextAlign.start,
              ),
            ),
            CustomContainer(
              padding: topPadding == false
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(top: 5),
              color: context.colorScheme.primaryColor,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
