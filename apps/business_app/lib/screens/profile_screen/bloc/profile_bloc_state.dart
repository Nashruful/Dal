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

final class ChangedlangState extends ProfileBlocState {

}
