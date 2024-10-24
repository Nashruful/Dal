import 'package:components/components.dart';
import 'package:flutter/material.dart';

class ProfileInfoSection extends StatelessWidget {
  final String imgurl;
  final String firstName;
  final String lasrName;
  final String email;
  final Function() onPressed;
  const ProfileInfoSection(
      {super.key,
      required this.firstName,
      required this.lasrName,
      required this.email,
      required this.onPressed,
      required this.imgurl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 40,
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
                    '$firstName $lasrName',
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
            Expanded(
              child: IconButton(
                icon: Icon(Icons.edit, color: Theme.of(context).indicatorColor),
                iconSize: 18,
                onPressed: onPressed,
              ),
            )
          ],
        )
      ],
    );
  }
}

class FilterSection extends StatelessWidget {
  final Function(String) selectFilter;
  final Map<String, bool> categories;
  const FilterSection(
      {super.key, required this.selectFilter, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Filters',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Press to add or remove filter',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Wrap(
          spacing: 8.0,
          children: categories.keys.map((category) {
            return ChoiceChip(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                labelStyle: TextStyle(color: Color(0xffF7F7F7), fontSize: 14),
                label: Text(category),
                selected: categories[category]!,
                onSelected: (isSelected) => selectFilter(category),
                selectedColor: AppColors().green,
                backgroundColor: AppColors().grey2,
                showCheckmark: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
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
  });
  final Function(bool)? onChanged;
  final bool isOn;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appearance',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Row(
          children: [
            Text(
              isOn ? 'Dark Theme' : 'Light Theme',
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
      {super.key, required this.changeLang, required this.value});
  final Function(int?) changeLang;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Language',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CustomDrobDownButton(
            value: value,
            items: [
              const DropdownMenuEntry(
                value: 0,
                label: "English",
              ),
              const DropdownMenuEntry(value: 1, label: "العربية"),
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
      required this.onPressed});
  final String plan;
  final String planDesc;
  final String endDate;
  final int remainDays;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subscriptions',
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
                    padding: EdgeInsets.symmetric(vertical: 8),
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
                          value: remainDays.toDouble(),
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '${remainDays.toString()} Days',
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                                fontSize: 14),
                          ),
                          Text(
                            'Remain',
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
            child: Text('New Subscription Plan',
                style: TextStyle(fontSize: 14, color: AppColors().buttonLable)),
          ),
        )
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  final void Function() onPressed;
  const LogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
            onPressed: onPressed,
            child: Text('Logout',
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).dividerColor))),
      ),
    );
  }
}
