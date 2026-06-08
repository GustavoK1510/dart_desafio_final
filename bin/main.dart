import 'package:clima/services/leitor_CSV.dart';
import 'package:clima/models/registro_climatico.dart';
import 'package:clima/services/analisador_climatico.dart';
import 'dart:io';

void main() {
  final Directory diretorio = Directory('C:\\clima\\sensores');
  final List<RegistroClimatico> todosRegistros = [];

  if (diretorio.existsSync()) {
    final List<FileSystemEntity> arquivos = diretorio.listSync();

    for (final FileSystemEntity arquivo in arquivos) {
      if (arquivo is File && arquivo.path.endsWith('.csv')) {
        final List<RegistroClimatico> registros = lerCSV(arquivo.path);
        todosRegistros.addAll(registros);
      }
    }

    final AnalisadorClimatico analisador = AnalisadorClimatico(todosRegistros);

    final double media = analisador.mediaTemperaturaPorEstadoEMes('SC', 1);

    print('Média de temperatura para SC em janeiro: ${media.toStringAsFixed(2)}°C');
  } else {
    print('Diretório não encontrado.');
  }
}