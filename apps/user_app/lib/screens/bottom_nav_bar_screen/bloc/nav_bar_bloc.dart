import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  final PageController pageController = PageController(initialPage: 0 );
  final NotchBottomBarController notchBottomBarController =
      NotchBottomBarController(index: 0);
  NavBarBloc() : super(NavBarInitial()) {
    on<NavBarEvent>((event, emit) {
    });

    on<BottomNavBarEvent>((event, emit) {
      emit(BottomNavBarState(index: event.index));
    });
  }
}
