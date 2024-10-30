part of 'profile_bloc_bloc.dart';

@immutable
sealed class ProfileBlocState {}

final class ProfileBlocInitial extends ProfileBlocState {}

final class LoadingState extends ProfileBlocState {}

final class SuccessState extends ProfileBlocState {}

final class ErrorState extends ProfileBlocState {
  final String msg;
  ErrorState({required this.msg});
}
final class UpdatedFilterState extends ProfileBlocState {}

final class ChangedModeState extends ProfileBlocState {}

final class ChangedlangState extends ProfileBlocState {

}

final class GetInfoState extends ProfileBlocState {
  final String name;
  final String email;
  final String image;
  GetInfoState(
      {required this.name,
      required this.email,
      required this.image});
}