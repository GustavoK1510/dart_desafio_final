import 'package:clima/models/registro_climatico.dart';

class AnalisadorClimatico {
  final List<RegistroClimatico> registros;

  AnalisadorClimatico(this.registros);

  List<RegistroClimatico> filtrarPorEstado(String estado) {
    return registros.where((registro) => registro.estado == estado).toList();
  }

  List<RegistroClimatico> filtrarPorMes(int mes) {
    return registros.where((registro) => registro.mes == mes).toList();
  }

  List<RegistroClimatico> filtrarPorEstadoEAno(String estado, int ano) {
    return registros.where((registro) => registro.estado == estado && registro.ano == ano).toList();
  }

  List<RegistroClimatico> filtrarPorEstadoEMes(String estado, int mes) {
    return registros.where((registro) => registro.estado == estado && registro.mes == mes).toList();
  }

  double mediaTemperaturaPorEstadoEMes(String estado, int mes) {
    final List<RegistroClimatico> registrosEstadoMes = filtrarPorEstadoEMes(estado, mes);
    if (registrosEstadoMes.isEmpty) {
      return 0.0;
    }
    final double somaTemperaturas = registrosEstadoMes.fold(0.0, (soma, registro) => soma + registro.temperatura);
    return somaTemperaturas / registrosEstadoMes.length;
  }

  double mediaTemperaturaPorEstadoEAno(String estado, int ano) {
    final List<RegistroClimatico> registrosEstadoAno = filtrarPorEstadoEAno(estado, ano);
    if (registrosEstadoAno.isEmpty) {
      return 0.0;
    }
    final double somaTemperaturas = registrosEstadoAno.fold(0.0, (soma, registro) => soma + registro.temperatura);
    return somaTemperaturas / registrosEstadoAno.length;
  }

  double mediaUmidadePorEstadoEMes(String estado, int mes) {
    final List<RegistroClimatico> registrosEstadoMes = filtrarPorEstadoEMes(estado, mes);
    if (registrosEstadoMes.isEmpty) {
      return 0.0;
    }
    final double somaUmidades = registrosEstadoMes.fold(0.0, (soma, registro) => soma + registro.umidade);
    return somaUmidades / registrosEstadoMes.length;
  }

  double mediaUmidadePorEstadoEAno(String estado, int ano) {
    final List<RegistroClimatico> registrosEstadoAno = filtrarPorEstadoEAno(estado, ano);
    if (registrosEstadoAno.isEmpty) {
      return 0.0;
    }
    final double somaUmidades = registrosEstadoAno.fold(0.0, (soma, registro) => soma + registro.umidade);
    return somaUmidades / registrosEstadoAno.length;
  }

  double temperaturaMaximaPorEstadoPorAno(String estado, int ano) {
    final List<RegistroClimatico> registrosEstadoAno = filtrarPorEstadoEAno(estado, ano);
    if (registrosEstadoAno.isEmpty) {
      return 0.0;
    }
    return registrosEstadoAno.map((registro) => registro.temperatura).reduce((a, b) => a > b ? a : b);
  }

  double temperaturaMaximaPorEstadoPorMes(String estado, int mes) {
    final List<RegistroClimatico> registrosEstadoMes = filtrarPorEstadoEMes(estado, mes);
    if (registrosEstadoMes.isEmpty) {
      return 0.0;
    }
    return registrosEstadoMes.map((registro) => registro.temperatura).reduce((a, b) => a > b ? a : b);
  }

  double temperaturaMinimaPorEstadoPorAno(String estado, int ano) {
    final List<RegistroClimatico> registrosEstadoAno = filtrarPorEstadoEAno(estado, ano);
    if (registrosEstadoAno.isEmpty) {
      return 0.0;
    }
    return registrosEstadoAno.map((registro) => registro.temperatura).reduce((a, b) => a < b ? a : b);
  }

