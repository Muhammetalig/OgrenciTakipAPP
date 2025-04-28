import 'package:flutter/material.dart';
import '../models/daily_evaluation.dart'; // Models should contain Ogun

// Bir ogun bolumu icin baslik gosteren widget.
class MealHeader extends StatelessWidget {
  final Ogun ogun; // Renamed variable to use Ogun model

  const MealHeader(
      {super.key, required this.ogun}); // Updated constructor parameter

  @override
  Widget build(BuildContext context) {
    // Safely determine colors
    Color headerBgColor = ogun.renk is Color
        ? ogun.renk.withOpacity(0.1)
        : Colors.grey.withOpacity(0.1);
    Color headerTextColor = ogun.renk is Color ? ogun.renk : Colors.black;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      color: headerBgColor,
      child: Row(
        children: [
          Text(ogun.ikonKarakteri, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Text(
            ogun.ad,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: headerTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
