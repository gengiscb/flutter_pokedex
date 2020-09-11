import 'package:flutter/material.dart';
import 'package:pokedex/models/status_auth.dart';
import 'package:pokedex/providers/auth.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/screens/home_page.dart';
import 'package:pokedex/screens/login_page.dart';
import 'package:pokedex/screens/onboarding_page.dart';
import 'package:pokedex/screens/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider.initialize()),
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScreensController(),
    );
  }
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    bool firstOpen = auth.firstOpen;
    print(auth.status);
    switch (auth.status) {
      case Status.Uninitialized:
        return SplashPage();
      case Status.Unauthenticated:
        return firstOpen ? OnBoardingPage() : LoginPage();
      case Status.Authenticated:
        return HomePage();
      default:
        return LoginPage();
    }
  }
}
