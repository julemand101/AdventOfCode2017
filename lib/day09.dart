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

  String garbageFreeInput = _removeGarbage(input).result;

  for (int i = 0; i < garbageFreeInput.length; i++) {
    String char = garbageFreeInput[i];

    if (char == "{") {
      pointLevel++;
    } else if (char == "}") {
      points += pointLevel--;
    } else {
      throw "Unknown char: $char";
    }
  }

  return points;
}

int solveB(String input) {
  return _removeGarbage(input).nonCanceledCharactersInGarbage;
}

GarbageResult _removeGarbage(String input) {
  StringBuffer buffer = new StringBuffer();
  int count = 0;
  int pos = 0;

  while (pos < input.length) {
    String char = input[pos];

    if (char == "<") {
      while (input[pos] != ">") {
        if (input[pos] == "!") {
          pos += 2;
        } else {
          count++;
          pos++;
        }
      }
      count--;
      pos++;
    } else if (char == ",") {
      pos++;
    } else {
      buffer.write(input[pos++]);
    }
  }

  return new GarbageResult(buffer.toString(), count);
}
