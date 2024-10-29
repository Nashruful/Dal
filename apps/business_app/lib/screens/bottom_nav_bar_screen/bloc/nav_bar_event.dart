part of 'nav_bar_bloc.dart';

@immutable
sealed class NavBarEvent {}

final class BottomNavBarEvent extends NavBarEvent {
  final int index;
  BottomNavBarEvent({required this.index});
}
