import 'package:flutter/material.dart';

// Bir durumu ikon ve metinle gostermek icin tekrar kullanilabilir widget.
class StatusIndicator extends StatelessWidget {
  final String metin;
  final Color renk;
  final IconData ikon;
  final double ikonBoyutu;
  final double yaziBoyutu;

  const StatusIndicator({
    super.key,
    required this.metin,
    required this.renk,
    required this.ikon,
    this.ikonBoyutu = 20.0, // Varsayilan ikon boyutu
    this.yaziBoyutu = 15.0, // Varsayilan yazi boyutu
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(ikon, color: renk, size: ikonBoyutu),
        const SizedBox(width: 8),
        Text(
          metin,
          style: TextStyle(
            fontSize: yaziBoyutu,
            fontWeight: FontWeight.bold,
            color: renk,
          ),
        ),
      ],
    );
  }
}
