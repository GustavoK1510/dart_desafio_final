import 'dart:math';

double converterCelsiusParaFahrenheit(double celsius) {
  return (celsius * 9 / 5) + 32;
}

double converterCelsiusParaKelvin(double celsius) {
  return celsius + 273.15;
}

double converterGrausParaRadianos(double graus) {
  return graus * pi / 180;
}