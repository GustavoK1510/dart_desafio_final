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

  double MediaTemperaturaPorEstado(String estado) {
    final List<RegistroClimatico> registrosEstado = filtrarPorEstado(estado);
    if (registrosEstado.isEmpty) {
      return 0.0;
    }
    final double somaTemperaturas = registrosEstado.fold(0.0, (soma, registro) => soma + registro.temperatura);
    return somaTemperaturas / registrosEstado.length;
  }

  double MediaTemperaturaPorEstadoEMes(String estado, int mes) {
    final List<RegistroClimatico> registrosEstadoMes = filtrarPorEstadoEMes(estado, mes);
    if (registrosEstadoMes.isEmpty) {
      return 0.0;
    }
    final double somaTemperaturas = registrosEstadoMes.fold(0.0, (soma, registro) => soma + registro.temperatura);
    return somaTemperaturas / registrosEstadoMes.length;
  }

  double MediaUmidadePorEstado(String estado) {
    final List<RegistroClimatico> registrosEstado = filtrarPorEstado(estado);
    if (registrosEstado.isEmpty) {
      return 0.0;
    }
    final double somaUmidades = registrosEstado.fold(0.0, (soma, registro) => soma + registro.umidade);
    return somaUmidades / registrosEstado.length;
  }

  double MediaUmidadePorEstadoEMes(String estado, int mes) {
    final List<RegistroClimatico> registrosEstadoMes = filtrarPorEstadoEMes(estado, mes);
    if (registrosEstadoMes.isEmpty) {
      return 0.0;
    }
    final double somaUmidades = registrosEstadoMes.fold(0.0, (soma, registro) => soma + registro.umidade);
    return somaUmidades / registrosEstadoMes.length;
  }

  double TemperaturaMaximaPorEstado(String estado) {
    final List<RegistroClimatico> registrosEstado = filtrarPorEstado(estado);
    if (registrosEstado.isEmpty) {
      return 0.0;
    }
    return registrosEstado.map((registro) => registro.temperatura).reduce((a, b) => a > b ? a : b);
  }

  double TemperaturaMinimaPorEstado(String estado) {
    final List<RegistroClimatico> registrosEstado = filtrarPorEstado(estado);
    if (registrosEstado.isEmpty) {
      return 0.0;
    }
    return registrosEstado.map((registro) => registro.temperatura).reduce((a, b) => a < b ? a : b);
  }

  double UmidadeMaximaPorEstado(String estado) {
    final List<RegistroClimatico> registrosEstado = filtrarPorEstado(estado);
    if (registrosEstado.isEmpty) {
      return 0.0;
    }
    return registrosEstado.map((registro) => registro.umidade).reduce((a, b) => a > b ? a : b);
  }

  double UmidadeMinimaPorEstado(String estado) {
    final List<RegistroClimatico> registrosEstado = filtrarPorEstado(estado);
    if (registrosEstado.isEmpty) {
      return 0.0;
    }
    return registrosEstado.map((registro) => registro.umidade).reduce((a, b) => a < b ? a : b);
  }

  

}