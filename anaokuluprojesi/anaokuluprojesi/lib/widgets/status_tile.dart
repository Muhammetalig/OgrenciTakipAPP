import 'package:flutter/material.dart';
import 'status_indicator.dart'; // Corrected import path

// Degistirilebilir bir durumu (Devamsizlik/Uyku gibi) gostermek icin tekrar kullanilabilir ListTile.
class StatusTile extends StatelessWidget {
  // Reverted class name
  final String baslik;
  final bool aktifMi;
  final String aktifMetin;
  final String pasifMetin;
  final Color aktifRenk;
  final Color pasifRenk;
  final IconData aktifIkon;
  final IconData pasifIkon;
  final VoidCallback tiklandi;

  const StatusTile({
    // Reverted constructor name
    super.key,
    required this.baslik,
    required this.aktifMi,
    required this.aktifMetin,
    required this.pasifMetin,
    required this.aktifRenk,
    required this.pasifRenk,
    required this.aktifIkon,
    required this.pasifIkon,
    required this.tiklandi,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      title: Text(baslik, style: const TextStyle(fontSize: 16)),
      trailing: StatusIndicator(
        // Use correct widget name
        metin: aktifMi ? aktifMetin : pasifMetin,
        renk: aktifMi ? aktifRenk : pasifRenk,
        ikon: aktifMi ? aktifIkon : pasifIkon,
      ),
      onTap: tiklandi,
    );
  }
}
