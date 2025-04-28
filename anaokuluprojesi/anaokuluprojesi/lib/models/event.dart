// Etkinlik veri modeli

class Etkinlik {
  final String id;
  final String baslik;
  final String? aciklama; // Optional description
  final DateTime tarih;
  // Istege bagli: konum, katilimcilar, resimUrl vb. eklenebilir

  Etkinlik({
    required this.id,
    required this.baslik,
    this.aciklama,
    required this.tarih,
  });
}
