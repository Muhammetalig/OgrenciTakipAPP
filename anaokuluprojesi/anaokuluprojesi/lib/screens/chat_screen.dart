import 'package:flutter/material.dart';
import '../models/messaging.dart'; // Gerekli model importu

class ChatScreen extends StatefulWidget {
  final String konusmaId;
  final KullaniciOzet digerKatilimci;

  const ChatScreen({
    super.key,
    required this.konusmaId,
    required this.digerKatilimci,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  // TODO: Mesajları Firestore'dan çekmek ve göndermek için logic ekle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.digerKatilimci.adSoyad),
        // İsteğe bağlı: Profil resmi veya diğer bilgiler
      ),
      body: Column(
        children: [
          Expanded(
            // TODO: Mesaj listesini burada göster (ListView.builder ile)
            child: Center(
              child: Text('Mesajlar (${widget.konusmaId})'),
            ),
          ),
          _buildMessageComposer(), // Mesaj yazma alanı
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Mesajınızı yazın...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              // TODO: Mesaj gönderme logic'i ekle
              onSubmitted: _sendMessage,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _sendMessage(_messageController.text),
            // TODO: Mesaj gönderme logic'i ekle
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    // TODO: Firestore'a mesaj gönderme logic'i
    print('Mesaj gönderiliyor: $text');
    _messageController.clear();
    // Klavyeyi gizle
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
