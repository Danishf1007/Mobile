import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const DividendCalculatorApp());
}

class DividendCalculatorApp extends StatelessWidget {
  const DividendCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {

    const Color primarySeedColor = Color(0xFF00796B);

    return MaterialApp(
      title: 'Dividend Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primarySeedColor,
          brightness: Brightness.light,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,

        appBarTheme: AppBarTheme(
          backgroundColor: primarySeedColor,
          foregroundColor: Colors.white,
          elevation: 2.0,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: primarySeedColor.withOpacity(0.4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: primarySeedColor, width: 1.5),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIconColor: primarySeedColor.withOpacity(0.7),
          labelStyle: TextStyle(color: primarySeedColor.withOpacity(0.9)),
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primarySeedColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 1.5,
          ),
        ),

        cardTheme: CardTheme(
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          color: Colors.white,
        ),

        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: Colors.grey[850],
          displayColor: primarySeedColor,
        ).copyWith(
          headlineSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: primarySeedColor,
            fontWeight: FontWeight.w600,
          ).apply(fontFamily: 'Roboto'),
          headlineMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: primarySeedColor,
            fontWeight: FontWeight.bold,
          ).apply(fontFamily: 'Roboto'),
          titleLarge: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: primarySeedColor,
            fontWeight: FontWeight.bold,
          ).apply(fontFamily: 'Roboto'),
          bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[800],
          ).apply(fontFamily: 'Roboto'),
          labelLarge: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ).apply(fontFamily: 'Roboto'),
        ),

        iconTheme: IconThemeData(
          color: primarySeedColor.withOpacity(0.8),
        ),

        dividerTheme: DividerThemeData(
          color: Colors.grey[300],
          thickness: 0.8,
        ),

        scaffoldBackgroundColor: Colors.grey[50], //

      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// The MyHomePage widget below is the default Flutter counter app.
// It's not currently part of your main app navigation (HomeScreen, AboutScreen etc.)
// but it will also inherit the new theme if you were to navigate to it.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor will now be primarySeedColor due to appBarTheme
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',

              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',

        child: const Icon(Icons.add),
      ),
    );
  }
}