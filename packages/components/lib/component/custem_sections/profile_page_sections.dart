import 'package:components/components.dart';
import 'package:flutter/material.dart';

class ProfileInfoSection extends StatelessWidget {
  final String imgurl;
  final String firstName;
  final String? lastName;
  final String email;
  final Widget child;
  const ProfileInfoSection(
      {super.key,
      required this.firstName,
      this.lastName,
      required this.email,
      required this.imgurl,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.network(
                  imgurl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$firstName $lastName',
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    email,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            const Spacer(),
            Expanded(child: child)
          ],
        )
      ],
    );
  }
}

class FilterSection extends StatelessWidget {
  final Function(String) selectFilter;
  final Map<String, dynamic> categories;
  final String text;
  final String subText;
  const FilterSection(
      {super.key,
      required this.selectFilter,
      required this.categories,
      required this.text,
      required this.subText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: Theme.of(context).textTheme.bodyLarge),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            subText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Wrap(
          spacing: 8.0,
          children: categories.keys.map((category) {
            return ChoiceChip(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                labelStyle:
                    const TextStyle(color: Color(0xffF7F7F7), fontSize: 14),
                label: Text(category),
                selected: categories[category]!,
                onSelected: (isSelected) => selectFilter(category),
                selectedColor: AppColors().green,
                backgroundColor: AppColors().grey2,
                showCheckmark: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.transparent,
                    )));
          }).toList(),
        ),
      ],
    );
  }
}

class AppearanceSection extends StatelessWidget {
  const AppearanceSection({
    super.key,
    required this.onChanged,
    required this.isOn,
    required this.text,
    required this.darkText,
    required this.lightText,
  });
  final Function(bool)? onChanged;
  final bool isOn;
  final String text;
  final String darkText;
  final String lightText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Row(
          children: [
            Text(
              isOn ? lightText : darkText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            Switch(
              value: !isOn,
              onChanged: onChanged,
              activeTrackColor: Theme.of(context).primaryColor,
              thumbColor: const WidgetStatePropertyAll(Colors.white),
              trackOutlineColor:
                  WidgetStatePropertyAll(Theme.of(context).canvasColor),
            ),
          ],
        )
      ],
    );
  }
}

class LanguageSection extends StatelessWidget {
  const LanguageSection(
      {super.key,
      required this.changeLang,
      required this.value,
      required this.text,
      required this.hintlabel,
      required this.label1,
      required this.label2});
  final Function(int?) changeLang;
  final int value;
  final String text;
  final String hintlabel;
  final String label1;
  final String label2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CustomDrobDownButton(
            value: value,
            items: [
              DropdownMenuEntry(
                value: 0,
                label: hintlabel,
              ),
              DropdownMenuEntry(
                value: 1,
                label: label1,
              ),
              DropdownMenuEntry(value: 2, label: label2),
            ].map((entry) {
              return DropdownMenuItem<int>(
                value: entry.value,
                child: Text(entry.label),
              );
            }).toList(),
            onChanged: changeLang,
          ),
        )
      ],
    );
  }
}

class PlanSection extends StatelessWidget {
  const PlanSection(
      {super.key,
      required this.plan,
      required this.planDesc,
      required this.endDate,
      required this.remainDays,
      required this.onPressed,
      required this.text,
      required this.daytext,
      required this.remainingDay,
      required this.subscription});
  final String plan;
  final String planDesc;
  final String endDate;
  final int remainDays;
  final void Function()? onPressed;
  final String text;
  final String daytext;
  final String remainingDay;
  final String subscription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(plan,
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).dividerColor)),
                  ),
                  Text(
                    planDesc,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          strokeWidth: 6,
                          value: remainDays.toDouble() / 30,
                          color: Theme.of(context).hintColor,
                          backgroundColor: Theme.of(context).canvasColor,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '${remainDays.toString()} $daytext',
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontSize: 14),
                          ),
                          Text(
                            remainingDay,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(endDate),
                  )
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CustomElevatedButton(
            onPressed: onPressed,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(subscription,
                style: TextStyle(fontSize: 14, color: AppColors().buttonLable)),
          ),
        )
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  final void Function() onPressed;
  const LogoutButton({super.key, required this.onPressed, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
            onPressed: onPressed,
            child: Text(text,
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).dividerColor))),
      ),
    );
  }
}
