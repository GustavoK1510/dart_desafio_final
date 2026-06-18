import 'dart:io';
import 'package:clima/models/registro_climatico.dart';
import 'package:clima/services/analisador_climatico.dart';
import 'package:clima/services/leitor_csv.dart';
import 'package:clima/services/relatorios.dart';
import 'package:clima/services/utils/salvar_relatorio.dart';

Future<void> menu() async {
  try {
    final Directory diretorio = Directory('C:\\clima\\sensores');
    final List<RegistroClimatico> todosRegistros = [];

    if (!diretorio.existsSync()) {
      print('Falha ao extrair informações: diretório não encontrado.');
      return;
    }

    final List<FileSystemEntity> arquivos = diretorio.listSync();

    if (arquivos.isEmpty) {
      print('Falha ao extrair informações: nenhum arquivo encontrado.');
      return;
    }

    for (final arquivo in arquivos) {
      try {
        if (arquivo is File && arquivo.path.endsWith('.csv')) {
          final registros = lerCSV(arquivo.path);
          todosRegistros.addAll(registros);
        }
      } catch (e) {
        print('Falha na leitura do arquivo: ${arquivo.path}');
        print('Detalhes: $e');
      }
    }

    final analisador = AnalisadorClimatico(todosRegistros);
    final relatorios = Relatorios(analisador);

    while (true) {
      print('\nOlá, Leandro. Que relatório você precisa?');
      print('1 - Temperatura');
      print('2 - Umidade');
      print('3 - Direção do vento');
      print('0 - Sair');
      print('Digite uma opção:');

      final String? opcao = stdin.readLineSync();

      try {
        switch (opcao) {
          case '1':
            final relatorioTerminal = relatorios.gerarRelatorioTemperatura();

            print(relatorioTerminal);

            final relatorioArquivo = relatorioTerminal.replaceAll(RegExp(r'\x1B\[[0-9;]*m'), '');

            await salvarRelatorio(relatorioArquivo, 'CLIMA');
            break;

          case '2':
            final relatorioTerminal = relatorios.gerarRelatorioUmidade();

            print(relatorioTerminal);

            final relatorioArquivo = relatorioTerminal.replaceAll(RegExp(r'\x1B\[[0-9;]*m'), '');

            await salvarRelatorio(relatorioArquivo, 'UMIDADE');
            break;

          case '3':
            final relatorioTerminal = relatorios.gerarRelatorioDirecaoVento();

            print(relatorioTerminal);

            final relatorioArquivo = relatorioTerminal.replaceAll(RegExp(r'\x1B\[[0-9;]*m'), '');

            await salvarRelatorio(relatorioArquivo, 'VENTO');
            break;

          case '0': 
            print('Programa encerrado.');
            return;

          default:
            print('Opção inválida.');
        }
      } catch (e) {
        print('Erro ao gerar relatório.');
        print('Detalhes: $e');
      }
    }
  } catch (e) {
    print('Erro inesperado durante a execução do programa.');
    print('Detalhes: $e');
  }
}