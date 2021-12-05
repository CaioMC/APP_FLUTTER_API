
import 'package:app_flutter_api/interceptor/interceptor.dart';
import 'package:flutter/material.dart';

class VehicleService {
  
   Future<dynamic> listAllCarModel(BuildContext context) async {
    try {
      final response = await getDio(context).get("carros/marcas");
      return Future.value(response);
    } on Error catch (e) {
      throw e;
    }
  }

  Future<dynamic> listAllMotorcycleModel(BuildContext context) async {
    try { 
      final response = await getDio(context).get("motos/marcas");
      return Future.value(response);
    } on Error catch (e) {
      throw e;
    }
  }

  Future<dynamic> listAllCarByModel(BuildContext context, String vehicleMake) async {
    try { 
      final response = await getDio(context).get("carros/marcas/$vehicleMake/modelos");
      return Future.value(response);
    } on Error catch (e) {
      throw e;
    }
  }

  Future<dynamic> listAllMotorcycleByModel(BuildContext context, String vehicleMake, String vehicleModel) async {
    try { 
      final response = await getDio(context).get("motos/marcas/$vehicleMake/modelos/$vehicleModel/anos");
      return Future.value(response);
    } on Error catch (e) {
      throw e;
    }
  }

  Future<dynamic> getCarOfTheFIPETable(BuildContext context, String vehicleMake, String vehicleModel, String yearCode) async {
    try { 
      final response = await getDio(context).get("carros/marcas/$vehicleMake/modelos/$vehicleModel/anos/$yearCode");
      return Future.value(response);
    } on Error catch (e) {
      throw e;
    }
  }

  Future<dynamic> getMotorcycleResultOfTheFIPETable(BuildContext context, String vehicleMake, String vehicleModel, String yearCode) async {
    try { 
      final response = await getDio(context).get("motos/marcas/$vehicleMake/modelos/$vehicleModel/anos/$yearCode");
      return Future.value(response);
    } on Error catch (e) {
      throw e;
    }
  }
}