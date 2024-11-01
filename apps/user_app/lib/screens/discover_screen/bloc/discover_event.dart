part of 'discover_bloc.dart';

@immutable
sealed class DiscoverEvent {}

final class LoadScreenEvent extends DiscoverEvent {
  final Position? position;
  final BuildContext context;

  LoadScreenEvent({required this.position, required this.context});
}

final class ErrorScreenEvent extends DiscoverEvent {
  final String msg;

  ErrorScreenEvent({required this.msg});
}
