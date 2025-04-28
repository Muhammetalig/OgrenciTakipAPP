import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/messaging.dart';
import '../utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Timestamp

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  // Sample conversation data (replace with actual data logic)
  // Assume current user is 'veli1'
  final String _mevcutKullaniciId = 'veli1';
  late final List<Konusma> _konusmalar;

  @override
  void initState() {
    super.initState();
    _loadSampleConversations();
  }

  void _loadSampleConversations() {
    final ogretmen1 = KullaniciOzet(id: 'ogr1', adSoyad: 'Ayşe Öğretmen');
    final ogretmen2 = KullaniciOzet(id: 'ogr2', adSoyad: 'Mehmet Öğretmen');
    final veli1 = KullaniciOzet(
        id: 'veli1', adSoyad: 'Ahmet Yılmaz (Veli)'); // Current user

    _konusmalar = [
      Konusma(
        id: 'konusma1',
        katilimcilar: [veli1, ogretmen1],
        sonMesaj: Mesaj(
            id: 'm1',
            konusmaId: 'konusma1',
            gonderenId: 'ogr1',
            aliciId: 'veli1',
            icerik:
                'Merhaba Ahmet Bey, yarınki gezi için hatırlatma yapmak istedim.',
            timestamp: Timestamp.fromDate(
                DateTime.now().subtract(const Duration(minutes: 30))),
            okundu: false),
        okunmamisSayisi: 1,
      ),
      Konusma(
        id: 'konusma2',
        katilimcilar: [veli1, ogretmen2],
        sonMesaj: Mesaj(
            id: 'm2',
            konusmaId: 'konusma2',
            gonderenId: 'veli1',
            aliciId: 'ogr2',
            icerik: 'Teşekkürler Mehmet Bey, bilgi için.',
            timestamp: Timestamp.fromDate(
                DateTime.now().subtract(const Duration(hours: 2))),
            okundu: true),
        okunmamisSayisi: 0,
      ),
      // Add more sample conversations
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesajlar'),
        // Optional: Add action for new message?
      ),
      body: ListView.separated(
        itemCount: _konusmalar.length,
        separatorBuilder: (context, index) => const Divider(
            height: 0,
            indent: 0,
            endIndent: 0), // Use themed divider, remove indent
        itemBuilder: (context, index) {
          final konusma = _konusmalar[index];
          final digerKatilimci =
              konusma.digerKatilimciyiGetir(_mevcutKullaniciId);
          final sonMesaj = konusma.sonMesaj;

          return ListTile(
            leading: CircleAvatar(
              // Placeholder for profile picture
              backgroundColor: AppColors.primaryBlue.withOpacity(0.2),
              foregroundColor: AppColors.primaryBlue,
              child: Text(digerKatilimci?.adSoyad.substring(0, 1) ??
                  '?'), // First letter
            ),
            title: Text(
              digerKatilimci?.adSoyad ?? 'Bilinmeyen',
              style: TextStyle(
                  fontWeight: konusma.okunmamisSayisi > 0
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
            subtitle: Text(
              sonMesaj?.icerik ?? 'Mesaj yok',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: konusma.okunmamisSayisi > 0
                      ? AppColors.textPrimary
                      : AppColors.textSecondary),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (sonMesaj != null)
                  Text(
                    DateFormat('HH:mm').format(sonMesaj.timestamp.toDate()),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (konusma.okunmamisSayisi > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.error,
                      child: Text(
                        konusma.okunmamisSayisi.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () {
              // Navigate to ChatScreen, passing conversation ID or participant info
              Navigator.of(context).pushNamed('/chat', arguments: {
                'konusmaId': konusma.id,
                'digerKatilimci': digerKatilimci
              });
            },
          );
        },
      ),
    );
  }
}
