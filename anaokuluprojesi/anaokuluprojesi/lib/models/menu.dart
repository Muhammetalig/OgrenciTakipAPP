// Yemek Menusu icin veri modelleri

class OgunDetay {
  final String ogunAdi; // Ornegin: "Kahvaltı", "Öğle Yemeği"
  final List<String> yemekListesi;

  OgunDetay({required this.ogunAdi, required this.yemekListesi});
}

class GunlukMenu {
  final String gunAdi; // Ornegin: "Pazartesi", "Salı"
  final List<OgunDetay> ogunler;

  GunlukMenu({required this.gunAdi, required this.ogunler});
}
