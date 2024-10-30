part of 'discover_bloc.dart';

@immutable
sealed class DiscoverEvent {}

final class LoadScreenEvent extends DiscoverEvent {
  final Position? position;

  LoadScreenEvent({required this.position});
}

final class ErrorScreenEvent extends DiscoverEvent {
  final String msg;

  ErrorScreenEvent({required this.msg});
}
