import 'package:flutter/material.dart';
// Import the models
import '../models/daily_evaluation.dart';
// Import custom widgets
// import '../widgets/status_indicator.dart'; // Removed unused import
import '../widgets/date_navigation_bar.dart'; // Uncommented import
import '../widgets/status_tile.dart';
import '../widgets/meal_header.dart';
import '../widgets/food_item_tile.dart';

// --- Data Structures ---

// enum FoodStatus { ate, didNotEat, notSelected } // Removed
// class FoodItem { ... } // Removed
// class Meal { ... } // Removed

// --- HomeScreen Widget ---

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- State Variables ---
  static const Color birincilMavi = Color(0xFF15B2F7);
  // Remove unused color constants from state
  // static const Color accentPurple = Color(0xFFC64FE0);
  // static const Color darkPurple = Color(0xFF832A92);
  // static const Color green = Color(0xFFA1E23D);
  // static const Color orange = Color(0xFFF0782C); // Used locally in _initializeMeals
  // static const Color red = Color(0xFFE8202A);

  bool _katildi = true;
  bool _uyudu = false;
  DateTime _seciliTarih = DateTime.now();

  // Meal Data (State)
  List<Ogun> _ogunler = [];

  @override
  void initState() {
    super.initState();
    _ogunleriBaslat();
  }

  void _ogunleriBaslat() {
    const Color turuncu = Color(0xFFF0782C);
    const Color vurguMor = Color(0xFFC64FE0);
    _ogunler = [
      Ogun(ad: 'Öğün 1', ikonKarakteri: '\ud83c\udf73', renk: turuncu, ogeler: [
        YemekOgesi(ad: 'Omlet'),
        YemekOgesi(ad: 'Peynir'),
        YemekOgesi(ad: 'Domates/Salatalık'),
        YemekOgesi(ad: 'Bal/Reçel'),
        YemekOgesi(ad: 'Süt'),
      ]),
      Ogun(
          ad: 'Öğün 2',
          ikonKarakteri: '\ud83c\udf5d',
          renk: Colors.blue.shade300,
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
    // Ensure state uses the imported models
    // Trigger rebuild if necessary, though initState handles initial setup
    // if (mounted) { setState(() {}); }
  }

  void _oncekiGuneGit() {
    setState(() {
      _seciliTarih = _seciliTarih.subtract(const Duration(days: 1));
      _ogunleriBaslat();
      _katildi = true;
      _uyudu = false;
    });
  }

  void _sonrakiGuneGit() {
    setState(() {
      _seciliTarih = _seciliTarih.add(const Duration(days: 1));
      _ogunleriBaslat();
      _katildi = true;
      _uyudu = false;
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

  // --- State Update Logic for Food Items ---
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

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Günlük Değerlendirme'),
        backgroundColor: birincilMavi,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Çıkış Yap',
            onPressed: () {
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
                  aktifRenk: Colors.green,
                  pasifRenk: Colors.red,
                  aktifIkon: Icons.check_circle_outline,
                  pasifIkon: Icons.highlight_off,
                  tiklandi: () {
                    setState(() {
                      _katildi = !_katildi;
                    });
                  },
                ),
                const Divider(
                    height: 1, thickness: 1, indent: 16, endIndent: 16),
                StatusTile(
                  baslik: 'Uyku',
                  aktifMi: _uyudu,
                  aktifMetin: 'Uyudu',
                  pasifMetin: 'Uyumadı',
                  aktifRenk: Colors.blueAccent,
                  pasifRenk: Colors.orangeAccent,
                  aktifIkon: Icons.nights_stay,
                  pasifIkon: Icons.wb_sunny_outlined,
                  tiklandi: () {
                    setState(() {
                      _uyudu = !_uyudu;
                    });
                  },
                ),
                const Divider(height: 1, thickness: 1),
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

  // --- REMOVED Helper Widgets ---
  // Widget _buildDateNavigationRow() { ... }
  // Widget _buildDailyEvaluationContent() { ... }
  // Widget _buildMealHeader(Meal meal) { ... }
  // Widget _buildFoodItemTile(FoodItem item, Meal meal) { ... }
}
