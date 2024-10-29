part of 'profile_bloc_bloc.dart';

@immutable
sealed class ProfileBlocEvent {}

final class UpdateFilterEvent extends ProfileBlocEvent {
  final String category;

  UpdateFilterEvent({required this.category});
}

final class ChangeModeEvent extends ProfileBlocEvent {
}


final class ChangeLangEvent extends ProfileBlocEvent {
    final int value;

  ChangeLangEvent({required this.value});
}