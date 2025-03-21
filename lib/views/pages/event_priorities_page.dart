import 'package:flutter/material.dart';
import 'package:frontend/widgets/priorities_list_widget.dart';

class EventPrioritiesPage extends StatefulWidget {
  const EventPrioritiesPage({super.key});

  @override
  _EventPrioritiesPageState createState() => _EventPrioritiesPageState();
}

class _EventPrioritiesPageState extends State<EventPrioritiesPage> {
  @override
  Widget build(BuildContext context) {
    return PriorityListWidget();
  }
}
