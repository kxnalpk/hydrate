import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      datasets: {
        DateTime(2021, 1, 6): 3,
        DateTime(2021, 1, 7): 7,
        DateTime(2021, 1, 8): 10,
        DateTime(2021, 1, 9): 13,
        DateTime(2021, 1, 13): 6,
      },
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 24)),
      colorMode: ColorMode.opacity,
      showText: false,
      scrollable: true,
      colorsets: const {
        1: Color.fromARGB(20, 2, 179, 8),
        2: Color.fromARGB(40, 2, 179, 8),
        3: Color.fromARGB(60, 2, 179, 8),
        4: Color.fromARGB(80, 2, 179, 8),
        5: Color.fromARGB(100, 2, 179, 8),
      },
    );
  }
}
