import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'add_ads_state.dart';

class AddAdsCubit extends Cubit<AddAdsState> {
  AddAdsCubit() : super(AddAdsInitial());

  TextEditingController addTypeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final supabase = getIt.get<DataLayer>().supabase;

  ImagePicker pick = ImagePicker();
  File? image;
  int locationValue = 0;
  int? categoryValue = 0;
  DateTime? startDate;
  DateTime? endDate;
  String? getUrl;
  XFile? imageFile;

  Future<void> pickAdsImage() async {
    imageFile = await pick.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      image = File(imageFile!.path);
      emit(AdsImageState(image: image));
    } else {
      print('No image selected');
    }
  }

  Future<void> uploadImage(XFile imageFile) async {
    try {
      final uploadResult = await supabase.storage
          .from('offer images')
          .upload(imageFile.name, image!);

      print('Image uploaded successfully: $uploadResult');
      getUrl = await supabase.storage
          .from('offer images')
          .getPublicUrl(imageFile.name);
      print(getUrl);
      emit(AdsImageState(image: image!));
    } catch (e) {
      print('Image upload failed: $e');
      emit(ErrorState(msg: 'Image upload failed'));
    }
  }

  selectCategory(int value) {
    categoryValue = value;
    emit(CategoryState(categoryValue: value));
  }

  selectLocation(int value) {
    locationValue = value;
    emit(LocationState(locationValue: value));
  }

  selectAdsRangeDate(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    print(startDate);
    print(endDate);
    emit(SelectDateState(startDate: startDate, endDate: endDate));
  }

  String dateFormat(DateTime start, DateTime end) {
    String displayDate =
        '${start.year}/${start.month.toString().padLeft(2, '0')}/${start.day.toString().padLeft(2, '0')} - ${end.year}/${end.month.toString().padLeft(2, '0')}/${end.day.toString().padLeft(2, '0')}';
    return displayDate;
  }

  // add ads
  // so messy i know :(, i hope the comment is good for clarification
  Future<void> addAds() async {
    try {
      // get business info
      final businessInfo = await supabase
          .from('business')
          .select()
          .eq('id',
              '5e84d2bf-4c17-4483-9eab-c017767b58bc') // ***** change the id ****
          .single();
      print('businessInfo $businessInfo');

      final title = businessInfo['name'];
      print('title $title');
      final businessLogo = businessInfo['logo_img'];
      print('businessLogo $businessLogo');
      if (title == null) {
        print("title is null");
      }

      if (businessLogo == null) {
        print("businessLogo is null");
      }

      // get branch info // we need it later
      final branchInfo = await supabase
          .from('branch')
          .select()
          .eq('id',
              '274d1a55-c8a7-4041-be4b-0131be227072') // ***** change the id ****
          .single();

      final location = branchInfo['address'];
      if (location == null) {
        print("location is null");
      }
      print(location);
      print('-------------');

      // format date as in supabase
      final String startDateFormat = startDate!.toIso8601String();
      final String endDateFormat = endDate!.toIso8601String();

      // categories labels
      final categoryLabel = getIt.get<DataLayer>().categories[categoryValue];
      print(categoryLabel);

      // upload image to storage
      await uploadImage(imageFile!);

      // insert into ad table
      await supabase.from('ad').insert({
        "branch_id": '274d1a55-c8a7-4041-be4b-0131be227072',
        "category": categoryLabel,
        "title": title,
        "description": descriptionController.text,
        "bannerimg": getUrl,
        "startdate": startDateFormat,
        "enddate": endDateFormat,
        "offer_type": addTypeController.text,
        'clicks': null
      });

      print("success");
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
      print(e.message);
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
      print(e.message);
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }
}
