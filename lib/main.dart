import 'package:baby_may_cry/pages/about-us.dart';
import 'package:baby_may_cry/pages/bookings-history.dart';
import 'package:baby_may_cry/pages/home.dart';
import 'package:baby_may_cry/pages/language-settings.dart';
import 'package:baby_may_cry/pages/login.dart';
import 'package:baby_may_cry/pages/offices.dart';
import 'package:baby_may_cry/pages/otp.dart';
import 'package:baby_may_cry/pages/profile.dart';
import 'package:baby_may_cry/pages/services.dart';
import 'package:baby_may_cry/pages/signup.dart';
import 'package:baby_may_cry/pages/splash-screen.dart';
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
  // await Firebase.initializeApp();
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
        primarySwatch: Colors.green,
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.1,
              fontSizeDelta: 1.0,
              fontFamily:
                  translator.activeLanguageCode == "en" ? "Roboto" : "Tajawal",
            ),
      ),
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: HomePage(),
            ),
        '/login': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: LoginPage(),
            ),
        '/sign-up': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: SignupPage(),
            ),
        '/otp': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: OTPPage(),
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
        '/language-settings': (context) => Directionality(
              textDirection: TextDirection.ltr,
              child: LanguageSettings(),
            ),
      },
    );
  }
}
