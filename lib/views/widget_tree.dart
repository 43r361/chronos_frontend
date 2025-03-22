import 'package:flutter/material.dart';
import 'package:frontend/views/pages/calendar_page.dart';
import 'package:frontend/views/pages/priority_tier_page.dart';
import 'package:frontend/views/pages/login_page.dart';
import 'package:frontend/views/pages/home_page.dart';
import 'package:frontend/widgets/navbar_widget.dart';

import '../data/notifiers.dart';

List<Widget> pages = [HomePage(), CalendarPage(), PriorityTierPage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, index, child) => pages.elementAt(index),
      ),
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (context, index, child) {
            String title;
            switch (index) {
            case 0:
              title = "Home";
              break;
            case 1:
              title = "Calendar";
              break;
            case 2:
              title = "Priority Tier";
             break;
           default:
              title = "Chronos";
            }
          return Text(title);
          },
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              isDarkTheme.value = !isDarkTheme.value;
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkTheme,
              builder: (context, val, child) {
                if (val == true) {
                  return Icon(Icons.light_mode);
                } else {
                  return Icon(Icons.dark_mode);
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
