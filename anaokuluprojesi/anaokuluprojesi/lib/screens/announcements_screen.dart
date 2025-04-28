import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../models/announcement.dart'; // Import Duyuru model

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  // Sample announcement data (replace with actual data fetching later)
  final List<Duyuru> _duyurular = [
    Duyuru(
      id: '1',
      baslik: 'Okul Gezisi Hakkında Bilgilendirme',
      icerik:
          'Sevgili velilerimiz, önümüzdeki hafta Çarşamba günü planlanan hayvanat bahçesi gezimiz hakkında detaylı bilgi ve izin formu e-posta adreslerinize gönderilmiştir. Lütfen kontrol ediniz.',
      tarih: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Duyuru(
      id: '2',
      baslik: 'Veli Toplantısı Tarihi Değişikliği',
      icerik:
          'Daha önce Cuma günü yapılması planlanan genel veli toplantımız, katılımcı sayısının fazlalığı nedeniyle bir sonraki hafta Salı gününe ertelenmiştir. Anlayışınız için teşekkür ederiz.',
      tarih: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Duyuru(
      id: '3',
      baslik: 'Yeni Dönem Kayıtları Başladı!',
      icerik:
          '2024-2025 eğitim öğretim yılı için erken kayıt avantajlarından yararlanmak için acele edin! Detaylı bilgi için okul idaresi ile iletişime geçebilirsiniz.',
      tarih: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  // Date formatter
  final DateFormat _dateFormat = DateFormat('dd MMMM yyyy, HH:mm', 'tr_TR');

  @override
  Widget build(BuildContext context) {
    // Theme handles AppBar and Card styling
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duyurular'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0), // Add vertical padding for list
        itemCount: _duyurular.length,
        itemBuilder: (context, index) {
          final duyuru = _duyurular[index];
          return Card(
            // margin and elevation handled by CardTheme
            // margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            // elevation: 2.0,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                duyuru.baslik,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold), // Use theme style
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(duyuru.icerik,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium), // Use theme style
                    const SizedBox(height: 8),
                    Text(
                      _dateFormat.format(duyuru.tarih),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall, // Use theme style for date
                    ),
                  ],
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    // Use theme text styles for dialog
                    title: Text(duyuru.baslik,
                        style: Theme.of(context).textTheme.titleLarge),
                    content: SingleChildScrollView(
                        child: Text(duyuru.icerik,
                            style: Theme.of(context).textTheme.bodyMedium)),
                    actions: [
                      TextButton(
                        child: const Text('Kapat'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
