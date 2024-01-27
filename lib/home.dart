import 'package:e/notifications/notifs.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.initialiseNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Back!"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
ElevatedButton(
  onPressed: () {
    notificationServices.sendNotification('It\'s time to drink water!', 'Reminder Number: 2');
    },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromRGBO(80, 91, 230, 1),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    minimumSize: Size(170, 50),
    padding: EdgeInsets.all(10),
  ),
  child: const Text(
    "Schedule Reminders",
    style: TextStyle(fontSize: 16),
  ),
)

          ],
        ),
      ),
    );
  }
}
