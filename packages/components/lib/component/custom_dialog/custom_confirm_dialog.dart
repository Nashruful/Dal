import 'package:components/component/custom_buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {super.key,
      required this.title,
      required this.msg,
      required this.onPressed,
      this.buttonLabel, required this.cancelLable});
  final String title;
  final String msg;
  final Function() onPressed;
  final String? buttonLabel;
  final String cancelLable;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      content: SizedBox(
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset("assets/svg/confirm.svg"),
            Text(
              title,
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
                  onPressed: onPressed,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    buttonLabel ?? 'Remind Me',
                    style: const TextStyle(color:  Color(0xffF7F7F7), fontSize: 14),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    cancelLable,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 14),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
