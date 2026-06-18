import 'dart:io';

Future<void> salvarRelatorio(String conteudo, String tipo) async {
  final agora = DateTime.now();

  final data = '${agora.year}-${agora.month.toString().padLeft(2, '0')}-${agora.day.toString().padLeft(2, '0')}';

  final hora = '${agora.hour.toString().padLeft(2, '0')}-${agora.minute.toString().padLeft(2, '0')}';

  final nomeArquivo = '${tipo}_${data}_$hora.txt';

  final arquivo = File(nomeArquivo);

  await arquivo.writeAsString(conteudo);

  print('Relatório salvo em: $nomeArquivo');
}