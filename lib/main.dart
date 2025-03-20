import 'package:flutter/material.dart';
import 'package:frontend/data/notifiers.dart';
import 'package:frontend/views/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkTheme,
      builder: (context, val, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WidgetTree(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness:
                  isDarkTheme.value ? Brightness.dark : Brightness.light,
            ),
          ),
        );
      },
    );
  }
}
