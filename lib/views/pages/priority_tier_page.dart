import 'package:flutter/material.dart';


class PriorityTierPage extends StatefulWidget {
  @override
  _PriorityTierPageState createState() => _PriorityTierPageState();
}

class _PriorityTierPageState extends State<PriorityTierPage> {
  String selectedTier = "Low";
  bool tenPushNotification = true;
  bool zeroPushNotifications = false;
  bool travelNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Priority Tier"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "Tier: $selectedTier",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Options
            Text(
              "Notification Options",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildNotificationOption("10 minutes before event", tenPushNotification, (value) {
              setState(() {
                tenPushNotification = value;
              });
            }),
            _buildNotificationOption("Start of event", zeroPushNotifications, (value) {
              setState(() {
                zeroPushNotifications = value;
              });
            }),
            _buildNotificationOption("Travel Alerts", travelNotifications, (value) {
              setState(() {
                travelNotifications = value;
              });
            }),
            // Divider
            Divider(height: 32, thickness: 1, color: Colors.grey[300]),
            // Blocked Apps Section
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlockedAppsPage()),
                );
              },
              child: Row(
                children: [
                  Text(
                    "Blocked Apps",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationOption(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class BlockedAppsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blocked Apps"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.apps),
            title: Text("App 1"),
            trailing: Icon(Icons.block, color: Colors.red),
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text("App 2"),
            trailing: Icon(Icons.block, color: Colors.red),
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text("App 3"),
            trailing: Icon(Icons.block, color: Colors.red),
          ),
        ],
      ),
    );
  }
}