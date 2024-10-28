part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class LoadingState extends EditProfileState {}

final class SuccessState extends EditProfileState {}

final class ErrorState extends EditProfileState {
  final String msg;
  ErrorState({required this.msg});
}
final class AdsImageState extends EditProfileState {
  final File? image;
  AdsImageState({required this.image});
}

final class ChangeNameState extends EditProfileState {
  final String name;
  ChangeNameState({required this.name});
}