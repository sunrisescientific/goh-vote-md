import 'package:flutter/material.dart';
import '../data/constants.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: MARYLAND_RED,
        indicatorColor: Colors.transparent,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(
                color: SELECTED,
                size: navIconSize,
              );
            }
            return IconThemeData(
              color: UNSELECTED,
              size: navIconSize,
            );
          },
        ),
      ),
      child: selectedIndex == 0
          ? const SizedBox(height: 0)
          : NavigationBar(
              selectedIndex: selectedIndex == 7 ? 0 : selectedIndex,
              onDestinationSelected: onItemTapped,
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              labelTextStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: navLabelSize,
                  color: Colors.white,
                ),
              ),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.person), label: 'Look up'),
                NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Calendar'),
                NavigationDestination(icon: Icon(Icons.campaign), label: 'Report'),
                NavigationDestination(icon: Icon(Icons.phone), label: 'Contact'),
                NavigationDestination(icon: Icon(Icons.link), label: 'Links'),
                NavigationDestination(icon: Icon(Icons.location_on), label: 'Locations'),
              ],
            ),
    );
  }
}
