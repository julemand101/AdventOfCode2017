// --- Day 15: Dueling Generators ---
// https://adventofcode.com/2017/day/15

const int FACTOR_A = 16807;
const int FACTOR_B = 48271;
const int REMINDER = 2147483647;

int solveA(int startA, int startB) {
  int a = startA;
  int b = startB;
  int result = 0;

  for (int i = 0; i < 40000000; i++) {
    a = _next(a, FACTOR_A);
    b = _next(b, FACTOR_B);
    String ab = a.toRadixString(2).padLeft(32, "0").substring(16);
    String bb = b.toRadixString(2).padLeft(32, "0").substring(16);

    if (ab == bb) {
      result++;
    }
  }

  return result;
}

int _next(int input, int factor) {
  return (input * factor) % REMINDER;
}
