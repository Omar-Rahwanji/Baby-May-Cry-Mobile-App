import './pages/forgot_password.dart';
import './pages/about_us.dart';
import './pages/home.dart';
import './pages/language_settings.dart';
import './pages/login.dart';
import './pages/profile.dart';
import './pages/signup.dart';
import './pages/splash_screen.dart';
import './pages/guide_page1.dart';
import './pages/guide_page2.dart';
import './pages/guide_page3.dart';
import './pages/guide_page4.dart';
import './pages/guide_page5.dart';

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
        '/forgot-password': (context) => const Directionality(
              textDirection: TextDirection.ltr,
              child: ForgotPasswordPage(),
            ),
        '/profile': (context) => const Directionality(
              textDirection: TextDirection.ltr,
              child: ProfilePage(),
            ),
        '/about-us': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: AboutUsPage(),
            ),
        '/guide1': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: GuidePage1(),
            ),
        '/guide2': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: GuidePage2(),
            ),
        '/guide3': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: GuidePage3(),
            ),
        '/guide4': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: GuidePage4(),
            ),
        '/guide5': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: GuidePage5(),
            ),
        '/language-settings': (context) => const Directionality(
              textDirection: TextDirection.ltr,
              child: LanguageSettingsPage(),
            ),
      },
    );
  }
}
