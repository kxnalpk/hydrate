// ignore_for_file: library_private_types_in_public_api

import 'package:hydrate/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPages {
  String heading;
  String paragraph;

  Color button;
  Color background;

  OnboardingPages({
    required this.heading,
    required this.paragraph,
    required this.button,
    required this.background,
  });
}

class OnBoarding extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const OnBoarding({Key? key});

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoarding> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardingPages> screens = <OnboardingPages>[
    OnboardingPages(
      heading: "Don't remember to drink water?",
      paragraph:
          "Don't worry. you are at the right place! Myself Kunal and have created this application to remind you (and myself) to drink water!",
      background: Color.fromARGB(255, 81, 81, 61),
      button: Color.fromARGB(255, 27, 32, 33),
    ),
    OnboardingPages(
      heading: "You are almost done!",
      paragraph: "Great! We have configured the application for you! We'll send you a notification when it's the time to drink water!",
      background: Color.fromARGB(255, 27, 32, 33),
      button: Color.fromARGB(255, 81, 81, 61),
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex % 2 == 0
          ? Color.fromARGB(255, 81, 81, 61)
          : Color.fromARGB(255, 27, 32, 33),
      appBar: AppBar(
        backgroundColor: currentIndex % 2 == 0
            ? Color.fromARGB(255, 81, 81, 61)
            : Color.fromARGB(255, 27, 32, 33),
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const MainApp()));
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: currentIndex % 2 == 0 ? Color.fromARGB(255, 27, 32, 33) : Color.fromARGB(255, 81, 81, 61),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
          itemCount: screens.length,
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (_, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 15,
                  child: ListView.builder(
                    itemCount: screens.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      );
                    },
                  ),
                ),
                Text(
                  screens[index].heading,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    screens[index].paragraph,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    print(index);
                    if (index == screens.length - 1) {
                      await _storeOnboardInfo();
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const MainApp()));
                    }

                    _pageController.jumpToPage(index + 1);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 160.0, vertical: 10),
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Color.fromARGB(255, 27, 32, 33)
                          : Color.fromARGB(255, 81, 81, 61),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
