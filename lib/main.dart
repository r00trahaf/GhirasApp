import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ghiras/Page/HomePage.dart';
import 'Page/ForgotPasswordPage.dart';
import 'Page/LoginPage.dart';
import 'Page/RegisterPage.dart';
import 'Page/SplashPage.dart';
import 'Page/SupportPage.dart';
import 'Page/accountPage.dart';
import 'Page/questionsPage.dart';
import 'Page/user/waither.dart';
import 'Page/visitor/Bot.dart';
import 'Page/visitor/Education.dart';
import 'Page/visitor/start.dart';
import 'widgets/app_localization.dart';
import 'DefaultFirebaseOptions.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((_) {
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: false);
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ghiras',

      locale: _locale,
      supportedLocales: const [
        Locale("ar"),
      ],
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeListResolutionCallback: (deviceLocale, supportedLocales) {
        for (var local in supportedLocales) {
          if (local.languageCode == deviceLocale![0].languageCode) {
            return local;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: false,
        fontFamily: 'NeoSansArabic',
      ),
      initialRoute: "/SplashPage",
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        switch (settings.name) {
          case '/SplashPage':
            return MaterialPageRoute(builder: (_) => const SplashPage());
          case '/LoginPage':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/RegisterPage':
            return MaterialPageRoute(builder: (_) => const RegisterPage());
          case '/ForgotPasswordPage':
            return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
          case '/HomePage':
            return MaterialPageRoute(builder: (_) =>  HomePage(userType: arguments,currentIndex: 2));
            case '/SupportPage':
            return MaterialPageRoute(builder: (_) => const SupportPage());
            case '/questionsPage':
            return MaterialPageRoute(builder: (_) => const questionsPage());
            case '/accountPage':
            return MaterialPageRoute(builder: (_) => const accountPage());
            case '/weather':
            return MaterialPageRoute(builder: (_) => const weather());
            case '/start':
            return MaterialPageRoute(builder: (_) => const start());
            case '/Education':
            return MaterialPageRoute(builder: (_) => const Education());
            case '/Bot':
            return MaterialPageRoute(builder: (_) => const Bot());
          default:
            return null;
        }
      },
    );
  }
}