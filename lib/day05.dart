// --- Day 5: A Maze of Twisty Trampolines, All Alike ---
// https://adventofcode.com/2017/day/5

typedef NextPositionCalculator = int Function(
    List<int> instructions, int position);

int solveA(List<int> input) {
  return _solve(
      input, (List<int> instructions, int pos) => pos + (instructions[pos]++));
}

int solveB(List<int> input) {
  return _solve(
      input,
      (List<int> instructions, int pos) =>
          pos +
          ((instructions[pos] < 3)
              ? instructions[pos]++
              : instructions[pos]--));
}

int _solve(List<int> instructions, NextPositionCalculator nextPosition) {
  int count = 0;

  for (int pos = 0; pos >= 0 && pos < instructions.length; count++) {
    pos = nextPosition(instructions, pos);
  }

  return count;
}
