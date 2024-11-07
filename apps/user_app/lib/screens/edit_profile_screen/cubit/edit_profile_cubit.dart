import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/setup/setup.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  final supabase = getIt.get<DataLayer>().supabase;
  TextEditingController firstNameController = TextEditingController(
      text: getIt.get<DataLayer>().currentUserInfo!['first_name'] ?? 'First');
  TextEditingController lastNameController = TextEditingController(
      text: getIt.get<DataLayer>().currentUserInfo!['last_name'] ?? 'Last');
  ImagePicker pick = ImagePicker();

  Future<void> pickAdsImage() async {
    final XFile? imageFile = await pick.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      final File image = File(imageFile.path);
      await supabase.storage
          .from('user profile images')
          .upload('images/${imageFile.name}', image);

      final getUrl = await supabase.storage
          .from('user profile images')
          .getPublicUrl('images/${imageFile.name}');
      // add image to users table
      await supabase.from('users').update({'profile_image': getUrl}).eq(
          'id', supabase.auth.currentUser!.id);
      emit(AdsImageState(image: image));
    } else {}
  }

  Future<void> changeName(String firstName, String lastName) async {
    try {
      emit(LoadingState());
      await supabase
          .from('users')
          .update({'first_name': firstName, 'last_name': lastName}).eq(
              'id', supabase.auth.currentUser!.id);
      emit(SuccessState());
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    return super.close();
  }
}
