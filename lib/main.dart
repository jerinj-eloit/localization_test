import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization_test/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localization_test/locales_model.dart';
import 'package:provider/provider.dart';

import 'localization_provider.dart';
import 'dart:math' as math;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocalizationProvider(),
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LocalizationProvider>();
    return MaterialApp(
      title: 'Flutter Demo',
      locale: provider.locale.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<LocaleModel> locales = [
    LocaleModel(const Locale('en'), "English"),
    LocaleModel(const Locale('ro'), "Romanian"),
    LocaleModel(const Locale('ml'), "Malayalam"),
    LocaleModel(const Locale('hi'), "Hindi"),
    LocaleModel(const Locale('zh'), "Chinese"),
    LocaleModel(const Locale('th'), "Thai"),
  ];

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LocalizationProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          AppLocalizations.of(context)!.flutterDemoHomepage,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          AppLocalizations.of(context)!.dummy,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SingleChildScrollView(
        child: Column(
          children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(locales.length, (int index) {
                  Widget child = Container(
                    height: 80.0,
                    padding: const EdgeInsets.only(bottom: 20),
                    alignment: FractionalOffset.center,
                    child: ScaleTransition(
                      scale: CurvedAnimation(
                        parent: _controller,
                        curve: Interval(0.0, 1.0 - index / locales.length / 2.0,
                            curve: Curves.easeOut),
                      ),
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        isExtended: true,
                        label: Text(locales[index].name),
                        onPressed: () {
                          provider.setLocale(locales[index]);
                          _controller.reverse();
                        },
                      ),
                    ),
                  );
                  return child;
                })),
            FloatingActionButton.extended(
              heroTag: null,
              tooltip: "Change language",
              label: Text(provider.locale.name),
              icon: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform(
                    transform:
                        Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                    alignment: FractionalOffset.center,
                    child: Icon(_controller.isDismissed
                        ? Icons.language_rounded
                        : Icons.close),
                  );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
