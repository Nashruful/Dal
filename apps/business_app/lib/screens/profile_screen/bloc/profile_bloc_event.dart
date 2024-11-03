part of 'profile_bloc_bloc.dart';

@immutable
sealed class ProfileBlocEvent {}

final class ChangeLangEvent extends ProfileBlocEvent {
    final int value;

  ChangeLangEvent({required this.value});
}

final class RefreshScreenEvent extends ProfileBlocEvent {
}