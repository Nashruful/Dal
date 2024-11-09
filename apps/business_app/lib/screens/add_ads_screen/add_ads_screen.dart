import 'package:business_app/screens/add_ads_screen/cubit/add_ads_cubit.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_text_field/custom_text_form_field.dart';
import 'package:components/components.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
        return Scaffold(
            appBar: CustomAppBar(
                title: 'Add Ads app bar'.tr(), automaticallyImplyLeading: true),
            body: BlocListener<AddAdsCubit, AddAdsState>(
              listener: (context, state) {
                if (state is LoadingState) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                          backgroundColor: Colors.transparent,
                          content: Lottie.asset(
                              height: 30, 'assets/json/loading.json')));
                }
                if (state is SuccessState) {
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Text('Successfully Added your ad!'.tr())));
                }
                if (state is ErrorState) {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomErrorDialog(msg: state.msg);
                      });
                }
              },
              child: Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ad type'.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 1,
                          maxLength: 50,
                          fillColor: Theme.of(context).canvasColor,
                          hintText: 'Ad type hint text'.tr(),
                          hintStyle: TextStyle(color: AppColors().grey2),
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
                        Text(
                          'Ad Category'.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        BlocBuilder<AddAdsCubit, AddAdsState>(
                          builder: (context, state) {
                            return CustomDropDownButton(
                              value: cubit.categoryValue,
                              items: [
                                DropdownMenuEntry(
                                    value: 0, label: "Markets".tr()),
                                DropdownMenuEntry(
                                    value: 1, label: "Dining".tr()),
                                DropdownMenuEntry(value: 2, label: "Gym".tr()),
                                DropdownMenuEntry(
                                    value: 3, label: "Fashion".tr()),
                                DropdownMenuEntry(
                                    value: 4, label: "Hotels".tr()),
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
                        Text(
                          'Ad Duration'.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        BlocBuilder<AddAdsCubit, AddAdsState>(
                          builder: (context, state) {
                            final dateText = (cubit.startDate != null &&
                                    cubit.endDate != null)
                                ? cubit.dateFormat(
                                    cubit.startDate!, cubit.endDate!)
                                : 'Select date range';
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: dateText,
                                  color: AppColors().grey2,
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
                                                slidersColor: AppColors().pink,
                                                leadingDateTextStyle: TextStyle(
                                                    color: AppColors().pink,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                currentDateTextStyle: TextStyle(
                                                    color: AppColors().pink,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                selectedCellsTextStyle:
                                                    TextStyle(
                                                        color: AppColors().pink,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                currentDateDecoration:
                                                    BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              AppColors().pink,
                                                        )),
                                                singleSelectedCellDecoration:
                                                    BoxDecoration(
                                                        color: AppColors().pink,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              AppColors().pink,
                                                        )),
                                                selectedCellsDecoration:
                                                    BoxDecoration(
                                                        color:
                                                            AppColors().grey),
                                                onRangeSelected: (value) {
                                                  cubit.startDate = value.start;
                                                  cubit.endDate = value.end;
                                                },
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 24),
                                                child: CustomElevatedButton(
                                                  onPressed: () {
                                                    cubit.selectAdsRangeDate(
                                                        cubit.startDate!,
                                                        cubit.endDate!);
                                                    Navigator.pop(context);
                                                  },
                                                  backgroundColor:
                                                      AppColors().pink,
                                                  child: CustomText(
                                                    text: 'Confirm button'.tr(),
                                                    color: AppColors().white1,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: CustomText(
                                    text: 'Change date'.tr(),
                                    color: AppColors().pink,
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
                        Text(
                          'Description'.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          fillColor: Theme.of(context).canvasColor,
                          hintStyle: TextStyle(color: AppColors().grey2),
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
                        Text(
                          'Location'.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        MultiDropdown(
                          controller: cubit.branchLocationController,
                          singleSelect: false,
                          enabled: true,
                          maxSelections: cubit.getBranchType(cubit.plan),
                          searchEnabled: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: cubit.selectedBranches.map((branch) {
                            return DropdownItem(
                                label: branch['address'].toString(),
                                value: cubit.selectedBranches.indexOf(branch));
                          }).toList(),
                          onSelectionChange: (selectedLocation) {
                            cubit.selectedBranch.clear();
                            for (var location in selectedLocation) {
                              if (location < cubit.selectedBranches.length) {
                                var branch = cubit.selectedBranches[location];
                                cubit.selectedBranch.add(branch['address']);
                              }
                            }
                          },
                          fieldDecoration: FieldDecoration(
                              hintText: 'Select a branch',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              backgroundColor: Theme.of(context).canvasColor),
                          dropdownDecoration: DropdownDecoration(
                              backgroundColor: Theme.of(context).canvasColor),
                          dropdownItemDecoration: DropdownItemDecoration(
                            textColor: AppColors().grey2,
                            backgroundColor: Theme.of(context).canvasColor,
                            selectedBackgroundColor: AppColors().white1,
                            selectedIcon: Icon(Icons.check_box_outlined,
                                color: AppColors().pink),
                          ),
                          chipDecoration: ChipDecoration(
                              wrap: false, backgroundColor: AppColors().green),
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
                        Text('Ad image'.tr(),
                            style: Theme.of(context).textTheme.bodyLarge),
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
                                      color: Theme.of(context).canvasColor,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            blurStyle: BlurStyle.outer,
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                            color: AppColors()
                                                .black1
                                                .withOpacity(0.25))
                                      ]),
                                  child: (state is AdsImageState &&
                                          state.image != null)
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                          backgroundColor: AppColors().pink,
                          onPressed: () async {
                            if (formKey.currentState?.validate() == true) {
                              cubit.addTypeController;
                              cubit.branchLocationController;
                              cubit.categoryValue;
                              cubit.descriptionController;
                              if (cubit.startDate == null &&
                                  cubit.endDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: AppColors().pink,
                                      content:
                                          Text('Please select a date'.tr())),
                                );
                              }
                              if (cubit.image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: AppColors().pink,
                                      content: Text(
                                          'Please select an ad image'.tr())),
                                );
                              }
                              await cubit.addAds();
                            }
                          },
                          child: Text(
                            'Post button'.tr(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
