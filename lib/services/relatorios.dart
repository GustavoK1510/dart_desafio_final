import 'package:clima/models/registro_climatico.dart';
import 'package:clima/services/analisador_climatico.dart';
import 'package:clima/services/utils/conversores.dart';
import 'package:yaansi/yaansi.dart';

class Relatorios {
  final AnalisadorClimatico analisador;

  Relatorios(this.analisador);

  String gerarRelatorioTemperatura() {
    final buffer = StringBuffer();
    final estados = analisador.registros.map((r) => r.estado).toSet();
    final anos = analisador.registros.map((r) => r.ano).toSet();
    buffer.writeln('--- Relatório de Temperatura ---');
    for (final ano in anos) {
      buffer.writeln('Ano: $ano');
      for (final estado in estados) {
        final mediaAno = analisador.mediaTemperaturaPorEstadoEAno(estado, ano);
        buffer.writeln('Média em $estado: ${red(mediaAno.toStringAsFixed(1))}°C');
        buffer.writeln('Média em $estado: ${yellow(converterCelsiusParaFahrenheit(mediaAno).toStringAsFixed(1))}°F');
        buffer.writeln('Média em $estado: ${blue(converterCelsiusParaKelvin(mediaAno).toStringAsFixed(1))}K');

        for (int mes = 1; mes <= 12; mes++) {
          buffer.writeln('Mês: $mes');
          final mediaMes = analisador.mediaTemperaturaPorEstadoEMes(estado, mes);
          buffer.writeln('Média em $estado: ${red(mediaMes.toStringAsFixed(1))}°C');
          buffer.writeln('Média em $estado: ${yellow(converterCelsiusParaFahrenheit(mediaMes).toStringAsFixed(1))}°F');
          buffer.writeln('Média em $estado: ${blue(converterCelsiusParaKelvin(mediaMes).toStringAsFixed(1))}K');
        }

        final tempMaxAno = analisador.temperaturaMaximaPorEstadoPorAno(estado, ano);
        buffer.writeln('Temperatura máxima registrada em $estado: ${red(tempMaxAno.toStringAsFixed(1))}°C');
        buffer.writeln('Temperatura máxima registrada em $estado: ${yellow(converterCelsiusParaFahrenheit(tempMaxAno).toStringAsFixed(1))}°F');
        buffer.writeln('Temperatura máxima registrada em $estado: ${blue(converterCelsiusParaKelvin(tempMaxAno).toStringAsFixed(1))}K');

        for (int mes = 1; mes <= 12; mes++) {
          buffer.writeln('Mês: $mes');
          final tempMaxMes = analisador.temperaturaMaximaPorEstadoPorMes(estado, mes);
          buffer.writeln('Temperatura máxima registrada em $estado: ${red(tempMaxMes.toStringAsFixed(1))}°C');
          buffer.writeln('Temperatura máxima registrada em $estado: ${yellow(converterCelsiusParaFahrenheit(tempMaxMes).toStringAsFixed(1))}°F');
          buffer.writeln('Temperatura máxima registrada em $estado: ${blue(converterCelsiusParaKelvin(tempMaxMes).toStringAsFixed(1))}K');
        }

        final tempMinAno = analisador.temperaturaMinimaPorEstadoPorAno(estado, ano);
        buffer.writeln('Temperatura mínima registrada em $estado: ${red(tempMinAno.toStringAsFixed(1))}°C');
        buffer.writeln('Temperatura mínima registrada em $estado: ${yellow(converterCelsiusParaFahrenheit(tempMinAno).toStringAsFixed(1))}°F');
        buffer.writeln('Temperatura mínima registrada em $estado: ${blue(converterCelsiusParaKelvin(tempMinAno).toStringAsFixed(1))}K');

        for (int mes = 1; mes <= 12; mes++) {
          buffer.writeln('Mês: $mes');
          final tempMinMes = analisador.temperaturaMinimaPorEstadoPorMes(estado, mes);
          buffer.writeln('Temperatura mínima registrada em $estado: ${red(tempMinMes.toStringAsFixed(1))}°C');
          buffer.writeln('Temperatura mínima registrada em $estado: ${yellow(converterCelsiusParaFahrenheit(tempMinMes).toStringAsFixed(1))}°F');
          buffer.writeln('Temperatura mínima registrada em $estado: ${blue(converterCelsiusParaKelvin(tempMinMes).toStringAsFixed(1))}K');
        }

        final mediaPorHorario = analisador.mediaTemperaturaPorHorarioPorEstado(estado);
        buffer.writeln('Média de temperatura por horário em $estado:');
        for (final entry in mediaPorHorario.entries) {
          buffer.writeln('  - ${entry.key}: ${red(entry.value.toStringAsFixed(1))}°C');
          buffer.writeln('  - ${entry.key}: ${yellow(converterCelsiusParaFahrenheit(entry.value).toStringAsFixed(1))}°F');
          buffer.writeln('  - ${entry.key}: ${blue(converterCelsiusParaKelvin(entry.value).toStringAsFixed(1))}K');
        }
      }
    }
    return buffer.toString();
  }

