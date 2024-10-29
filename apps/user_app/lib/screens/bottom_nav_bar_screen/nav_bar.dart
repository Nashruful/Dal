
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:animations/animations.dart';
// import 'package:user_app/screens/bottom_nav_bar_screen/bloc/nav_bar_bloc.dart';
// import 'package:user_app/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';
// import 'package:user_app/screens/discover_screen/discover_screen.dart';
// import 'package:user_app/screens/home_screen/home_screen.dart';
// import 'package:user_app/screens/profile_screen/profile_screen.dart';
// import 'package:user_app/screens/reminder_screen/reminder_screen.dart';

// class NavBar extends StatelessWidget {
//   const NavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => NavBarBloc(),
//       child: Builder(builder: (context) {
//         int selectedIndex = 0;
//         final List<Widget> widgetOptions = <Widget>[
//              const HomeScreen(),
//           const DiscoverScreen(),
//           ReminderScreen(),
//           const ProfileScreen()
//         ];
//         return BlocBuilder<NavBarBloc, NavBarState>(
//           builder: (context, state) {
//             if (state is BottomNavBarState) {
//               selectedIndex = state.index;
//             }
//             return Scaffold(
//               body: PageTransitionSwitcher(
//                 transitionBuilder: (widget, animation, secondaryAnimation) {
//                   return FadeThroughTransition(
//                     animation: animation,
//                     secondaryAnimation: secondaryAnimation,
//                     child: widget,
//                   );
//                 },
//                 child: widgetOptions[selectedIndex],
//               ),
//               bottomNavigationBar:  BottomNavBarScreen(),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
