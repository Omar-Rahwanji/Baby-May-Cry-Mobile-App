import './pages/about-us.dart';
import 'pages/bookings_history.dart';
import './pages/home.dart';
import 'pages/language_settings.dart';
import './pages/login.dart';
import './pages/offices.dart';
import './pages/profile.dart';
import './pages/services.dart';
import './pages/signup.dart';
import 'pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // if your flutter > 1.7.8 :  ensure flutter activated

  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/lang/',
  );
  await Firebase.initializeApp();
  runApp(
    LocalizedApp(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: translator.delegates, // Android + iOS Delegates
      locale: translator.activeLocale, // Active locale
      supportedLocales: translator.locals(), // Locals list
      title: 'abs booking',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.1,
              fontSizeDelta: 1.0,
              fontFamily:
                  translator.activeLanguageCode == "en" ? "Roboto" : "Tajawal",
            ),
      ),
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const Directionality(
              textDirection: TextDirection.ltr,
              child: HomePage(),
            ),
        '/login': (context) => const Directionality(
              textDirection: TextDirection.ltr,
              child: LoginPage(),
            ),
        '/sign-up': (context) => const Directionality(
              textDirection: TextDirection.ltr,
              child: SignupPage(),
            ),
        '/offices': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: OfficesPage(),
            ),
        '/services': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: ServicesPage(),
            ),
        '/profile': (context) => const Directionality(
              textDirection: TextDirection.ltr,
              child: ProfilePage(),
            ),
        '/bookings-history': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: BookingsHistoryPage(),
            ),
        '/about-us': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: AboutUs(),
            ),
        '/language-settings': (context) => const Directionality(
              textDirection: TextDirection.ltr,
              child: LanguageSettings(),
            ),
      },
    );
  }
}
