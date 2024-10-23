import 'package:components/component/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/screens/home_screen/home_screen.dart';
import 'bloc/nav_bar_bloc.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarBloc(),
      child: Builder(builder: (context) {
        int index = 0;
        List navBarPages = const [
          HomeScreen(),
        
         
          Icon(
            Icons.notifications,
            size: 150,
          ),
          Icon(
            Icons.person,
            size: 150,
          ),
        ];
        return BlocBuilder<NavBarBloc, NavBarState>(
          builder: (context, state) {
            if (state is BottomNavBarState) {
              index = state.index;
            }
            return Scaffold(
              bottomNavigationBar: CustomBottomNavBar(
                index: index,
                icons1: 'assets/svg/home.svg',
                icons2: 'assets/svg/discover.svg',
                icons3: 'assets/svg/profile.svg',
                icons4: 'assets/svg/profile.svg',
                label1: 'Home',
                label2: 'Discover',
                label3: 'Reminder',
                label4: 'Profile',
                onTap: (value) {
                  context
                      .read<NavBarBloc>()
                      .add(BottomNavBarEvent(index: value));
                },
              ),
              body: Center(
                child: navBarPages[index],
              ),
            );
          },
        );
      }),
    );
  }
}
