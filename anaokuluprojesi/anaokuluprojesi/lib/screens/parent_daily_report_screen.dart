import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/daily_evaluation.dart';
import '../utils/app_colors.dart'; // Import AppColors
import '../widgets/status_indicator.dart'; // Reusable status widget
// import '../widgets/meal_header.dart'; // Removed unused import
// import '../widgets/food_item_tile.dart'; // Removed unused import

class ParentDailyReportScreen extends StatelessWidget {
  ParentDailyReportScreen({super.key});

  // --- Sample Data (Replace with actual data logic later) ---
  GunlukRapor _getSampleReport() {
    // Sample meals (assuming they are fetched/constructed)
    final ogun1 = Ogun(
        ad: 'Öğün 1',
        ikonKarakteri: '\ud83c\udf73',
        renk: AppColors.orange,
        ogeler: [
          YemekOgesi(ad: 'Omlet', durum: YemekDurumu.yedi),
          YemekOgesi(ad: 'Peynir', durum: YemekDurumu.yedi),
          YemekOgesi(ad: 'Domates/Salatalık', durum: YemekDurumu.yedi),
          YemekOgesi(ad: 'Bal/Reçel', durum: YemekDurumu.yemedi),
          YemekOgesi(ad: 'Süt', durum: YemekDurumu.yedi),
        ]);
    final ogun2 = Ogun(
        ad: 'Öğün 2',
        ikonKarakteri: '\ud83c\udf5d',
        renk: AppColors.primaryBlue,
        ogeler: [
          YemekOgesi(ad: 'Mercimek Çorbası', durum: YemekDurumu.yedi),
          YemekOgesi(ad: 'Tavuklu Pilav', durum: YemekDurumu.yedi),
          YemekOgesi(ad: 'Yoğurt', durum: YemekDurumu.yedi),
          YemekOgesi(ad: 'Ayran', durum: YemekDurumu.yedi),
        ]);
    final ogun3 = Ogun(
        ad: 'Öğün 3',
        ikonKarakteri: '\ud83c\udf6a',
        renk: AppColors.accentPurple,
        ogeler: [
          YemekOgesi(
              ad: 'Elmalı Kurabiye',
              durum: YemekDurumu.secilmedi), // Not yet eaten maybe
          YemekOgesi(ad: 'Meyve Tabağı', durum: YemekDurumu.secilmedi),
          YemekOgesi(ad: 'Süt', durum: YemekDurumu.secilmedi),
        ]);

    return GunlukRapor(
      tarih: DateTime.now()
          .subtract(const Duration(hours: 2)), // Report from today
      katildiMi: true,
      uyuduMu: false, // Changed to false to show warning color
      ogunler: [ogun1, ogun2, ogun3], // Include sample meals
      tuvaletDurumu: TuvaletDurumu.islak, // Changed to show another status
      ruhHali: RuhHali.sakin, // Changed to show another status
      ogretmenNotu:
          'Bugün parkta oyun oynarken çok eğlendi. Arkadaşlarıyla paylaşım konusunda iyiydi.',
    );
  }

  // Helper to format date
  final DateFormat _dateFormat = DateFormat('dd MMMM yyyy', 'tr_TR');

  // Helper to get display info for enums
  Map<String, dynamic> _getTuvaletDisplayInfo(TuvaletDurumu durum) {
    switch (durum) {
      case TuvaletDurumu.kuru:
        return {
          'text': 'Kuru',
          'icon': Icons.check_circle_outline,
          'color': AppColors.success
        };
      case TuvaletDurumu.islak:
        return {
          'text': 'Islak',
          'icon': Icons.water_drop_outlined,
          'color': AppColors.warning
        };
      case TuvaletDurumu.kaka:
        return {
          'text': 'Kaka Yapıldı',
          'icon': Icons.sentiment_very_satisfied_outlined,
          'color': Colors.brown
        };
      default:
        return {
          'text': 'Bilgi Yok',
          'icon': Icons.help_outline,
          'color': AppColors.textSecondary
        };
    }
  }

