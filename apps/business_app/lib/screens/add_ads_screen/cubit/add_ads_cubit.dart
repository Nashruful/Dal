import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'add_ads_state.dart';

class AddAdsCubit extends Cubit<AddAdsState> {
  AddAdsCubit() : super(AddAdsInitial());

  TextEditingController addTypeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  MultiSelectController<int>? branchLocationController =
      MultiSelectController();

  final supabase = getIt.get<DataLayer>().supabase;
  final branches = getIt.get<DataLayer>().businessBranches;
  final selectedBranches =
      getIt.get<DataLayer>().businessBranches.where((branch) {
    return branch['selected'] == true;
  }).toList();
  Map plan = getIt.get<DataLayer>().latestSubscription;

  ImagePicker pick = ImagePicker();
  File? image;
  List selectedBranch = [];
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
    } else {}
  }

  Future<void> uploadImage(XFile imageFile) async {
    try {
      await supabase.storage
          .from('offer images')
          .upload(imageFile.name, image!);

      getUrl =
          supabase.storage.from('offer images').getPublicUrl(imageFile.name);
      emit(AdsImageState(image: image!));
    } catch (e) {
      emit(ErrorState(msg: 'Image upload failed'));
    }
  }

  selectCategory(int value) {
    categoryValue = value;
    emit(CategoryState(categoryValue: value));
  }

  selectAdsRangeDate(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;

    emit(SelectDateState(startDate: startDate, endDate: endDate));
  }

  String dateFormat(DateTime start, DateTime end) {
    String displayDate =
        '${start.day.toString().padLeft(2, '0')}/${start.month.toString().padLeft(2, '0')}/${start.year} - ${end.day.toString().padLeft(2, '0')}/${end.month.toString().padLeft(2, '0')}/${end.year}';
    return displayDate;
  }

  // add ads method
  Future<void> addAds() async {
    emit(LoadingState());
    try {
      // format date as in supabase
      final String startDateFormat = startDate!.toIso8601String();
      final String endDateFormat = endDate!.toIso8601String();

      // categories labels
      final categoryLabel = getIt.get<DataLayer>().categories[categoryValue];

      // upload image to storage
      await uploadImage(imageFile!);

      if (selectedBranch.isNotEmpty) {
        // get branch ids for selected branches
        final branchIds = getIt
            .get<DataLayer>()
            .businessBranches
            .where((branch) => selectedBranch.contains(branch['address']))
            .map((branch) => branch['id'])
            .toList();

        for (var branchId in branchIds) {
          // Insert into ad table for each branch
          await supabase.from('ad').insert({
            "branch_id": branchId,
            "category": categoryLabel,
            "description": descriptionController.text,
            "bannerimg": getUrl,
            "startdate": startDateFormat,
            "enddate": endDateFormat,
            "offer_type": addTypeController.text,
            'clicks': 0,
            'views': 0,
          });
          await supabase
              .from("branch")
              .update({"selected": true}).eq("id", branchId);

          print('ads add successfully');
        }
      } else {
        print('failed to add');
      }
      emit(SuccessState());
    } on AuthException catch (e) {
      if (!isClosed) {
        emit(ErrorState(msg: e.message));
      }
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  int getBranchType(Map plan) {
    final int numOfAdsPerBranch;
    if (plan['subscription_type'] == 'Enterprise') {
      numOfAdsPerBranch = 100;
    } else if (plan['subscription_type'] == 'Premium') {
      numOfAdsPerBranch = 5;
    } else {
      //basic
      numOfAdsPerBranch = 1;
    }
    return numOfAdsPerBranch;
  }
}
