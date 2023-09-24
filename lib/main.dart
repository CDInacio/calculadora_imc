import 'package:calculadora_imc/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 131, 56, 236),
  brightness: Brightness.dark,
);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TabsScreen(),
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: kColorScheme,
          textTheme: GoogleFonts.latoTextTheme()),
    );
  }
}
