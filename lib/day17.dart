// --- Day 17: Spinlock ---
// https://adventofcode.com/2017/day/17

int solveA(int stepsForward) {
  final buffer = <int>[];
  var currentPosition = 0;
  buffer.add(0);

  for (int i = 1; i <= 2017; i++) {
    currentPosition = (currentPosition + stepsForward) % buffer.length + 1;
    buffer.insert(currentPosition, i);
  }

  return buffer[(currentPosition + 1) % buffer.length];
}

int solveB(int stepsForward) {
  int valueAfterZero = 0;
  int currentPosition = 0;
  int bufferLength = 1;

  for (int i = 1; i <= 50000000; i++) {
    currentPosition = (currentPosition + stepsForward) % bufferLength++ + 1;

    if (currentPosition == 1) {
      valueAfterZero = i;
    }
  }

  return valueAfterZero;
}
