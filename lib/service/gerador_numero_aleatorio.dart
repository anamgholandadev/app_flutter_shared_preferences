import 'dart:math';

class GeradorNumeroAleatorioService {
  static int gerarNumeroAleatorio(int numeroMax) {
    Random numeroAleatorio = Random();
    return numeroAleatorio.nextInt(numeroMax);
  }
}
