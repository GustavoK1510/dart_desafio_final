import 'dart:io';
import 'package:clima/models/registro_climatico.dart';
import 'package:clima/services/analisador_climatico.dart';
import 'package:clima/services/leitor_csv.dart';
import 'package:clima/services/relatorios.dart';

void menu() {
  final Directory diretorio = Directory('C:\\clima\\sensores');
  final List<RegistroClimatico> todosRegistros = [];

  print(diretorio.path);

  if (diretorio.existsSync()) {
    final List<FileSystemEntity> arquivos = diretorio.listSync();

    for (final FileSystemEntity arquivo in arquivos) {
      if (arquivo is File && arquivo.path.endsWith('.csv')) {
        final List<RegistroClimatico> registros = lerCSV(arquivo.path);
        todosRegistros.addAll(registros);
      }
    }

    final AnalisadorClimatico analisador = AnalisadorClimatico(todosRegistros);
    final Relatorios relatorios = Relatorios(analisador);
    while(true) {
      print('Olá, Marcelo. Que relatório você precisa?');
      print('1 - Temperatura');
      print('2 - Umidade');
      print('3 - Direção do vento');
      print('Digite uma opção:');

      String? opcao = stdin.readLineSync();

      switch (opcao) {
        case '1':
          final relatorio = relatorios.gerarRelatorioTemperatura();
          print(relatorio);
          break;

        case '2':
          final relatorio = relatorios.gerarRelatorioUmidade();
          print(relatorio);
          break;

        case '3':
          final relatorio = relatorios.gerarRelatorioDirecaoVento();
          print(relatorio);
          break;
      }
  }
  }
}