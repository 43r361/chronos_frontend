import 'package:flutter/material.dart';
import 'package:frontend/widgets/priorities_list_widget.dart';
import 'package:frontend/data/priority_provider.dart';

class EventPrioritiesPage extends StatefulWidget {
  const EventPrioritiesPage({super.key});

  @override
  _EventPrioritiesPageState createState() => _EventPrioritiesPageState();
}

class _EventPrioritiesPageState extends State<EventPrioritiesPage> {
  final PriorityProvider priorityProvider = PriorityProvider(); // Use provider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Priorities')),
      body: Column(
        children: [
          Expanded(
            child: PriorityListWidget(priorityProvider: priorityProvider),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ValueListenableBuilder<String?>(
              valueListenable: priorityProvider.selectedTier,
              builder: (context, selectedTier, child) {
                return Text(
                  selectedTier != null ? "Selected Priority: $selectedTier" : "No Priority Selected",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

