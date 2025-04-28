// Duyuru veri modeli

class Duyuru {
  final String id;
  final String baslik;
  final String icerik;
  final DateTime tarih;
  // Istege bagli: gonderen, resimUrl vb. eklenebilir

  Duyuru({
    required this.id,
    required this.baslik,
    required this.icerik,
    required this.tarih,
  });
}
