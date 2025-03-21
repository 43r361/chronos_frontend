import 'package:flutter/material.dart';
import 'package:frontend/widgets/priorities_list_widget.dart';

class PriorityTierPage extends StatefulWidget {
  final String priority;

  const PriorityTierPage({super.key, required this.priority});

  @override
  _PriorityTierPageState createState() => _PriorityTierPageState();
}

class _PriorityTierPageState extends State<PriorityTierPage> {
  late String _currentPriority;

  @override
  void initState() {
    super.initState();
    _currentPriority = widget.priority;
  }

  void _updatePriority(String newPriority) {
    setState(() {
      _currentPriority = newPriority; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Priority Tier: $_currentPriority"),
      ),
      drawer: Drawer(
        child: PriorityListWidget(
          onPrioritySelected: (selectedPriority) {
            Navigator.pop(context);
            _updatePriority(selectedPriority);
          },
        ),
      ),
      body: Center(
        child: Text('Selected Priority: $_currentPriority'),
      ),
    );
  }
}