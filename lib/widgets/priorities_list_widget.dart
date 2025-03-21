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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}