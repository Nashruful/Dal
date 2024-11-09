part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingState extends AuthState {}

final class SuccessState extends AuthState {}

final class ReSendOtpSuccessState extends AuthState {}

final class ErrorState extends AuthState {
  final String msg;
  ErrorState({required this.msg});
}
