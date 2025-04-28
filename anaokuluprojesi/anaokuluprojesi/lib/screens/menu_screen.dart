import 'package:flutter/material.dart';
import '../models/menu.dart'; // Import menu models

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Sample menu data (replace with actual data fetching later)
  final List<GunlukMenu> _haftalikMenu = [
    GunlukMenu(gunAdi: 'Pazartesi', ogunler: [
      OgunDetay(ogunAdi: 'Kahvaltı', yemekListesi: [
        'Haşlanmış Yumurta',
        'Beyaz Peynir',
        'Zeytin',
        'Domates',
        'Salatalık',
        'Süt'
      ]),
      OgunDetay(ogunAdi: 'Öğle Yemeği', yemekListesi: [
        'Mercimek Çorbası',
        'Izgara Köfte',
        'Pirinç Pilavı',
        'Salata'
      ]),
      OgunDetay(
          ogunAdi: 'İkindi Kahvaltısı',
          yemekListesi: ['Meyveli Yoğurt', 'Kek']),
    ]),
    GunlukMenu(gunAdi: 'Salı', ogunler: [
      OgunDetay(ogunAdi: 'Kahvaltı', yemekListesi: [
        'Omlet',
        'Kaşar Peyniri',
        'Yeşil Zeytin',
        'Biber',
        'Ihlamur'
      ]),
      OgunDetay(ogunAdi: 'Öğle Yemeği', yemekListesi: [
        'Tavuk Suyu Çorba',
        'Fırında Tavuk Baget',
        'Bulgur Pilavı',
        'Ayran'
      ]),
      OgunDetay(
          ogunAdi: 'İkindi Kahvaltısı',
          yemekListesi: ['Meyve Salatası', 'Grissini']),
    ]),
    GunlukMenu(gunAdi: 'Çarşamba', ogunler: [
      OgunDetay(
          ogunAdi: 'Kahvaltı',
          yemekListesi: ['Pankek', 'Bal', 'Tereyağ', 'Mevsim Meyvesi', 'Süt']),
      OgunDetay(ogunAdi: 'Öğle Yemeği', yemekListesi: [
        'Sebze Çorbası',
        'Zeytinyağlı Taze Fasulye',
        'Makarna',
        'Yoğurt'
      ]),
      OgunDetay(
          ogunAdi: 'İkindi Kahvaltısı',
          yemekListesi: ['Peynirli Poğaça', 'Limonata']),
    ]),
    // Add other days as needed...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haftalık Yemek Menüsü'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: _haftalikMenu.length,
        itemBuilder: (context, index) {
          final gunlukMenu = _haftalikMenu[index];
          return Card(
            child: ExpansionTile(
              title: Text(
                gunlukMenu.gunAdi,
              ),
              children: gunlukMenu.ogunler.map((ogun) {
                return ListTile(
                  title: Text(
                    ogun.ogunAdi,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(ogun.yemekListesi.join('\n')),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
