import 'package:hydrate/notifications/notifs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late SharedPreferences prefs;
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    _initializePrefs();
    notificationServices.initialiseNotifications();
  }

  Future<int> _getNumberOfGlasses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('glasses') ?? 0;
  }

  Future<void> _storeNumberOfGlasses() async {
    print("Shared pref called");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentGlasses = prefs.getInt('glasses') ?? 0;
    currentGlasses = (currentGlasses + 1) % 9;
    await prefs.setInt('glasses', currentGlasses);
    print(currentGlasses);
  }

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<int> _getReminderStatus() async {
    await _initializePrefs();
    return prefs.getInt('remindOn') ?? 0;
  }

  Future<void> _toggleReminderStatus() async {
    await _initializePrefs();
    int currentStatus = await _getReminderStatus();
    int newStatus = (currentStatus == 0) ? 1 : 0;

    await prefs.setInt('remindOn', newStatus);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 17, 17, 17),
        child: SizedBox(
          width: 1180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: FutureBuilder<int>(
                  future: _getNumberOfGlasses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return Text(
                        'You have drunk ${snapshot.data} glasses of water today!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: FutureBuilder<int>(
                  future: _getReminderStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 72, 165, 59),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(1180, 80),
                        ),
                        onPressed: () async {
                          await _toggleReminderStatus();
                          await _storeNumberOfGlasses();

                          notificationServices.sendNotification(
                            'Beep Boop, It\'s time to drink water!',
                            'It\'s me reminding you to drink water as promised!',
                          );
                        },
                        child: Text(
                          (snapshot.data == 0)
                              ? "Press to start"
                              : "Press to stop",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
