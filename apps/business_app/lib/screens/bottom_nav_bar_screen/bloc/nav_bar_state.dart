part of 'nav_bar_bloc.dart';

@immutable
sealed class NavBarState {}

final class NavBarInitial extends NavBarState {}

class LoadingState extends NavBarState {}

class SuccessState extends NavBarState {}

class ErrorState extends NavBarState {
  final String msg;
  ErrorState({required this.msg});
}

class BottomNavBarState extends NavBarState {
  final int index;
  BottomNavBarState({required this.index});
}
