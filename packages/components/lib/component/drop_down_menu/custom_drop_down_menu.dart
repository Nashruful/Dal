import 'package:components/component/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class CustomMultipleDropDownMenu extends StatelessWidget {
  const CustomMultipleDropDownMenu({super.key, this.controller, required this.maxSelections, required this.items, this.onSelectionChange, this.hintText, this.validator});
  final MultiSelectController<Object>? controller;
  final int maxSelections;
  final List<DropdownItem<Object>> items;
  final dynamic Function(List<dynamic>)? onSelectionChange;
  final String? hintText;
  final String? Function(List<DropdownItem<Object>>?)? validator;
  @override
  Widget build(BuildContext context) {
    return MultiDropdown(
                                              controller:
                                                  controller,
                                              singleSelect: false,
                                              enabled: true,
                                              maxSelections:
                                                  maxSelections,
                                              searchEnabled: true,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              items:items,
                                              onSelectionChange:onSelectionChange,
                                              fieldDecoration: FieldDecoration(
                                                  hintText:
                                                      hintText,
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          BorderSide.none),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .canvasColor),
                                              dropdownDecoration:
                                                  DropdownDecoration(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .canvasColor),
                                              dropdownItemDecoration:
                                                  DropdownItemDecoration(
                                                textColor: AppColors().grey2,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .canvasColor,
                                                selectedBackgroundColor:
                                                    AppColors().white1,
                                                selectedIcon: Icon(
                                                    Icons.check_box_outlined,
                                                    color: AppColors().pink),
                                              ),
                                              chipDecoration: ChipDecoration(
                                                  wrap: false,
                                                  backgroundColor:
                                                      AppColors().green),
                                              validator: validator,
                                            );
  }
}