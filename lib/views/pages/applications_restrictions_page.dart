import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApplicationsRestrictionsPage extends StatefulWidget {
  @override
  _ApplicationsRestrictionsPageState createState() => _ApplicationsRestrictionsPageState();
}

class _ApplicationsRestrictionsPageState extends State<ApplicationsRestrictionsPage> {
  static const platform = MethodChannel('com.example.frontend/app_usage');
  Map<String, dynamic> _appUsageMap = {};

  @override
  void initState() {
    super.initState();
    _getInstalledAppsWithUsage();
  }

  Future<void> _getInstalledAppsWithUsage() async {
    try {
      final Map<dynamic, dynamic> appsWithUsage = await platform.invokeMethod('getInstalledAppsWithUsage');
      setState(() {
        _appUsageMap = appsWithUsage.cast<String, dynamic>();
      });
    } on PlatformException catch (e) {
      print("Failed to get app usage: '${e.message}'.");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage'),
      ),
      body: ListView.builder(
        itemCount: _appUsageMap.length,
        itemBuilder: (context, index) {
          final app = _appUsageMap.keys.elementAt(index);
          final usage = _appUsageMap[app];
          return ListTile(
            title: Text(app),
            subtitle: Text('Usage: ${usage}ms'),
          );
        },
      ),
    );
  }
}