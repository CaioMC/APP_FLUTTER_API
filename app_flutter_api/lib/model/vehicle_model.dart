
class VehicleModel {

  String ?nome;
  String ?codigo;

  VehicleModel(
      {this.nome,
      this.codigo});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    this.nome = json['nome'];
    this.codigo = json['codigo'];
  }
}