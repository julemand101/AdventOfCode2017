// --- Day 10: Knot Hash ---
// https://adventofcode.com/2017/day/10

int solveA(List<int> lengths, List<int> circularList) {
  int currentPosition = 0;
  int skipSize = 0;

  for (int length in lengths) {
    _reverse(circularList, currentPosition, currentPosition + length);
    currentPosition =
        (currentPosition + length + skipSize++) % circularList.length;
  }

  return circularList[0] * circularList[1];
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
