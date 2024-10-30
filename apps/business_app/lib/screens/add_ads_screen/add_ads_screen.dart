import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/add_ads_screen/cubit/add_ads_cubit.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/component/custom_text_field/custom_text_form_field.dart';
import 'package:components/components.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class AddAdsScreen extends StatelessWidget {
  const AddAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAdsCubit(),
      child: Builder(builder: (context) {
        final formKey = GlobalKey<FormState>();
        final cubit = context.read<AddAdsCubit>();
        DateTime? startDate;
        DateTime? endDate;
        final branches = getIt.get<DataLayer>().businessBranches;
        print("-------------branches $branches");
        return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xffA51361),
              foregroundColor: const Color(0xffF7F7F7),
              title: const Text('Add Ads app bar').tr(),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Ad type'.tr(),
                        color: const Color(0xff444444),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: 1,
                        maxLength: 50,
                        fillColor: const Color(0xffEAEAEA),
                        hintText: 'Ad type hint text'.tr(),
                        hintStyle: const TextStyle(color: Color(0xff848484)),
                        controller: cubit.addTypeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter ad type';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: 'Ad Category'.tr(),
                        color: const Color(0xff444444),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<AddAdsCubit, AddAdsState>(
                        builder: (context, state) {
                          return CustomDrobDownButton(
                            value: cubit.categoryValue,
                            items: [
                              DropdownMenuEntry(
                                  value: 0, label: "Markets".tr()),
                              DropdownMenuEntry(value: 1, label: "Dining".tr()),
                              DropdownMenuEntry(value: 2, label: "Gym".tr()),
                              DropdownMenuEntry(
                                  value: 3, label: "Clothes".tr()),
                              DropdownMenuEntry(value: 4, label: "Hotels".tr()),
                            ].map((entry) {
                              return DropdownMenuItem<int>(
                                value: entry.value,
                                child: Text(entry.label),
                              );
                            }).toList(),
                            onChanged: (int? value) {
                              if (value != null) {
                                cubit.selectCategory(value);
                              }
                            },
                          );
                        },
                      ),
                      // ads duration
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: 'Ad Duration'.tr(),
                        color: const Color(0xff444444),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      BlocBuilder<AddAdsCubit, AddAdsState>(
                        builder: (context, state) {
                          final dateText =
                              (startDate != null && endDate != null)
                                  ? cubit.dateFormat(startDate!, endDate!)
                                  : 'Select date range';
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: dateText,
                                color: const Color(0xff848484),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              // --------------- date --------------
                              TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            RangeDatePicker(
                                              maxDate: DateTime(2030),
                                              minDate: DateTime(2020),
                                              slidersColor:
                                                  const Color(0xffA51361),
                                              leadingDateTextStyle:
                                                  const TextStyle(
                                                      color: Color(0xffA51361),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                              currentDateTextStyle:
                                                  const TextStyle(
                                                      color: Color(0xffA51361),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                              selectedCellsTextStyle:
                                                  const TextStyle(
                                                      color: Color(0xffA51361),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                              currentDateDecoration:
                                                  BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xffA51361))),
                                              singleSelectedCellDecoration:
                                                  BoxDecoration(
                                                      color: const Color(
                                                          0xffA51361),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xffA51361))),
                                              selectedCellsDecoration:
                                                  const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 211, 182, 198),
                                              ),
                                              onRangeSelected: (value) {
                                                startDate = value.start;
                                                endDate = value.end;
                                              },
                                            ),
                                            CustomElevatedButton(
                                              onPressed: () {
                                                cubit.selectAdsRangeDate(
                                                    startDate!, endDate!);
                                                Navigator.pop(context);
                                              },
                                              backgroundColor:
                                                  const Color(0xffA51361),
                                              child: CustomText(
                                                text: 'Confirm button'.tr(),
                                                color: const Color(0xffF7F7F7),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: CustomText(
                                  text: 'Change date'.tr(),
                                  color: const Color(0xffA51361),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        text: 'Description'.tr(),
                        color: const Color(0xff444444),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        fillColor: const Color(0xffEAEAEA),
                        hintStyle: const TextStyle(color: Color(0xff848484)),
                        maxLines: 4,
                        maxLength: 150,
                        controller: cubit.descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: 'Location'.tr(),
                        color: const Color(0xff444444),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      MultiDropdown(
                        controller: cubit.branchLocationController,
                        singleSelect: false,
                        enabled: true,
                        maxSelections:
                            2, // add a condition based on subscription
                        searchEnabled: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        items: branches.map((branch) {
                          return DropdownItem(
                              label: branch['address'].toString(),
                              value: branches.indexOf(branch));
                        }).toList(),
                        onSelectionChange: (selectedLocation) {
                          cubit.selectedBranch.clear();
                          for (var location in selectedLocation) {
                            if (location < branches.length) {
                              var branch = branches[location];
                              cubit.selectedBranch.add(branch['address']);
                              print(cubit.selectedBranch);
                            }
                          }
                        },
                        fieldDecoration: FieldDecoration(
                            hintText: 'Select a branch',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            backgroundColor: Color(0xffEAEAEA)),
                        dropdownDecoration: const DropdownDecoration(
                            backgroundColor: Color(0xffEAEAEA)),
                        dropdownItemDecoration: const DropdownItemDecoration(
                          backgroundColor: Color(0xffEAEAEA),
                          selectedBackgroundColor: Color(0xffEAEAEA),
                          selectedIcon: Icon(Icons.check_box_outlined,
                              color: Color(0xffA51361)),
                        ),
                        chipDecoration: const ChipDecoration(
                            wrap: false, backgroundColor: Color(0xff8CBFAE)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a branch';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: 'Ad image'.tr(),
                        color: const Color(0xff444444),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // -------------------- image picker ---------------
                      BlocBuilder<AddAdsCubit, AddAdsState>(
                        builder: (context, state) {
                          return GestureDetector(
                              onTap: () async {
                                cubit.pickAdsImage();
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                height: 172,
                                width: 172,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          blurStyle: BlurStyle.outer,
                                          blurRadius: 4,
                                          offset: const Offset(0, 1),
                                          color: const Color(0xff000000)
                                              .withOpacity(0.25))
                                    ]),
                                child: (state is AdsImageState &&
                                        state.image != null)
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          state.image!,
                                          fit: BoxFit.cover,
                                        ))
                                    : const Icon(Icons.photo),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // ---------------- button --------------
                      CustomElevatedButton(
                        backgroundColor: const Color(0xffA51361),
                        onPressed: () async {
                          if (formKey.currentState?.validate() == true) {
                            cubit.branchLocationController;
                            cubit.addTypeController;
                            cubit.descriptionController;
                            cubit.addAds();
                          }
                        },
                        child: CustomText(
                          text: 'Post button'.tr(),
                          color: const Color(0xffF7F7F7),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
