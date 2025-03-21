import 'package:flutter/material.dart';

class PriorityProvider {
  final ValueNotifier<List<String>> priorities = ValueNotifier([
    'Low Priority',
    'Medium Priority',
    'High Priority',
    'Critical Priority',
  ]);

  final ValueNotifier<String?> selectedTier = ValueNotifier(null);

  void addPriority(String newPriority) {
    priorities.value = List.from(priorities.value)..add(newPriority);
  }

  void setSelectedTier(String tier) {
    selectedTier.value = tier;
  }
}