  double temperaturaMinimaPorEstadoPorMes(String estado, int mes) {
    final List<RegistroClimatico> registrosEstadoMes = filtrarPorEstadoEMes(estado, mes);
    if (registrosEstadoMes.isEmpty) {
      return 0.0;
    }
    return registrosEstadoMes.map((registro) => registro.temperatura).reduce((a, b) => a < b ? a : b);
  }

  double umidadeMaximaPorEstadoPorAno(String estado, int ano) {
    final List<RegistroClimatico> registrosEstadoAno = filtrarPorEstadoEAno(estado, ano);
    if (registrosEstadoAno.isEmpty) {
      return 0.0;
    }
    return registrosEstadoAno.map((registro) => registro.umidade).reduce((a, b) => a > b ? a : b);
  }

    double umidadeMaximaPorEstadoPorMes(String estado, int mes) {
      final List<RegistroClimatico> registrosEstadoMes = filtrarPorEstadoEMes(estado, mes);
      if (registrosEstadoMes.isEmpty) {
        return 0.0;
      }
      return registrosEstadoMes.map((registro) => registro.umidade).reduce((a, b) => a > b ? a : b);
    }

  double umidadeMinimaPorEstadoPorAno(String estado, int ano) {
    final List<RegistroClimatico> registrosEstadoAno = filtrarPorEstadoEAno(estado, ano);
    if (registrosEstadoAno.isEmpty) {
      return 0.0;
    }
    return registrosEstadoAno.map((registro) => registro.umidade).reduce((a, b) => a < b ? a : b);
  }

  double umidadeMinimaPorEstadoPorMes(String estado, int mes) {
    final List<RegistroClimatico> registrosEstadoMes = filtrarPorEstadoEMes(estado, mes);
    if (registrosEstadoMes.isEmpty) {
      return 0.0;
    }
    return registrosEstadoMes.map((registro) => registro.umidade).reduce((a, b) => a < b ? a : b);
  }

  Map<String, double> mediaTemperaturaPorHorarioPorEstado(String estado) {
    final registrosEstado = filtrarPorEstado(estado);
    final Map<String, List<double>> temperaturasPorHorario = {};
    for (final registro in registrosEstado) {
      temperaturasPorHorario.putIfAbsent(registro.hora, () => []).add(registro.temperatura);
    }

    Map<String, double> medias = {};
    temperaturasPorHorario.forEach((hora, temperaturas) {
      final double somaTemperaturas = temperaturas.fold(0.0, (soma, temp) => soma + temp);
      medias[hora] = somaTemperaturas / temperaturas.length;
    });
    return medias;
  }

  double direcaoVentoMaisFrequentePorEstado(String estado) {
    final List<RegistroClimatico> registrosEstado = filtrarPorEstado(estado);
    if (registrosEstado.isEmpty) {
      return 0.0;
    }
    final Map<double, int> frequenciaDirecaoVento = {};
    for (final registro in registrosEstado) {
      frequenciaDirecaoVento.update(registro.direcaoVento, (count) => count + 1, ifAbsent: () => 1);
    }
    return frequenciaDirecaoVento.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  double direcaoVentoMaisFrequentePorEstadoEMes(String estado, int mes) {
    final List<RegistroClimatico> registrosEstadoMes = filtrarPorEstadoEMes(estado, mes);
    if (registrosEstadoMes.isEmpty) {
      return 0.0;
    }
    final Map<double, int> frequenciaDirecaoVento = {};
    for (final registro in registrosEstadoMes) {
      frequenciaDirecaoVento.update(registro.direcaoVento, (count) => count + 1, ifAbsent: () => 1);
    }
    return frequenciaDirecaoVento.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  double direcaoVentoMaisFrequentePorEstadoEAno(String estado, int ano) {
    final List<RegistroClimatico> registrosEstadoAno = filtrarPorEstadoEAno(estado, ano);
    if (registrosEstadoAno.isEmpty) {
      return 0.0;
    }
    final Map<double, int> frequenciaDirecaoVento = {};
    for (final registro in registrosEstadoAno) {
      frequenciaDirecaoVento.update(registro.direcaoVento, (count) => count + 1, ifAbsent: () => 1);
    }
    return frequenciaDirecaoVento.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }
}