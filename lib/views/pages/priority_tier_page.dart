import 'package:flutter/material.dart';
import 'package:frontend/data/priority_provider.dart';
import 'package:frontend/widgets/priorities_list_widget.dart';

class PriorityTierPage extends StatelessWidget {
  final PriorityProvider priorityProvider = PriorityProvider();

  PriorityTierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<String?>(
          valueListenable: priorityProvider.selectedTier,
          builder: (context, selectedTier, child) {
            return Text(
              selectedTier ?? "Select a Priority",
              style: const TextStyle(fontSize: 20),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: PriorityListWidget(priorityProvider: priorityProvider),
      ),
      body: Center(
        child: ValueListenableBuilder<String?>(
          valueListenable: priorityProvider.selectedTier,
          builder: (context, selectedTier, child) {
            return Text(
              selectedTier != null
                  ? "Selected Priority: $selectedTier"
                  : "No Priority Selected",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
    );
  }
}