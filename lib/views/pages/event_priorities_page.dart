import 'package:flutter/material.dart';
import 'package:frontend/widgets/priorities_list_widget.dart';

class EventPrioritiesPage extends StatefulWidget {
  const EventPrioritiesPage({super.key});

  @override
  _EventPrioritiesPageState createState() => _EventPrioritiesPageState();
}

class _EventPrioritiesPageState extends State<EventPrioritiesPage> {
<<<<<<< HEAD
  String? selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Priorities'),
      ),
      body: PriorityListWidget(
        onPrioritySelected: (priority) {
          setState(() {
            selectedPriority = priority;
          });
          print('Selected Priority: $priority');
        },
      ),
    );
=======
  @override
  Widget build(BuildContext context) {
    return PriorityListWidget();
>>>>>>> 4364b6ae6d41847d35af7de07e5fe460983c42f8
  }
}
