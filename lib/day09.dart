// --- Day 9: Stream Processing ---
// https://adventofcode.com/2017/day/9

class GarbageResult {
  final String result;
  final int nonCanceledCharactersInGarbage;

  GarbageResult(this.result, this.nonCanceledCharactersInGarbage);
}

int solveA(String input) {
  int pointLevel = 0;
  int points = 0;

  final garbageFreeInput = _removeGarbage(input).result;

  for (var i = 0; i < garbageFreeInput.length; i++) {
    final char = garbageFreeInput[i];

    if (char == '{') {
      pointLevel++;
    } else if (char == '}') {
      points += pointLevel--;
    } else {
      throw Exception('Unknown char: $char');
    }
  }

  return points;
}

int solveB(String input) {
  return _removeGarbage(input).nonCanceledCharactersInGarbage;
}

GarbageResult _removeGarbage(String input) {
  final buffer = StringBuffer();
  int count = 0;
  int pos = 0;

  while (pos < input.length) {
    final char = input[pos];

    if (char == '<') {
      while (input[pos] != '>') {
        if (input[pos] == '!') {
          pos += 2;
        } else {
          count++;
          pos++;
        }
      }
      count--;
      pos++;
    } else if (char == ',') {
      pos++;
    } else {
      buffer.write(input[pos++]);
    }
  }

  return GarbageResult(buffer.toString(), count);
}
