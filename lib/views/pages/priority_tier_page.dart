import 'package:flutter/material.dart';
import 'package:frontend/data/priority_provider.dart';
import 'package:frontend/widgets/priorities_list_widget.dart';
import 'applications_restrictions_page.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<String?>(
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
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ApplicationsRestrictionsPage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(8), // Optional tap effect
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Makes it easier to tap
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Manage blocked apps",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.app_blocking, size: 30),
                    const SizedBox(width: 10),
                    const Icon(Icons.keyboard_arrow_right_outlined, size: 30), // Left-pointing arrow
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}