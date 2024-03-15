import 'dart:io';
import 'dart:math';

void main() {
  var resultado = '';
  var numeroAleatorio;
  var tentativasRestantes;

  final random = Random();

  if (File('numero_aleatorio.txt').existsSync()) {
    numeroAleatorio = int.parse(File('numero_aleatorio.txt').readAsStringSync());
    tentativasRestantes = int.parse(File('tentativas_restantes.txt').readAsStringSync());
  } else {
    numeroAleatorio = random.nextInt(100) + 1;
    tentativasRestantes = 6;
    File('numero_aleatorio.txt').writeAsStringSync(numeroAleatorio.toString());
    File('tentativas_restantes.txt').writeAsStringSync(tentativasRestantes.toString());
  }

  print('Eu pensei em um número entre 1 e 100. Você consegue adivinhar qual é?');

  while (tentativasRestantes > 0) {
    stdout.write('Seu Palpite: ');
    final palpite = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    if (palpite == numeroAleatorio) {
      resultado = 'Parabéns! Você acertou o número. O número era $numeroAleatorio.';
      File('numero_aleatorio.txt').deleteSync();
      File('tentativas_restantes.txt').deleteSync();
      break;
    } else {
      tentativasRestantes--;

      if (tentativasRestantes <= 0) {
        resultado = 'Você excedeu o número máximo de tentativas. O número era $numeroAleatorio.';
        File('numero_aleatorio.txt').deleteSync();
        File('tentativas_restantes.txt').deleteSync();
        break;
      } else if (palpite < numeroAleatorio) {
        resultado = 'Seu palpite está muito baixo. Tente novamente. Tentativas restantes: $tentativasRestantes.';
      } else if (palpite > numeroAleatorio) {
        resultado = 'Seu palpite está muito alto. Tente novamente. Tentativas restantes: $tentativasRestantes.';
      }
    }

    print(resultado);
  }
}
