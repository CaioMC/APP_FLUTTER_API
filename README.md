# API calculo tabela FIPE #

A API usada foi a api da https://deividfortuna.github.io/fipe/ para conseguir fazer a consulta pelos campos Marca, Modelo e Ano.

Essas informações foram obtidas diretamente do site oficial da FIPE apenas fazendo leitura do código já existente.

A API disponibiliza os dados de busca no formato JSON. Onde o nosso aplicativo tratou esses resultados com um ```json.decode(response.body);```.

Antes de qualquer coisa se deve informar qual o tipo do veiculo, pois existem marcas diferentes de carro e moto. É selecionado carro como select padrão.

```String tipobusca = 'carro';```
```...```
```
if (tipobusca == 'carro') {
  url = Uri.parse(LinkCarro);
} else {
  url = Uri.parse(LinkMoto);
}
```

Após isso, pra selecionar a Marca foi feito um DropdownButton com o resultado da API com o tipo do veiculo.

```
Future<String> pegarMarcas() async {
  var url = Uri.parse('');
  if (tipobusca == 'carro') {
    url = Uri.parse(LinkCarro);
  } else {
    url = Uri.parse(LinkMoto);
  }
  var res = await http.get(url);
  var resBody = json.decode(res.body);

  setState(() {
    Marca = resBody[0]["codigo"];
    ListaMarcas = resBody;
  });

  return "Sucess";
}
```

Depois de selecionar a Marca, logo foi colocado um DropdownButton com o resultado da API usando como base o modelo.

```
Future<String> pegarModelos() async {
  var url = Uri.parse('');
  if (tipobusca == 'carro') {
    url = Uri.parse(LinkCarro + '/' + Marca + '/modelos');
  } else {
    url = Uri.parse(LinkMoto + '/' + Marca + '/modelos');
  }
  var res = await http.get(url);
  Map<String, dynamic> resBody = json.decode(res.body);
  List<dynamic> Lista = resBody['modelos'];

   setState(() {
    int Codigo = Lista[0]["codigo"];
    Modelo = Codigo.toString();
    ListaModelos = Lista;
  });

  return "Sucess";
}
```

Com o modelo já selecionado, falta apenas selecionar o Ano para poder fazer o calculo da FIPE

```
Future<String> pegarAnos() async {
  var url = Uri.parse('');
  if (tipobusca == 'carro') {
    url = Uri.parse(LinkCarro + '/' + Marca + '/modelos/' + Modelo + '/anos');
  } else {
    url = Uri.parse(LinkMoto + '/' + Marca + '/modelos/' + Modelo + '/anos');
  }
  var res = await http.get(url);
  var resBody = json.decode(res.body);

  setState(() {
    Ano = resBody[0]["codigo"];
    ListaAnos = resBody;
  });

  return "Sucess";
}
```

Com esse 3 valores selecionados, só enviar esses resultados para a API resornar o resultado via GET.

```
Future<String> pegarValor() async {
  var url = Uri.parse('');
  if (tipobusca == 'carro') {
    url = Uri.parse(LinkCarro + '/' + Marca + '/modelos/' + Modelo + '/anos/' + Ano);
  } else {
    url = Uri.parse(LinkMoto + '/' + Marca + '/modelos/' + Modelo + '/anos/' + Ano);
  }
  var res = await http.get(url);
  var resBody = json.decode(res.body);

  setState(() {
    MarcaTexto = resBody["Marca"];
    ModeloTexto = resBody["Modelo"];
    int AnoMod = resBody["AnoModelo"];
    AnoModeloTexto = AnoMod.toString();
    CombustivelTexto = resBody["Combustivel"];
    FipeTexto = resBody["CodigoFipe"];
    MesRefTexto = resBody["MesReferencia"];
    ValorTexto = resBody["Valor"];
  });

  return "Sucess";
}
```
