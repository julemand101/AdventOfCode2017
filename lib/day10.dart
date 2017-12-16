// --- Day 10: Knot Hash ---
// https://adventofcode.com/2017/day/10

class KnotHashResult {
  final int day10aSolution;
  final int currentPosition;
  final int skipSize;

  KnotHashResult(this.day10aSolution, this.currentPosition, this.skipSize);
}

int solveA(List<int> lengths, List<int> circularList) {
  return _knotHashRound(lengths, circularList).day10aSolution;
}

String solveB(String input) {
  var lengths = new List.from(input.codeUnits)..addAll([17, 31, 73, 47, 23]);
  var circularList = new List.generate(256, (x) => x);
  var result = new KnotHashResult(0, 0, 0);

  // run a total of 64 rounds
  for (int i = 0; i < 64; i++) {
    result = _knotHashRound(lengths, circularList,
        currentPosition: result.currentPosition, skipSize: result.skipSize);
  }

  StringBuffer sb = new StringBuffer();
  for (int i = 0; i < 256; i += 16) {
    String hex = circularList
        .getRange(i, i + 16)
        .fold(0, (x, y) => x ^ y)
        .toRadixString(16);

    sb.write(hex.length == 1 ? "0$hex" : hex);
  }

  return sb.toString();
}

KnotHashResult _knotHashRound(List<int> lengths, List<int> circularList,
    {int currentPosition = 0, int skipSize = 0}) {
  for (int length in lengths) {
    _reverse(circularList, currentPosition, currentPosition + length);
    currentPosition =
        (currentPosition + length + skipSize++) % circularList.length;
  }

  return new KnotHashResult(
      circularList[0] * circularList[1], currentPosition, skipSize);
}

void _reverse(List list, int start, int end) {
  var subList = new List();

  for (var i = (start % list.length);
      (i + 1 % list.length) != (end + 1 % list.length);
      i++) {
    subList.add(list[i % list.length]);
  }

  var pos = start;
  for (var element in subList.reversed) {
    list[pos++ % list.length] = element;
  }
}
