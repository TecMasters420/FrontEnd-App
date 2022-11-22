import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'screens/reminder_details_page/reminders_details_page.dart';
import 'screens/home_page/home_page.dart';
import 'screens/initial_page/initial_information_page.dart';
import 'screens/login_page/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'screens/map_page/map_page.dart';
import 'screens/register_page/register_page.dart';
import 'screens/reminders_page/reminders_page.dart';
import 'screens/user_profile_page/user_profile_page.dart';
import 'services/auth_service.dart';
import 'services/initial_announcements_service.dart';
import 'services/reminder_service.dart';

import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
        ChangeNotifierProvider<ReminderService>(
            create: (context) => ReminderService()),
        ChangeNotifierProvider<InitialAnnouncementsService>(
            create: (context) => InitialAnnouncementsService()),
      ],
      child: MaterialApp(
        title: 'Schedule Manager',
        debugShowCheckedModeBanner: false,
        home: const InitialInformationPage(),
        routes: {
          'initialInformationPage': (context) => const InitialInformationPage(),
          'loginPage': (context) => const LoginPage(),
          'homePage': (context) => const HomePage(),
          'registerPage': (context) => const RegisterPage(),
          'reminderDetailsPage': (context) =>
              const ReminderDetailsPage(reminder: null),
          'remindersPage': (context) => const RemindersPage(),
          'userProfilePage': (context) => const UserProfilePage(),
          'mapPage': (context) => const MapPage(),
        },
      ),
    );
  }
}
