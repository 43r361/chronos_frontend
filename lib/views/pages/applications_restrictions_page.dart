import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/data/app_model.dart';
import 'package:frontend/data/available_applications.dart';

class ApplicationsRestrictionsPage extends StatefulWidget {
  @override
  _ApplicationsRestrictionsPageState createState() =>
      _ApplicationsRestrictionsPageState();
}

class _ApplicationsRestrictionsPageState
    extends State<ApplicationsRestrictionsPage> {
  static const platform = MethodChannel('com.example.frontend/app_management');
  List<String> _appList = [];

  @override
  void initState() {
    super.initState();
    _checkPlatformAndInitialize();
  }

  Future<void> _checkPlatformAndInitialize() async {
    if (Platform.isAndroid) {
      await _getInstalledApps(); // Call method for Android
    } else if (Platform.isIOS) {
      await _openSettings(); // Open settings for iOS
    }
  }

  Future<void> _getInstalledApps() async {
    try {
      final List<dynamic> appList = await platform.invokeMethod('getInstalledApps');
      setState(() {
        _appList = appList.cast<String>();
      });
      // Directly update AvailableApplications without Provider
      AvailableApplications availableApps = AvailableApplications();
      availableApps.apps.clear();
      for (final appName in _appList) {
        availableApps.addApp(AppModel(
            name: appName, showingNotifications: false, allowedUsing: true));
      }
      // You may need to find a way to update the UI if AvailableApplications is not a ChangeNotifier
    } on PlatformException catch (e) {
      print("Failed to get app list: '${e.message}'.");
    }
  }

  Future<void> _openSettings() async {
    try {
      await platform.invokeMethod('openSettings');
    } on PlatformException catch (e) {
      print("Failed to open settings: '${e.message}'.");
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Apps'),
      ),
      body: _appList.isEmpty
          ? Center(
              child: Platform.isIOS
                  ? Text('Please enable Screen Time in Settings.')
                  : Text('No apps found.'),
            )
          : ListView.builder(
              itemCount: _appList.length,
              itemBuilder: (context, index) {
                final app = _appList[index];
                return ListTile(
                  title: Text(app),
                );
              },
            ),
    );
  }
}