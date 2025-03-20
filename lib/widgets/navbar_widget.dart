import 'package:flutter/material.dart';
import 'package:frontend/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pageIndex,
      builder: (context, newPageIndex, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "home"),
            NavigationDestination(
              icon: Icon(Icons.edit_calendar),
              label: "calendar",
            ),
          ],
          selectedIndex: newPageIndex,
          onDestinationSelected: (int value) {
            pageIndex.value = value;
          },
        );
      },
    );
  }
}
