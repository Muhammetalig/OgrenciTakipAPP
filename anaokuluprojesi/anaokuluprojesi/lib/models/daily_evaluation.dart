// Gunluk degerlendirme icin veri yapilari

enum YemekDurumu { yedi, yemedi, secilmedi }

enum TuvaletDurumu { kuru, islak, kaka, secilmedi }

enum RuhHali { mutlu, uzgun, sakin, enerjik, secilmedi }

class YemekOgesi {
  String ad;
  YemekDurumu durum;

  YemekOgesi({required this.ad, this.durum = YemekDurumu.secilmedi});
}

class Ogun {
  String ad;
  String ikonKarakteri; // Ogun ikonu icin emoji karakteri
  dynamic renk; // Widget icinde islenecek
  List<YemekOgesi> ogeler;

  Ogun(
      {required this.ad,
      required this.ikonKarakteri,
      required this.renk,
      required this.ogeler});
}

class GunlukRapor {
  final DateTime tarih;
  final bool katildiMi;
  final bool uyuduMu;
  final List<Ogun> ogunler;
  final TuvaletDurumu tuvaletDurumu;
  final RuhHali ruhHali;
  final String? ogretmenNotu;

  GunlukRapor({
    required this.tarih,
    required this.katildiMi,
    required this.uyuduMu,
    required this.ogunler,
    this.tuvaletDurumu = TuvaletDurumu.secilmedi,
    this.ruhHali = RuhHali.secilmedi,
    this.ogretmenNotu,
  });
}
