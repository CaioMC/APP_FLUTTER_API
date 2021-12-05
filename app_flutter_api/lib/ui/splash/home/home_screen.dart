import 'package:app_flutter_api/blocs/vehicleBloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleBloc>(builder: (_, vehicleBloc, __) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Row(
              children: [
                Text(
                  "FIPE TABLE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.bungee().fontFamily,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black,
                        blurRadius: 3,
                        offset: Offset(3, 1),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        backgroundColor: const Color(0xFFcfdfe1),
        body: RawScrollbar(
          controller: scrollController,
          child: ListView(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: []
          ),
        ),
      );
    });
  }
}
