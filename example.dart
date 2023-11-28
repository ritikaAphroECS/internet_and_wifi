import 'package:flutter/material.dart';
import 'package:internet_and_wifi/src/internet_connection_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<InternetConnectionProvider>(
            create: (_) => InternetConnectionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InternetConnectionProvider>(
        builder: (context, internetProvider, child) {
      return MaterialApp(
        navigatorKey: key,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: Color(0xFF000000)),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        home: Builder(builder: (context) {
          return const Home();
        }),
        routes: <String, WidgetBuilder>{
          "/home": (context) => const Home(),
        },
      );
    });
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
