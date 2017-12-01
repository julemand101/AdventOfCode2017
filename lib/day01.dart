// --- Day 1: Inverse Captcha ---
// http://adventofcode.com/2017/day/1

int solveA(String input) {
  int sum = 0;

  for (int i = 0; i < input.length; i++) {
    if (input[i] == input[(i + 1) % input.length]) {
      sum += int.parse(input[i]);
    }
  }

  return sum;
}

int solveB(String input) {
  int sum = 0;

  for (int i = 0; i < input.length; i++) {
    if (input[i] == input[(i + (input.length ~/ 2)) % input.length]) {
      sum += int.parse(input[i]);
    }
  }

  return sum;
}
