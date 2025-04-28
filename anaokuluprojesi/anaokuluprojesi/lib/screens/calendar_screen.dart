import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // For formatting event time
import '../models/event.dart'; // Import Etkinlik model
import '../utils/app_colors.dart'; // Import AppColors for styling

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Calendar state variables
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Sample event data (replace with actual data fetching logic)
  // Using a Map where keys are DateTime objects (normalized to day) and values are lists of events
  late final Map<DateTime, List<Etkinlik>> _etkinlikler;

  // Sample event creation
  final DateTime today = DateTime.now();
  final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
  final DateTime nextWeek = DateTime.now().add(const Duration(days: 7));

  List<Etkinlik> _getEventsForDay(DateTime day) {
    // Implementation example
    // Normalize the day to avoid time comparison issues
    DateTime normalizedDay = DateTime(day.year, day.month, day.day);
    return _etkinlikler[normalizedDay] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _etkinlikler = {
      DateTime(today.year, today.month, today.day): [
        Etkinlik(
            id: 'e1',
            baslik: 'Sanat Etkinliği: Parmak Boyama',
            tarih: today.copyWith(hour: 10)),
        Etkinlik(
            id: 'e2', baslik: 'Müzik Saati', tarih: today.copyWith(hour: 14)),
      ],
      DateTime(tomorrow.year, tomorrow.month, tomorrow.day): [
        Etkinlik(
            id: 'e3',
            baslik: 'Bahçe Oyunları',
            tarih: tomorrow.copyWith(hour: 11)),
      ],
      DateTime(nextWeek.year, nextWeek.month, nextWeek.day): [
        Etkinlik(
            id: 'e4',
            baslik: 'Veli Katılımlı Kahvaltı',
            tarih: nextWeek.copyWith(hour: 9)),
      ],
      DateTime(today.year, today.month, 28): [
        // Specific date example
        Etkinlik(
            id: 'e5',
            baslik: 'Doğum Günü Kutlaması: Ayşe',
            tarih: today.copyWith(day: 28, hour: 15)),
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etkinlik Takvimi'),
      ),
      body: Column(
        children: [
          TableCalendar<Etkinlik>(
            locale: 'tr_TR', // Set locale for Turkish day/month names
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` as well
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
            eventLoader:
                _getEventsForDay, // Function to load events for each day
            // --- Styling ---
            calendarStyle: CalendarStyle(
              // Use AppColors for styling
              markerDecoration: const BoxDecoration(
                  color: AppColors.accentPurple, shape: BoxShape.circle),
              todayDecoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.5),
                  shape: BoxShape.circle),
              selectedDecoration: const BoxDecoration(
                  color: AppColors.primaryBlue, shape: BoxShape.circle),
              weekendTextStyle:
                  TextStyle(color: AppColors.red.withOpacity(0.8)),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false, // Hide format button
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 8.0),
          // --- Selected Day's Events ---
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
    );
  }

  // Widget to build the list of events for the selected day
  Widget _buildEventList() {
    final selectedEvents = _getEventsForDay(_selectedDay!);

    if (selectedEvents.isEmpty) {
      return const Center(child: Text('Seçili günde etkinlik bulunmuyor.'));
    }

    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        final etkinlik = selectedEvents[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: ListTile(
              leading: CircleAvatar(
                // Show event time
                backgroundColor: AppColors.accentPurple,
                foregroundColor: Colors.white,
                child: Text(DateFormat('HH:mm').format(etkinlik.tarih)),
              ),
              title: Text(etkinlik.baslik),
              subtitle:
                  etkinlik.aciklama != null ? Text(etkinlik.aciklama!) : null,
              onTap: () {
                // Optional: Show event details in a dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(etkinlik.baslik),
                    content: SingleChildScrollView(
                        child: Text(
                            "${DateFormat('dd MMMM yyyy, HH:mm', 'tr_TR').format(etkinlik.tarih)}\n\n${etkinlik.aciklama ?? 'Açıklama yok.'}")),
                    actions: [
                      TextButton(
                        child: const Text('Kapat'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
