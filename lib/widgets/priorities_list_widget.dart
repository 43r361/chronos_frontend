import 'package:flutter/material.dart';

class PriorityListWidget extends StatelessWidget {
  final List<String> priorities = [
    'Low Priority',
    'Medium Priority',
    'High Priority',
    'Critical Priority',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Priorities'),
      ),
      body: ListView.builder(
        itemCount: priorities.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              title: Text(priorities[index]),
              trailing: PopupMenuButton<String>(
                icon: Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  // Handle selection here
                  print('Selected: $value');
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Delete'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Mark as Completed',
                      child: Text('Mark as Completed'),
                    ),
                  ];
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
