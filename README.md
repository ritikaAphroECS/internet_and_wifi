## Internet and Wifi

A new Flutter package that checks for an internet connection by opening a socket to a list of specified addresses, each with individual port and timeout. Defaults are provided for convenience. Also this plugin allows Flutter apps to discover network connectivity and configure themselves accordingly. It can distinguish between cellular vs WiFi connection. It also covers the case when the wifi is connected but there is no internet.

<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A new Flutter package that checks for an internet connection by opening a socket to a list of specified addresses, each with individual port and timeout. Defaults are provided for convenience. Also this plugin allows Flutter apps to discover network connectivity and configure themselves accordingly. It can distinguish between cellular vs WiFi connection. It also covers the case when the wifi is connected but there is no internet.

## Features

It checks whether internet is connected or not with the device.
It also checks whether internet is connected or wifi is connected.
It also checks the condition when internet or wifi is connected but there is no internet.

## Getting started

Add the package in pubspec.yaml file.

## Usage

# Here is the code:
 In main.dart,

```
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
```

<!-- ## Additional information -->
