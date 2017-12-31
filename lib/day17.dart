// --- Day 17: Spinlock ---
// https://adventofcode.com/2017/day/17

int solveA(int stepsForward) {
  List<int> buffer = new List();
  int current_position = 0;
  buffer.add(0);

  for (int i = 1; i <= 2017; i++) {
    current_position = (current_position + stepsForward) % buffer.length + 1;
    buffer.insert(current_position, i);
  }

  return buffer[(current_position + 1) % buffer.length];
}

int solveB(int stepsForward) {
  int valueAfterZero = 0;
  int current_position = 0;
  int buffer_length = 1;

  for (int i = 1; i <= 50000000; i++) {
    current_position = (current_position + stepsForward) % buffer_length++ + 1;

    if (current_position == 1) {
      valueAfterZero = i;
    }
  }

  return valueAfterZero;
}
