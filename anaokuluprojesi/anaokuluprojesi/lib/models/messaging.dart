import 'package:cloud_firestore/cloud_firestore.dart';

// Mesajlasma icin veri modelleri

// Kullanici kimligini ve adini temsil eder
class KullaniciOzet {
  final String id;
  final String adSoyad;
  // Rol bilgisi de eklenebilir (Veli, Ogretmen vb.)
  // final String rol;

  KullaniciOzet({required this.id, required this.adSoyad});

  factory KullaniciOzet.fromMap(Map<String, dynamic> map) {
    return KullaniciOzet(
      id: map['id'] as String,
      adSoyad: map['adSoyad'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adSoyad': adSoyad,
    };
  }
}

// Mesajlaşma Konuşması modeli
class MesajlasmaKonusmasi {
  final String id; // Konuşma ID'si (Firestore document ID)
  final List<String> katilimciIds; // Katılımcıların kullanıcı ID'leri
  final Map<String, KullaniciOzet>
      katilimcilar; // Katılımcıların KullaniciOzet bilgileri
  final String? sonMesajId;
  final Timestamp? sonMesajZamani;
  final String? sonMesajIcerik; // Son mesajın kısa bir önizlemesi
  final String? sonMesajGonderenId; // Son mesajı gönderenin ID'si
  final Map<String, int>
      okunmamisSayilari; // Her kullanıcı için okunmamış mesaj sayısı {userId: count}

  MesajlasmaKonusmasi({
    required this.id,
    required this.katilimciIds,
    required this.katilimcilar,
    this.sonMesajId,
    this.sonMesajZamani,
    this.sonMesajIcerik,
    this.sonMesajGonderenId,
    required this.okunmamisSayilari,
  });

  // Firestore'dan okuma için factory constructor (gerekirse)
  // factory MesajlasmaKonusmasi.fromFirestore(DocumentSnapshot doc) { ... }
}

// Mesaj modeli
class Mesaj {
  final String id; // Mesaj ID'si (Firestore document ID)
  final String konusmaId;
  final String gonderenId;
  final String
      aliciId; // Direkt mesajlarda veya grup mesajlarında alıcıları belirtmek için
  final String icerik;
  final Timestamp timestamp;
  final bool okundu; // Şimdilik basit bir okundu bilgisi

  Mesaj({
    required this.id,
    required this.konusmaId,
    required this.gonderenId,
    required this.aliciId,
    required this.icerik,
    required this.timestamp,
    this.okundu = false,
  });

  // Firestore'dan okuma için factory constructor (gerekirse)
  // factory Mesaj.fromFirestore(DocumentSnapshot doc) { ... }

  // Firestore'a yazma için toMap metodu (gerekirse)
  Map<String, dynamic> toMap() {
    return {
      'konusmaId': konusmaId,
      'gonderenId': gonderenId,
      'aliciId': aliciId,
      'icerik': icerik,
      'timestamp': timestamp,
      'okundu': okundu,
    };
  }
}

class Konusma {
  final String id;
  final List<KullaniciOzet>
      katilimcilar; // Konusmadaki kullanicilar (genelde 2)
  final Mesaj? sonMesaj; // Konusmadaki son mesaj (liste ekrani icin)
  final int okunmamisSayisi; // Mevcut kullanici icin okunmamis mesaj sayisi

  Konusma({
    required this.id,
    required this.katilimcilar,
    this.sonMesaj,
    this.okunmamisSayisi = 0,
  });

  // Yardimci metod: Mevcut kullanici disindaki diger katilimciyi getirir
  KullaniciOzet? digerKatilimciyiGetir(String mevcutKullaniciId) {
    return katilimcilar.firstWhere((k) => k.id != mevcutKullaniciId,
        orElse: () => KullaniciOzet(id: '', adSoyad: 'Bilinmeyen'));
  }
}
