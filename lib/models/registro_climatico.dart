class RegistroClimatico {
  final String estado;

  final int ano;
  final int mes;
  final String hora;

  final double temperatura;
  final double umidade;
  final double velocidadeVento;
  final double direcaoVento;

  RegistroClimatico({
    required this.estado,
    required this.ano,
    required this.mes,
    required this.hora,
    required this.temperatura,
    required this.umidade,
    required this.velocidadeVento,
    required this.direcaoVento,
  });

}