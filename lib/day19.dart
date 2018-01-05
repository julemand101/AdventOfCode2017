// --- Day 19: A Series of Tubes ---
// https://adventofcode.com/2017/day/19

import 'dart:typed_data';

final int PLUS_RUNE = "+".runes.first;
final int EMPTY_RUNE = " ".runes.first;
final int VERTICAL_LINE_RUNE = "|".runes.first;
final int HORIZONTAL_LINE_RUNE = "-".runes.first;

enum Direction { UP, DOWN, LEFT, RIGHT }

class Day19Result {
  final int steps;
  final String visitedLetters;

  Day19Result(this.steps, this.visitedLetters);
}

String solveA(List<String> input) {
  return solve(input).visitedLetters;
}

int solveB(List<String> input) {
  return solve(input).steps;
}

Day19Result solve(List<String> input) {
  List<Uint8List> network = new List();
  int steps = 0;
  StringBuffer visitedLetters = new StringBuffer();

  for (String line in input) {
    network.add(new Uint8List.fromList(line.runes.toList()));
  }

  // Find start position
  int y = 0;
  int x = network[y].indexOf(VERTICAL_LINE_RUNE);
  Direction direction = Direction.DOWN;

  while (true) {
    int current_char = network[y][x];

    if (current_char == VERTICAL_LINE_RUNE ||
        current_char == HORIZONTAL_LINE_RUNE) {
      // Just continue in the same direction
    } else if (current_char == PLUS_RUNE) {
      if (direction != Direction.UP &&
          y + 1 < network.length &&
          network[y + 1][x] != EMPTY_RUNE) {
        direction = Direction.DOWN;
      } else if (direction != Direction.DOWN &&
          y - 1 > 0 &&
          network[y - 1][x] != EMPTY_RUNE) {
        direction = Direction.UP;
      } else if (direction != Direction.RIGHT &&
          x - 1 > 0 &&
          network[y][x - 1] != EMPTY_RUNE) {
        direction = Direction.LEFT;
      } else if (direction != Direction.LEFT &&
          x + 1 < network[y].length &&
          network[y][x + 1] != EMPTY_RUNE) {
        direction = Direction.RIGHT;
      }
    } else if (current_char == EMPTY_RUNE) {
      break;
    } else {
      // Should be a letter so write it down and continue in the same direction
      visitedLetters.writeCharCode(current_char);
    }

    switch (direction) {
      case Direction.UP:
        y--;
        break;
      case Direction.DOWN:
        y++;
        break;
      case Direction.LEFT:
        x--;
        break;
      case Direction.RIGHT:
        x++;
        break;
    }

    steps++;
  }

  return new Day19Result(steps, visitedLetters.toString());
}
