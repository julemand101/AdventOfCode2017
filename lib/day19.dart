// --- Day 19: A Series of Tubes ---
// https://adventofcode.com/2017/day/19

import 'dart:typed_data';

final int plusRune = "+".runes.first;
final int emptyRune = " ".runes.first;
final int verticalLineRune = "|".runes.first;
final int horizontalLineRune = "-".runes.first;

enum Direction { up, down, left, right }

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
  final network = <Uint8List>[];
  int steps = 0;
  final visitedLetters = StringBuffer();

  for (final line in input) {
    network.add(Uint8List.fromList(line.runes.toList()));
  }

  // Find start position
  int y = 0;
  int x = network[y].indexOf(verticalLineRune);
  Direction direction = Direction.down;

  // ignore: literal_only_boolean_expressions
  while (true) {
    final currentChar = network[y][x];

    if (currentChar == verticalLineRune || currentChar == horizontalLineRune) {
      // Just continue in the same direction
    } else if (currentChar == plusRune) {
      if (direction != Direction.up &&
          y + 1 < network.length &&
          network[y + 1][x] != emptyRune) {
        direction = Direction.down;
      } else if (direction != Direction.down &&
          y - 1 > 0 &&
          network[y - 1][x] != emptyRune) {
        direction = Direction.up;
      } else if (direction != Direction.right &&
          x - 1 > 0 &&
          network[y][x - 1] != emptyRune) {
        direction = Direction.left;
      } else if (direction != Direction.left &&
          x + 1 < network[y].length &&
          network[y][x + 1] != emptyRune) {
        direction = Direction.right;
      }
    } else if (currentChar == emptyRune) {
      break;
    } else {
      // Should be a letter so write it down and continue in the same direction
      visitedLetters.writeCharCode(currentChar);
    }

    switch (direction) {
      case Direction.up:
        y--;
        break;
      case Direction.down:
        y++;
        break;
      case Direction.left:
        x--;
        break;
      case Direction.right:
        x++;
        break;
    }

    steps++;
  }

  return Day19Result(steps, visitedLetters.toString());
}
