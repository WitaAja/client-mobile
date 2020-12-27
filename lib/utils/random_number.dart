import 'dart:math';

class RandomNumber {
  static get getRandomNumber {
    try {
      Random random;
      random = new Random();
      final int min = 0;
      final int max = 5;
      final int rnd = min + random.nextInt(max - min);
      return rnd;
    } catch (_) {
      return 0;
    }
  }
}