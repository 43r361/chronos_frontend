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
  List<AppModel> _appModels = [];
  bool _isLoading = true; // Add loading state

  @override
  void initState() {
    super.initState();
    _checkPlatformAndInitialize();
  }

  Future<void> _checkPlatformAndInitialize() async {
    if (Platform.isAndroid) {
      await _getInstalledApps();
    } else if (Platform.isIOS) {
      await _openSettings();
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _getInstalledApps() async {
    try {
      final List<dynamic> appList = await platform.invokeMethod('getInstalledApps');
      setState(() {
        _appModels = appList.cast<String>().map((appName) => AppModel(
            name: appName, showingNotifications: false, allowedUsing: true)).toList();
      });
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
        title: Text('Manage Blocked Apps'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) 
          : _appModels.isEmpty
              ? Center(
                  child: Platform.isIOS
                      ? Text('Please enable Screen Time in Settings.')
                      : Text('No apps found.'),
                )
              : ListView.builder(
                  itemCount: _appModels.length,
                  itemBuilder: (context, index) {
                    final app = _appModels[index];
                    return ListTile(
                      leading: Icon(Icons.apps),
                      title: Text(app.name),
                      trailing: Switch(
                        value: app.allowedUsing,
                        onChanged: (bool value) {
                          setState(() {
                            app.allowedUsing = value;
                          });
                        },
                      ),
                    );
                  },
                ),
    );
  }
}