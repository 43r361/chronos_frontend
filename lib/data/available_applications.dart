import 'package:flutter/material.dart';
import 'app_model.dart';

class AvailableApplications extends ChangeNotifier {
  List<AppModel> _apps = [];

  List<AppModel> get apps => _apps;

  void addApp(AppModel app) {
    _apps.add(app);
    notifyListeners();
  }

  void updateAppFlags(String appName, bool allowedUsing, bool showingNotifications) {
    final appIndex = _apps.indexWhere((app) => app.name == appName);
    if (appIndex != -1) {
      _apps[appIndex].allowedUsing = allowedUsing;
      _apps[appIndex].showingNotifications = showingNotifications;
      notifyListeners();
    }
  }

  void removeApp(String appName) {
    _apps.removeWhere((app) => app.name == appName);
    notifyListeners();
  }
}