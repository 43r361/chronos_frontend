import 'package:flutter/material.dart';
import 'package:frontend/widgets/priorities_list_widget.dart';

class EventPrioritiesPage extends StatefulWidget{
  @override
  _EventPrioritiesPageState createState() => _EventPrioritiesPageState();
}

class _EventPrioritiesPageState extends State<EventPrioritiesPage> {
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
  }
}