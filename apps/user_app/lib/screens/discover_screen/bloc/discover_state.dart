part of 'discover_bloc.dart';

@immutable
sealed class DiscoverState {}

final class DiscoverInitial extends DiscoverState {}

final class LoadingState extends DiscoverState {}

final class SuccessState extends DiscoverState {}

final class ErrorState extends DiscoverState {
  final String msg;

  ErrorState({required this.msg});
}