import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApplicationsRestrictionsPage extends StatefulWidget {
  @override
  _ApplicationsRestrictionsPageState createState() =>
      _ApplicationsRestrictionsPageState();
}

class _ApplicationsRestrictionsPageState
    extends State<ApplicationsRestrictionsPage> {
  static const platform = MethodChannel('com.example.frontend/app_usage');
  Map<String, dynamic> _appUsageMap = {};
  Map<String, int> _appLimits = {};

  @override
  void initState() {
    super.initState();
    _getInstalledAppsWithUsage();
  }

  Future<void> _getInstalledAppsWithUsage() async {
    try {
      final Map<dynamic, dynamic> appsWithUsage =
          await platform.invokeMethod('getInstalledAppsWithUsage');
      setState(() {
        _appUsageMap = appsWithUsage.cast<String, dynamic>();
      });
    } on PlatformException catch (e) {
      print("Failed to get app usage: '${e.message}'.");
      if (Platform.isIOS) {
        // Handle iOS specific error, e.g., prompt user to enable Screen Time.
        // You might want to navigate to settings or show an alert.
        _showScreenTimeAlert();
      }
    }
  }

  void _showScreenTimeAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Screen Time Required'),
          content: Text(
              'Please enable Screen Time for this app to function properly.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Settings'),
              onPressed: () {
                platform.invokeMethod('openSettings');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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