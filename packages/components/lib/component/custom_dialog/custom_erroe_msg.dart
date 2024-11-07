import 'package:components/component/custom_buttons/custom_elevated_button.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomErrorDialog extends StatelessWidget {
  const CustomErrorDialog({super.key, required this.msg, this.buttonLable});
  final String msg;
  final String? buttonLable;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      content: SizedBox(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset("assets/svg/error.svg"),
            Text(
              'Something went wrong',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Column(
              children: [
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(buttonLable ?? 'Okay',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
