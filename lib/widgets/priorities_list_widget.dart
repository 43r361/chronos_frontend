import 'package:flutter/material.dart';

class PriorityListWidget extends StatefulWidget {
  final Function(String) onPrioritySelected;

  const PriorityListWidget({Key? key, required this.onPrioritySelected}) : super(key: key);

  @override
  _PriorityListWidgetState createState() => _PriorityListWidgetState();
}

class _PriorityListWidgetState extends State<PriorityListWidget> {
  List<String> priorities = [
    'Low Priority',
    'Medium Priority',
    'High Priority',
    'Critical Priority',
  ];

<<<<<<< HEAD
  Future<String?> _showAddTierDialog(BuildContext context) async {
  TextEditingController controller = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add New Priority Tier'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter tier name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Navigator.pop(context, controller.text.trim());
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

  Future<void> _addNewTier(BuildContext context) async {
    String? newTierName = await _showAddTierDialog(context);

    if (newTierName != null && newTierName.isNotEmpty) {
      setState(() {
        priorities.add(newTierName!);
          print('Updated Priorities: $priorities');
      });

      widget.onPrioritySelected(newTierName!);
    }
  }
=======
  PriorityListWidget({super.key});
>>>>>>> 4364b6ae6d41847d35af7de07e5fe460983c42f8

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        title: Text('Event Priorities'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: priorities.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    title: Text(priorities[index]),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    onTap: () {
                      widget.onPrioritySelected(priorities[index]);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _addNewTier(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Add New Tier'),
                ],
=======
      appBar: AppBar(title: Text('Event Priorities')),
      body: ListView.builder(
        itemCount: priorities.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              title: Text(priorities[index]),
              trailing: PopupMenuButton<String>(
                icon: Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  // Handle selection here
                  print('Selected: $value');
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(value: 'Edit', child: Text('Edit')),
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
>>>>>>> 4364b6ae6d41847d35af7de07e5fe460983c42f8
              ),
            ),
          ),
        ],
      ),
    );
  }
}