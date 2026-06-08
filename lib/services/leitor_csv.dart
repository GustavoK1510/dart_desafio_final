import 'dart:io';
import '../models/registro_climatico.dart';
import 'dart:convert';

List<RegistroClimatico> lerCSV(String caminho) {
  final arquivo = File(caminho);
  final nomeArquivo = arquivo.uri.pathSegments.last;
  final String nomeArquivoSemExtensao = nomeArquivo.replaceAll('.csv', '');

  final List<String> partes = nomeArquivoSemExtensao.split('_');
  final String estado = partes[0];
  final int ano = int.parse(partes[1]);
  final int mes = int.parse(partes[2]);

  final List<RegistroClimatico> registros = [];
  final List<int> conteudoBytes = arquivo.readAsBytesSync();
  final String conteudoString = latin1.decode(conteudoBytes);
  final List<String> linhas = conteudoString.split('\n');

  for (int i = 1; i < linhas.length; i++) {
    final List<String> campos = linhas[i].split(',');

    if (campos.length < 8) {
      continue;
    }

    final String hora = campos[2].trim();
    final double temperatura = double.parse(campos[3].trim());
    final double umidade = double.parse(campos[4].trim());
    final double velocidadeVento = double.parse(campos[6].trim());
    final double direcaoVento = double.parse(campos[7].trim());

    registros.add(RegistroClimatico(
      estado: estado,
      ano: ano,
      mes: mes,
      hora: hora,
      temperatura: temperatura,
      umidade: umidade,
      velocidadeVento: velocidadeVento,
      direcaoVento: direcaoVento,
    ));
  }

  return registros;
}
