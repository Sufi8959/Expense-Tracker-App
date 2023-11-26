import 'package:expense_tracker/constants/color_schemes.g.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:
          ThemeData(useMaterial3: true, colorScheme: lightColorScheme).copyWith(
        appBarTheme: AppBarTheme(
          foregroundColor: lightColorScheme.onPrimary,
          backgroundColor: lightColorScheme.onPrimaryContainer,
        ),
        cardTheme:
            const CardTheme().copyWith(color: lightColorScheme.secondary),
        textTheme: ThemeData().textTheme.copyWith(
              bodyMedium: TextStyle(
                fontStyle: FontStyle.italic,
                color: lightColorScheme.primaryContainer,
                fontWeight: FontWeight.w500,
              ),
              titleLarge: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: lightColorScheme.secondaryContainer),
        ),
        scaffoldBackgroundColor:
            Color(lightColorScheme.onSecondaryContainer.value),
      ),
      home: const HomeScreen(),
    );
  }
}
