import 'package:flutter/material.dart';

// Tarihler arasi gezinmek icin bir widget.
class DateNavigationBar extends StatelessWidget {
  final DateTime seciliTarih;
  final VoidCallback oncekiGunTiklandi;
  final VoidCallback sonrakiGunTiklandi;
  final String Function(DateTime) tarihiFormatla;

  const DateNavigationBar({
    super.key,
    required this.seciliTarih,
    required this.oncekiGunTiklandi,
    required this.sonrakiGunTiklandi,
    required this.tarihiFormatla,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: oncekiGunTiklandi,
            tooltip: 'Önceki Gün',
          ),
          Text(
            tarihiFormatla(seciliTarih),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
            onPressed: sonrakiGunTiklandi,
            tooltip: 'Sonraki Gün',
          ),
        ],
      ),
    );
  }
}
