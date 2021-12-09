import 'package:app_flutter_api/blocs/vehicle_bloc.dart';
import 'package:app_flutter_api/ui/splash/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static const Color DEFAULT_COLOR = Color(0xFFC10011); 

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _primaryColor = MyApp.DEFAULT_COLOR;

  setPrimaryColor(Color color) {
    setState(() {
      _primaryColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VehicleBloc())
      ],
      child: MaterialApp(
        title: "FLUTTER API - About plate",
        debugShowCheckedModeBanner: false,
        initialRoute: "homeScreen",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "homeScreen":
              return MaterialPageRoute(builder: (_) => HomeScreen());
            default:
          }
        },
        theme: ThemeData(
            primaryColor: _primaryColor,
            scaffoldBackgroundColor: Colors.white,
            inputDecorationTheme: InputDecorationTheme(),
            fontFamily: GoogleFonts.roboto().fontFamily,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(elevation: 0)),
      ),
    );
  }
}