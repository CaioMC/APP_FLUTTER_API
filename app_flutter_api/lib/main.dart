import 'package:app_flutter_api/blocs/search-plate_block.dart';
import 'package:app_flutter_api/ui/splash/splash_screen.dart';
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
        ChangeNotifierProvider(create: (_) => SearchPlateBloc())
      ],
      child: MaterialApp(
        title: "FLUTTER API - About plate",
        debugShowCheckedModeBanner: false,
        initialRoute: "splashScreen",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "splashScreen":
              return MaterialPageRoute(builder: (_) => SplashScreen());
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