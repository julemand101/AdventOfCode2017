// --- Day 15: Dueling Generators ---
// https://adventofcode.com/2017/day/15

const int FACTOR_A = 16807;
const int FACTOR_B = 48271;
const int REMINDER = 2147483647;

typedef NextNumberCalculator = int Function(
    int input, int factor, int multiplesOf);

int solveA(int startA, int startB) {
  return _solve(startA, startB, 40000000, _nextA);
}

int solveB(int startA, int startB) {
  return _solve(startA, startB, 5000000, _nextB, 4, 8);
}

int _solve(int startA, int startB, int loopCount, NextNumberCalculator next,
    [int multiplesOfA = 1, int multiplesOfB = 1]) {
  int a = startA;
  int b = startB;
  int result = 0;

  for (int i = 0; i < loopCount; i++) {
    a = next(a, FACTOR_A, multiplesOfA);
    b = next(b, FACTOR_B, multiplesOfB);

    if ((a & 0xFFFF) == (b & 0xFFFF)) {
      result++;
    }
  }

  return result;
}

int _nextA(int input, int factor, int multiplesOf) {
  return (input * factor) % REMINDER;
}

int _nextB(int input, int factor, int multiplesOf) {
  int result = input;

  do {
    result = _nextA(result, factor, multiplesOf);
  } while (result % multiplesOf != 0);

  return result;
}