  String gerarRelatorioUmidade() {
    final buffer = StringBuffer();
    final estados = analisador.registros.map((r) => r.estado).toSet();
    final anos = analisador.registros.map((r) => r.ano).toSet();
    buffer.writeln('--- Relatório de Umidade ---');
    for (final ano in anos) {
      buffer.writeln('Ano: $ano');
      for (final estado in estados) {
        final mediaAno = analisador.mediaUmidadePorEstadoEAno(estado, ano);
        buffer.writeln('Média de umidade por ano em $estado: ${green(mediaAno.toStringAsFixed(2))}%');

        for (int mes = 1; mes <= 12; mes++) {
          buffer.writeln('Mês: $mes');
          final mediaMes = analisador.mediaUmidadePorEstadoEMes(estado, mes);
          buffer.writeln('Média de umidade por mês em $estado: ${green(mediaMes.toStringAsFixed(2))}%');
        }

        final umidMaxAno = analisador.umidadeMaximaPorEstadoPorAno(estado, ano);
        buffer.writeln('Umidade máxima registrada em $estado: ${red(umidMaxAno.toStringAsFixed(2))}%');

        for (int mes = 1; mes <= 12; mes++) {
          buffer.writeln('Mês: $mes');
          final umidMaxMes = analisador.umidadeMaximaPorEstadoPorMes(estado, mes);
          buffer.writeln('Umidade máxima registrada em $estado: ${red(umidMaxMes.toStringAsFixed(2))}%');
        }

        final umidMinAno = analisador.umidadeMinimaPorEstadoPorAno(estado, ano);
        buffer.writeln('Umidade mínima registrada em $estado: ${blue(umidMinAno.toStringAsFixed(2))}%');

        for (int mes = 1; mes <= 12; mes++) {
          buffer.writeln('Mês: $mes');
          final umidMinMes = analisador.umidadeMinimaPorEstadoPorMes(estado, mes);
          buffer.writeln('Umidade mínima registrada em $estado: ${blue(umidMinMes.toStringAsFixed(2))}%');
        }
      }
    }
    return buffer.toString();
  }

  String gerarRelatorioDirecaoVento() {
    final buffer = StringBuffer();
    final estados = analisador.registros.map((r) => r.estado).toSet();
    final anos = analisador.registros.map((r) => r.ano).toSet();
    buffer.writeln('--- Relatório de Direção do Vento ---');
    for (final ano in anos) {
      buffer.writeln('Ano: $ano');
      for (final estado in estados) {
        final mediaAno = analisador.direcaoVentoMaisFrequentePorEstadoEAno(estado, ano);
        buffer.writeln('Direção do vento mais frequente por ano em $estado: ${yellow(mediaAno.toStringAsFixed(1))}°');

        for (int mes = 1; mes <= 12; mes++) {
          buffer.writeln('Mês: $mes');
          final mediaMes = analisador.direcaoVentoMaisFrequentePorEstadoEMes(estado, mes);
          buffer.writeln('Direção do vento mais frequente por mês em $estado: ${yellow(mediaMes.toStringAsFixed(1))}°');
        }
      }
    }
    return buffer.toString();
  }
}