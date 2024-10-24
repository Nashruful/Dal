import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_ads_state.dart';

class AddAdsCubit extends Cubit<AddAdsState> {
  AddAdsCubit() : super(AddAdsInitial());

  TextEditingController addTypeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ImagePicker pick = ImagePicker();
  File? image;
  int locationValue = 0;
  int? categoeryValue = 0;
  DateTime? startDate;
  DateTime? endDate;

  Future<void> pickAdsImage() async {
    final XFile? imageFile = await pick.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      emit(AdsImageState(image: File(imageFile.path)));
    }
  }

  selectCategory(int value) {
    categoeryValue = value;
    emit(CategoryState(categoryValue: value));
  }

  selectLocation(int value) {
    locationValue = value;
    emit(LocationState(locationValue: value));
  }

  selectAdsRangeDate(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    emit(SelectDateState(startDate: startDate, endDate: endDate, image: image));
  }
}
