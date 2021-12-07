import 'package:app_flutter_api/blocs/vehicleBloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchType = 'carro';

  String brand = '';
  String model = '';
  String year = '';

  String LinkMotorcycle = 'https://parallelum.com.br/fipe/api/v1/motos/marcas';
  String LinkCar = 'https://parallelum.com.br/fipe/api/v1/carros/marcas';

  List ListBrands = [];
  List ListModels = [];
  List ListYears = [];
  List value = [];

  String textBrand = '';
  String textModel = '';
  String texteYearToModel = '';
  String textFuel = '';
  String textFipe = '';
  String textMonthRef = '';
  String textValue = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleBloc>(builder: (_, vehicleBloc, __) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Center(
            child: Text(
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
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: 'carro',
                    groupValue: searchType,
                    onChanged: (value) {
                      setState(() {
                        ListBrands = [];
                        searchType = 'carro';
                        brand = '1';
                        getBrands();
                        ListYears = [];
                        ListModels = [];
                        resetLabels();
                      });
                    },
                  ),
                  Text('Carros'),
                  SizedBox(width: 10),
                  Radio(
                    value: 'moto',
                    groupValue: searchType,
                    onChanged: (value) {
                      setState(() {
                        ListBrands = [];
                        searchType = 'moto';
                        brand = '60';
                        getBrands();
                        ListYears = [];
                        ListModels = [];
                        resetLabels();
                      });
                    },
                  ),
                  Text('Motos'),
                  SizedBox(width: 10),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: brand,
                            isExpanded: true,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            hint: Text('Selecione a Marca'),
                            onChanged: (newValue) {
                              setState(() {
                                brand = newValue as String;
                                getModels();
                                ListYears = [];
                                resetLabels();
                              });
                            },
                            items: ListBrands.map((item) {
                              return DropdownMenuItem(
                                child: Text(item['nome']),
                                value: item['codigo'].toString(),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: model,
                            isExpanded: true,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            hint: Text('Selecione o Modelo'),
                            onChanged: (newValue) {
                              setState(() {
                                model = newValue as String;
                                getYears();
                                resetLabels();
                              });
                            },
                            items: ListModels.map((item) {
                              return DropdownMenuItem(
                                child: Text(item['nome']),
                                value: item['codigo'].toString(),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: year,
                            isExpanded: true,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            hint: Text('Selecione o Ano'),
                            onChanged: (newValue) {
                              setState(() {
                                year = newValue as String;
                                getValues();
                              });
                            },
                            items: ListYears.map((item) {
                              return DropdownMenuItem(
                                child: Text(item['nome']),
                                value: item['codigo'].toString(),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CreateLabel('Marca', textBrand),
              CreateLabel('Modelo', textModel),
              CreateLabel('Ano', texteYearToModel),
              CreateLabel('Combustível', textFuel),
              CreateLabel('Código Fipe', textFipe),
              CreateLabel('Mês Referência', textMonthRef),
              CreateLabel('Valor', textValue)
            ],
          ),
        ),
      );
    });
  }

  Future<String> getBrands() async {
    var url = Uri.parse('');
    if (searchType == 'carro') {
      url = Uri.parse(LinkCar);
    } else {
      url = Uri.parse(LinkMotorcycle);
    }
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    setState(() {
      brand = resBody[0]["codigo"];
      ListBrands = resBody;
    });

    return "Sucess";
  }

  void resetLabels() {
    setState(() {
      textBrand = '';
      textModel = '';
      texteYearToModel = '';
      textFuel = '';
      textFipe = '';
      textMonthRef = '';
      textValue = '';
    });
  }

  Future<String> getModels() async {
    var url = Uri.parse('');
    if (searchType == 'carro') {
      url = Uri.parse(LinkCar + '/' + brand + '/modelos');
    } else {
      url = Uri.parse(LinkMotorcycle + '/' + brand + '/modelos');
    }
    var res = await http.get(url);
    Map<String, dynamic> resBody = json.decode(res.body);
    List<dynamic> Lista = resBody['modelos'];

    setState(() {
      int Codigo = Lista[0]["codigo"];
      model = Codigo.toString();
      ListModels = Lista;
    });
    return "Sucess";
  }

  Future<String> getYears() async {
    var url = Uri.parse('');
    if (searchType == 'carro') {
      url = Uri.parse(LinkCar + '/' + brand + '/modelos/' + model + '/anos');
    } else {
      url = Uri.parse(LinkMotorcycle + '/' + brand + '/modelos/' + model + '/anos');
    }
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    setState(() {
      year = resBody[0]["codigo"];
      ListYears = resBody;
    });

    return "Sucess";
  }

  Future<String> getValues() async {
    var url = Uri.parse('');
    if (searchType == 'carro') {
      url = Uri.parse(LinkCar + '/' + brand + '/modelos/' + model + '/anos/' + year);
    } else {
      url = Uri.parse(LinkMotorcycle + '/' + brand + '/modelos/' + model + '/anos/' + year);
    }
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    setState(() {
      textBrand = resBody["Marca"];
      textModel = resBody["Modelo"];
      int AnoMod = resBody["AnoModelo"];
      texteYearToModel = AnoMod.toString();
      textFuel = resBody["Combustivel"];
      textFipe = resBody["CodigoFipe"];
      textMonthRef = resBody["MesReferencia"];
      textValue = resBody["Valor"];
    });

    return "Sucess";
  }

  CreateLabel(String label, String Resultado) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10.0, 5.0, 5.0),
          child: Text(label + ': ', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 16)),
        ),
        Expanded(
          child: Text(Resultado,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 18,
              )),
        )
      ],
    );
  }
}
