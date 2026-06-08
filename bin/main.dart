import 'package:clima/services/leitor_CSV.dart';
import 'package:clima/models/registro_climatico.dart';
import 'dart:io';
import 'package:clima/services/analisador_climatico.dart';

void main() {
  final Directory diretorio = Directory('C:\\clima\\sensores');
  if (diretorio.existsSync()) {
    final List<FileSystemEntity> arquivos = diretorio.listSync();
    for (final FileSystemEntity arquivo in arquivos) {
      if (arquivo is File && arquivo.path.endsWith('.csv')) {
        final List<RegistroClimatico> registros = lerCSV(arquivo.path);
        final AnalisadorClimatico analisador = AnalisadorClimatico(registros);
        final media = analisador.MediaTemperaturaPorEstadoEMes('SC', 1);
        print('Média de temperatura para SC em janeiro: $media');
      }
    }
  }
}