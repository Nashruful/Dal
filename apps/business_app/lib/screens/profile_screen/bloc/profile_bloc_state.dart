part of 'profile_bloc_bloc.dart';

@immutable
sealed class ProfileBlocState {}

final class ProfileBlocInitial extends ProfileBlocState {}

final class UpdatedFilterState extends ProfileBlocState {}

final class ChangedModeState extends ProfileBlocState {}

final class ChangedlangState extends ProfileBlocState {

}