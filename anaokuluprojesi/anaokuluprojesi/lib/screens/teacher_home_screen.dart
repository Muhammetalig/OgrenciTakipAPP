import 'package:flutter/material.dart';
import '../models/daily_evaluation.dart';
import '../utils/app_colors.dart';
import '../widgets/date_navigation_bar.dart';
import '../widgets/status_tile.dart';
import '../widgets/meal_header.dart';
import '../widgets/food_item_tile.dart';

// Renamed class to TeacherHomeScreen
class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() =>
      _TeacherHomeScreenState(); // Renamed state class
}

// Renamed state class
class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  // --- State Variables ---
  bool _katildi = true;
  bool _uyudu = false;
  DateTime _seciliTarih = DateTime.now();
  List<Ogun> _ogunler = [];

  @override
  void initState() {
    super.initState();
    _ogunleriBaslat();
  }

  void _ogunleriBaslat() {
    const Color turuncu = AppColors.orange;
    const Color vurguMor = AppColors.accentPurple;
    // Reset state variables along with meals
    setState(() {
      _katildi = true;
      _uyudu = false;
      _ogunler = [
        Ogun(
            ad: 'Öğün 1',
            ikonKarakteri: '\ud83c\udf73',
            renk: turuncu,
            ogeler: [
              YemekOgesi(ad: 'Omlet'),
              YemekOgesi(ad: 'Peynir'),
              YemekOgesi(ad: 'Domates/Salatalık'),
              YemekOgesi(ad: 'Bal/Reçel'),
              YemekOgesi(ad: 'Süt'),
            ]),
        Ogun(
            ad: 'Öğün 2',
            ikonKarakteri: '\ud83c\udf5d',
            renk: AppColors.primaryBlue,
            ogeler: [
              YemekOgesi(ad: 'Mercimek Çorbası'),
              YemekOgesi(ad: 'Tavuklu Pilav'),
              YemekOgesi(ad: 'Yoğurt'),
              YemekOgesi(ad: 'Ayran'),
            ]),
        Ogun(
            ad: 'Öğün 3',
            ikonKarakteri: '\ud83c\udf6a',
            renk: vurguMor,
            ogeler: [
              YemekOgesi(ad: 'Elmalı Kurabiye'),
              YemekOgesi(ad: 'Meyve Tabağı'),
              YemekOgesi(ad: 'Süt'),
            ]),
      ];
    });
  }

  void _oncekiGuneGit() {
    setState(() {
      _seciliTarih = _seciliTarih.subtract(const Duration(days: 1));
      _ogunleriBaslat(); // Fetch data for the new date (resets meals for now)
    });
  }

  void _sonrakiGuneGit() {
    setState(() {
      _seciliTarih = _seciliTarih.add(const Duration(days: 1));
      _ogunleriBaslat(); // Fetch data for the new date (resets meals for now)
    });
  }

  String _tarihiFormatla(DateTime tarih) {
    const List<String> haftaGunleri = [
      '',
      'Pzt',
      'Salı',
      'Çarş',
      'Perş',
      'Cuma',
      'Cmt',
      'Paz'
    ];
    const List<String> aylar = [
      '',
      'Ocak',
      'Şub',
      'Mar',
      'Nis',
      'May',
      'Haz',
      'Tem',
      'Ağu',
      'Eyl',
      'Eki',
      'Kas',
      'Ara'
    ];
    String haftaGunuStr = tarih.weekday >= 1 && tarih.weekday <= 7
        ? haftaGunleri[tarih.weekday]
        : '';
    String ayStr =
        tarih.month >= 1 && tarih.month <= 12 ? aylar[tarih.month] : '';
    return '${tarih.day} $ayStr / $haftaGunuStr';
  }

  void _yemekDurumunuDegistir(YemekOgesi oge) {
    setState(() {
      if (oge.durum == YemekDurumu.secilmedi) {
        oge.durum = YemekDurumu.yedi;
      } else if (oge.durum == YemekDurumu.yedi) {
        oge.durum = YemekDurumu.yemedi;
      } else {
        oge.durum = YemekDurumu.secilmedi;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Günlük Değerlendirme (Öğretmen)'), // Added role indicator
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Çıkış Yap',
            onPressed: () {
              // Ensure navigation back to login screen
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          DateNavigationBar(
            seciliTarih: _seciliTarih,
            oncekiGunTiklandi: _oncekiGuneGit,
            sonrakiGunTiklandi: _sonrakiGuneGit,
            tarihiFormatla: _tarihiFormatla,
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                StatusTile(
                  baslik: 'Devamsızlık',
                  aktifMi: _katildi,
                  aktifMetin: 'Geldi',
                  pasifMetin: 'Gelmedi',
                  aktifRenk: AppColors.success,
                  pasifRenk: AppColors.error,
                  aktifIkon: Icons.check_circle_outline,
                  pasifIkon: Icons.highlight_off,
                  tiklandi: () {
                    setState(() {
                      _katildi = !_katildi;
                    });
                  },
                ),
                const Divider(),
                StatusTile(
                  baslik: 'Uyku',
                  aktifMi: _uyudu,
                  aktifMetin: 'Uyudu',
                  pasifMetin: 'Uyumadı',
                  aktifRenk: AppColors.info,
                  pasifRenk: AppColors.warning,
                  aktifIkon: Icons.nights_stay,
                  pasifIkon: Icons.wb_sunny_outlined,
                  tiklandi: () {
                    setState(() {
                      _uyudu = !_uyudu;
                    });
                  },
                ),
                const Divider(thickness: 5, color: AppColors.background),
                ..._ogunler.expand((ogun) => [
                      MealHeader(ogun: ogun),
                      ...ogun.ogeler.map((oge) => FoodItemTile(
                            yemekOgesi: oge,
                            tiklandi: () => _yemekDurumunuDegistir(oge),
                          )),
                      const SizedBox(height: 10),
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
