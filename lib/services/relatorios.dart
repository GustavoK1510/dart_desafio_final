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

    buffer.writeln('========================================');
    buffer.writeln('     RELATÓRIO DE TEMPERATURA');
    buffer.writeln('========================================\n');

    for (final ano in anos) {
      buffer.writeln('ANO: $ano');
      buffer.writeln('========================================');

      for (final estado in estados) {
        buffer.writeln('\nESTADO: $estado');
        buffer.writeln('----------------------------------------');

        final mediaAno = analisador.mediaTemperaturaPorEstadoEAno(estado, ano);

        buffer.writeln('\nMÉDIA ANUAL');
        buffer.writeln('  Celsius: ${red(mediaAno.toStringAsFixed(1))}°C');
        buffer.writeln('  Fahrenheit: ${yellow(converterCelsiusParaFahrenheit(mediaAno).toStringAsFixed(1))}°F');
        buffer.writeln('  Kelvin: ${blue(converterCelsiusParaKelvin(mediaAno).toStringAsFixed(1))}K');

        final tempMaxAno = analisador.temperaturaMaximaPorEstadoPorAno(estado, ano);

        buffer.writeln('\nMÁXIMA ANUAL');
        buffer.writeln('  Celsius: ${red(tempMaxAno.toStringAsFixed(1))}°C');
        buffer.writeln('  Fahrenheit: ${yellow(converterCelsiusParaFahrenheit(tempMaxAno).toStringAsFixed(1))}°F');
        buffer.writeln('  Kelvin: ${blue(converterCelsiusParaKelvin(tempMaxAno).toStringAsFixed(1))}K');

        final tempMinAno = analisador.temperaturaMinimaPorEstadoPorAno(estado, ano);

        buffer.writeln('\nMÍNIMA ANUAL');
        buffer.writeln('  Celsius: ${red(tempMinAno.toStringAsFixed(1))}°C');
        buffer.writeln('  Fahrenheit: ${yellow(converterCelsiusParaFahrenheit(tempMinAno).toStringAsFixed(1))}°F');
        buffer.writeln('  Kelvin: ${blue(converterCelsiusParaKelvin(tempMinAno).toStringAsFixed(1))}K');

        buffer.writeln('\nMÉDIAS MENSAIS');
        buffer.writeln('----------------------------------------');

        for (int mes = 1; mes <= 12; mes++) {
          final mediaMes = analisador.mediaTemperaturaPorEstadoEMes(estado, mes);

          buffer.writeln('${nomeMes(mes)}');
          buffer.writeln('  Celsius: ${red(mediaMes.toStringAsFixed(1))}°C');
          buffer.writeln('  Fahrenheit: ${yellow(converterCelsiusParaFahrenheit(mediaMes).toStringAsFixed(1))}°F');
          buffer.writeln('  Kelvin: ${blue(converterCelsiusParaKelvin(mediaMes).toStringAsFixed(1))}K\n');
        }

        buffer.writeln('\nMÉDIA POR HORÁRIO');
        buffer.writeln('----------------------------------------');

        final mediasHorario = analisador.mediaTemperaturaPorHorarioPorEstado(estado);

        for (final entry in mediasHorario.entries) {
          buffer.writeln('${entry.key}h');
          buffer.writeln('  Celsius: ${red(entry.value.toStringAsFixed(1))}°C');
          buffer.writeln('  Fahrenheit: ${yellow(converterCelsiusParaFahrenheit(entry.value).toStringAsFixed(1))}°F');
          buffer.writeln('  Kelvin: ${blue(converterCelsiusParaKelvin(entry.value).toStringAsFixed(1))}K\n');
        }

        buffer.writeln('\n');
      }
    }

    return buffer.toString();
  }

  String gerarRelatorioUmidade() {
    final buffer = StringBuffer();

    final estados = analisador.registros.map((r) => r.estado).toSet();
    final anos = analisador.registros.map((r) => r.ano).toSet();

    buffer.writeln('========================================');
    buffer.writeln('       RELATÓRIO DE UMIDADE');
    buffer.writeln('========================================\n');

    for (final ano in anos) {
      buffer.writeln('ANO: $ano');
      buffer.writeln('========================================');

      for (final estado in estados) {
        buffer.writeln('\nESTADO: $estado');
        buffer.writeln('----------------------------------------');

        final mediaAno = analisador.mediaUmidadePorEstadoEAno(estado, ano);

        buffer.writeln('\nMÉDIA ANUAL');
        buffer.writeln('Umidade: ${green(mediaAno.toStringAsFixed(2))}%');

        final maxAno = analisador.umidadeMaximaPorEstadoPorAno(estado, ano);

        buffer.writeln('\nMÁXIMA ANUAL');
        buffer.writeln('Umidade: ${red(maxAno.toStringAsFixed(2))}%');

        final minAno = analisador.umidadeMinimaPorEstadoPorAno(estado, ano);

        buffer.writeln('\nMÍNIMA ANUAL');
        buffer.writeln('Umidade: ${blue(minAno.toStringAsFixed(2))}%');

        buffer.writeln('\nMÉDIAS MENSAIS');
        buffer.writeln('----------------------------------------');

        for (int mes = 1; mes <= 12; mes++) {
          final mediaMes = analisador.mediaUmidadePorEstadoEMes(estado, mes);

          buffer.writeln('${nomeMes(mes)} -> ${green(mediaMes.toStringAsFixed(2))}%',
          );
        }
      }
    }
    return buffer.toString();
  }

  String gerarRelatorioDirecaoVento() {
    final buffer = StringBuffer();

    final estados = analisador.registros.map((r) => r.estado).toSet();
    final anos = analisador.registros.map((r) => r.ano).toSet();

    buffer.writeln('========================================');
    buffer.writeln('    RELATÓRIO DE DIREÇÃO DO VENTO');
    buffer.writeln('========================================\n');

    for (final ano in anos) {
      buffer.writeln('ANO: $ano');
      buffer.writeln('========================================');

      for (final estado in estados) {
        buffer.writeln('\nESTADO: $estado');
        buffer.writeln('----------------------------------------');

        final direcaoAno = analisador.direcaoVentoMaisFrequentePorEstadoEAno(estado, ano);

        buffer.writeln('\nDIREÇÃO MAIS FREQUENTE NO ANO');
        buffer.writeln('Graus: ${yellow(direcaoAno.toStringAsFixed(1))}°');
        buffer.writeln('Radianos: ${yellow(converterGrausParaRadianos(direcaoAno).toStringAsFixed(4))} rad');

        buffer.writeln('\nDIREÇÕES MAIS FREQUENTES POR MÊS');
        buffer.writeln('----------------------------------------');

        for (int mes = 1; mes <= 12; mes++) {
          final direcaoMes = analisador.direcaoVentoMaisFrequentePorEstadoEMes(estado, mes);

          buffer.writeln('${nomeMes(mes)} -> ${yellow(direcaoMes.toStringAsFixed(1))}° | ${yellow(converterGrausParaRadianos(direcaoMes).toStringAsFixed(4))} rad');
        }
        
        buffer.writeln();
      }
    }

    return buffer.toString();
  }

  String nomeMes(int mes) {
    const meses = {
      1: 'Janeiro',
      2: 'Fevereiro',
      3: 'Março',
      4: 'Abril',
      5: 'Maio',
      6: 'Junho',
      7: 'Julho',
      8: 'Agosto',
      9: 'Setembro',
      10: 'Outubro',
      11: 'Novembro',
      12: 'Dezembro'
    };

    return meses[mes] ?? 'Mês desconhecido';
  }
}