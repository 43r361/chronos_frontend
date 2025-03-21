import 'package:flutter/material.dart';
import 'package:frontend/data/priority_provider.dart';

class PriorityListWidget extends StatelessWidget {
  final PriorityProvider priorityProvider;

  const PriorityListWidget({Key? key, required this.priorityProvider}) : super(key: key);

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
      priorityProvider.addPriority(newTierName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder<List<String>>(
            valueListenable: priorityProvider.priorities,
            builder: (context, priorityList, child) {
              return ListView.builder(
                itemCount: priorityList.length,
                itemBuilder: (context, index) {
                  return ValueListenableBuilder<String?>(
                    valueListenable: priorityProvider.selectedTier,
                    builder: (context, selectedTier, child) {
                      bool isSelected = selectedTier == priorityList[index];

                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(priorityList[index]),
                          trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                          onTap: () {
                            priorityProvider.setSelectedTier(priorityList[index]);

                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _addNewTier(context),
            child: const Row(
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
    );
  }
}