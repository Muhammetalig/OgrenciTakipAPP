import 'package:flutter/material.dart';
import '../models/daily_evaluation.dart'; // Models contain YemekOgesi, YemekDurumu
import '../utils/app_colors.dart'; // Import AppColors
import 'status_indicator.dart'; // Use StatusIndicator class

// Tek bir yemek ogesini ve durumunu gosteren ListTile widget'i.
class FoodItemTile extends StatelessWidget {
  final YemekOgesi yemekOgesi; // Renamed variable to use YemekOgesi model
  final VoidCallback tiklandi; // Renamed callback

  const FoodItemTile({
    super.key,
    required this.yemekOgesi,
    required this.tiklandi, // Updated constructor parameter
  });

  @override
  Widget build(BuildContext context) {
    Widget trailingWidget;
    switch (yemekOgesi.durum) {
      // Use renamed variable and enum
      case YemekDurumu.yedi:
        trailingWidget = const StatusIndicator(
            metin: 'Yedi',
            renk: AppColors.success, // Use semantic color
            ikon: Icons.sentiment_satisfied_alt);
        break;
      case YemekDurumu.yemedi:
        trailingWidget = const StatusIndicator(
            metin: 'Yemedi',
            renk: AppColors.error, // Use semantic color
            ikon: Icons.sentiment_dissatisfied_outlined);
        break;
      case YemekDurumu.secilmedi:
      default:
        trailingWidget = const Icon(Icons.remove_circle_outline,
            color: AppColors.textSecondary); // Use grey text color
        break;
    }

    return ListTile(
      // Use theme defaults for padding, density, text style
      // contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      // dense: true,
      title: Text(yemekOgesi.ad), // Style from theme
      trailing: trailingWidget,
      onTap: tiklandi, // Use renamed callback
    );
  }
}