  Map<String, dynamic> _getRuhHaliDisplayInfo(RuhHali durum) {
    switch (durum) {
      case RuhHali.mutlu:
        return {
          'text': 'Mutlu',
          'icon': Icons.sentiment_very_satisfied,
          'color': AppColors.success
        };
      case RuhHali.sakin:
        return {
          'text': 'Sakin',
          'icon': Icons.sentiment_satisfied,
          'color': AppColors.info
        };
      case RuhHali.enerjik:
        return {
          'text': 'Enerjik',
          'icon': Icons.flash_on,
          'color': AppColors.orange
        };
      case RuhHali.uzgun:
        return {
          'text': 'Üzgün',
          'icon': Icons.sentiment_very_dissatisfied,
          'color': AppColors.error
        };
      default:
        return {
          'text': 'Bilgi Yok',
          'icon': Icons.help_outline,
          'color': AppColors.textSecondary
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final rapor = _getSampleReport(); // Get the sample report data
    final tuvaletInfo = _getTuvaletDisplayInfo(rapor.tuvaletDurumu);
    final ruhHaliInfo = _getRuhHaliDisplayInfo(rapor.ruhHali);

    return Scaffold(
      appBar: AppBar(
        title: Text('${_dateFormat.format(rapor.tarih)} Raporu'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Genel Durumlar ---
            _buildSectionHeader(context, 'Genel Durum'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.event_available),
                    title: const Text('Devam Durumu'),
                    trailing: StatusIndicator(
                        metin: rapor.katildiMi ? 'Geldi' : 'Gelmedi',
                        renk: rapor.katildiMi
                            ? AppColors.success
                            : AppColors.error,
                        ikon: rapor.katildiMi
                            ? Icons.check_circle_outline
                            : Icons.highlight_off),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.bedtime_outlined),
                    title: const Text('Öğle Uykusu'),
                    trailing: StatusIndicator(
                        metin: rapor.uyuduMu ? 'Uyudu' : 'Uyumadı',
                        renk:
                            rapor.uyuduMu ? AppColors.info : AppColors.warning,
                        ikon: rapor.uyuduMu
                            ? Icons.nights_stay
                            : Icons.wb_sunny_outlined),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.wc_outlined),
                    title: const Text('Tuvalet Takibi'),
                    trailing: StatusIndicator(
                      metin: tuvaletInfo['text'],
                      renk: tuvaletInfo['color'],
                      ikon: tuvaletInfo['icon'],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.mood_outlined),
                    title: const Text('Ruh Hali'),
                    trailing: StatusIndicator(
                      metin: ruhHaliInfo['text'],
                      renk: ruhHaliInfo['color'],
                      ikon: ruhHaliInfo['icon'],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- Öğünler ---
            _buildSectionHeader(context, 'Yemekler'),
            Card(
              child: Column(
                children: rapor.ogunler
                    .map((ogun) => ExpansionTile(
                          tilePadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          leading: Text(ogun.ikonKarakteri,
                              style: const TextStyle(fontSize: 20)),
                          title: Text(ogun.ad,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          children: ogun.ogeler
                              .map((oge) => ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: 56.0, right: 16.0),
                                    title: Text(oge.ad),
                                    dense: true,
                                    trailing: StatusIndicator(
                                      metin: oge.durum == YemekDurumu.yedi
                                          ? 'Yedi'
                                          : (oge.durum == YemekDurumu.yemedi
                                              ? 'Yemedi'
                                              : '-'),
                                      renk: oge.durum == YemekDurumu.yedi
                                          ? AppColors.success
                                          : (oge.durum == YemekDurumu.yemedi
                                              ? AppColors.error
                                              : AppColors.textSecondary),
                                      ikon: oge.durum == YemekDurumu.yedi
                                          ? Icons.sentiment_satisfied_alt
                                          : (oge.durum == YemekDurumu.yemedi
                                              ? Icons
                                                  .sentiment_dissatisfied_outlined
                                              : Icons.remove_circle_outline),
                                      ikonBoyutu: 18,
                                      yaziBoyutu: 14,
                                    ),
                                  ))
                              .toList(),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),

            // --- Öğretmen Notu ---
            if (rapor.ogretmenNotu != null && rapor.ogretmenNotu!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(context, 'Öğretmen Notu'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(rapor.ogretmenNotu!),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Helper for section headers
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              letterSpacing: 0.8,
            ),
      ),
    );
  }
}
