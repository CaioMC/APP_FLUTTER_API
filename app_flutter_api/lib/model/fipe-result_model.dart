
class FipeResultModel {
  
  String ?valor;
  String ?marca;
  String ?modelo;
  int ?anoModelo;
  String ?combustivel;
  String ?codigoFipe;
  String ?mesReferencia;
  int ?tipoVeiculo;
  String ?siglaCombustivel;

  FipeResultModel(
      {this.valor,
      this.marca,
      this.modelo,
      this.anoModelo,
      this.combustivel,
      this.codigoFipe,
      this.mesReferencia,
      this.tipoVeiculo,
      this.siglaCombustivel
      });

  FipeResultModel.fromjson(Map<String, dynamic> json) {
    this.valor = json['Valor'];
    this.marca = json['Marca'];
    this.modelo = json['Modelo'];
    this.anoModelo = json['AnoModelo'];
    this.combustivel = json['Combustivel'];
    this.codigoFipe = json['CodigoFipe'];
    this.mesReferencia = json['MesReferencia'];
    this.tipoVeiculo = json['TipoVeiculo'];
    this.siglaCombustivel = json['SiglaCombustivel'];
  }
}