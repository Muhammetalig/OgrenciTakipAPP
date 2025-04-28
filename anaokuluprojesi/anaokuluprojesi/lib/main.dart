import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import for initialization
import 'utils/app_colors.dart'; // Import AppColors
// Import models needed for chat route arguments
import 'models/messaging.dart';

// Import the screens
import 'screens/login_screen.dart';
import 'screens/teacher_home_screen.dart';
import 'screens/parent_home_screen.dart';
import 'screens/announcements_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/parent_daily_report_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/conversations_screen.dart'; // Added import
import 'screens/chat_screen.dart'; // Added import

Future<void> main() async {
  // Make main async
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize date formatting for Turkish locale
  await initializeDateFormatting('tr_TR', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anaokulu Projesi', // Updated title
      theme: ThemeData(
          // Use AppColors for the color scheme
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryBlue,
            primary: AppColors.primaryBlue,
            secondary: AppColors.accentPurple,
            error: AppColors.error,
            // You might want to define other colors like surface, background etc.
            surface: AppColors.background,
          ),
          scaffoldBackgroundColor:
              AppColors.background, // Set default background
          useMaterial3: true,
          // Define AppBar theme
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white, // Text/icon color on AppBar
            elevation: 1.0,
            centerTitle: true, // Center title by default
            titleTextStyle: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          // Define Text Button theme globally
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor:
                  AppColors.darkPurple, // Use dark purple for links
            ),
          ),
          // Define ElevatedButton theme globally
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.accentPurple, // Use accent purple for main buttons
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // Define Card theme
          cardTheme: CardTheme(
            elevation: 1.0,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            color: AppColors.cardBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              // side: BorderSide(color: AppColors.divider, width: 0.5) // Optional border
            ),
          ),
          // Define ListTile theme
          listTileTheme: const ListTileThemeData(
            iconColor:
                AppColors.primaryBlue, // Default icon color for ListTiles
            textColor: AppColors.textPrimary,
            // dense: true, // Make ListTiles dense by default if desired
          ),
          // Define Divider theme
          dividerTheme: const DividerThemeData(
            color: AppColors.divider,
            space: 1, // Default space is 16, reduce it
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          // Define ExpansionTile theme (especially icon color)
          expansionTileTheme: const ExpansionTileThemeData(
            iconColor: AppColors.primaryBlue, // Color for expand/collapse icon
            collapsedIconColor: AppColors.textSecondary, // Color when collapsed
            textColor: AppColors.textPrimary, // Title color when closed
            collapsedTextColor: AppColors.textPrimary, // Title color when open
          ),
          // Define default text theme
          textTheme: const TextTheme(
            bodyMedium:
                TextStyle(color: AppColors.textPrimary), // Default text color
            titleMedium:
                TextStyle(color: AppColors.textPrimary), // ListTile title etc.
            titleLarge: TextStyle(
                color: AppColors
                    .textPrimary), // AppBar title (overridden by AppBarTheme)
            labelLarge:
                TextStyle(color: Colors.white), // ElevatedButton text style
            bodySmall: TextStyle(
                color: AppColors.textSecondary), // Hint/secondary text
          ),
          // Define InputDecoration theme globally
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.divider)),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.primaryBlue, width: 1.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.divider)),
            labelStyle: const TextStyle(color: AppColors.textSecondary),
            prefixIconColor: AppColors.textSecondary,
          )),
      debugShowCheckedModeBanner: false, // Remove debug banner
      // Define the initial route
      initialRoute: '/login', // Start with the login screen
      // Define the routes for different roles
      routes: {
        '/login': (context) => const LoginScreen(),
        '/teacher_home': (context) => const TeacherHomeScreen(),
        '/parent_home': (context) => const ParentHomeScreen(),
        '/announcements': (context) => const AnnouncementsScreen(),
        '/menu': (context) => const MenuScreen(),
        '/parent_daily_report': (context) => ParentDailyReportScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/conversations': (context) =>
            const ConversationsScreen(), // Added route
        // Define route for ChatScreen, extracting arguments
        '/chat': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          if (args != null &&
              args['konusmaId'] is String &&
              args['digerKatilimci'] is KullaniciOzet) {
            return ChatScreen(
              konusmaId: args['konusmaId'] as String,
              digerKatilimci: args['digerKatilimci'] as KullaniciOzet,
            );
          } else {
            // Handle error: arguments are missing or incorrect type
            // Return a default screen or an error screen
            // For now, returning ConversationsScreen as a fallback
            return const ConversationsScreen();
          }
        },
        // Add other routes here as needed
      },
    );
  }
}

// Removed the default MyHomePage StatefulWidget and its State
