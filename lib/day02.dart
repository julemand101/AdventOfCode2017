// --- Day 2: Corruption Checksum ---
// http://adventofcode.com/2017/day/2

import 'dart:math' as math;

final Pattern TAB_OR_NEWLINE_REGEX = new RegExp('[ \t]');

typedef int ChecksumCalculator(List<int> input);

int solveA(String input) {
  return _solve(input, _getChecksumA);
}

int solveB(String input) {
  return _solve(input, _getChecksumB);
}

int _solve(String input, ChecksumCalculator calculateChecksum) {
  int checksum = 0;

  for (String row in input.split('\n').where((x) => x.trim().isNotEmpty)) {
    var list =
        row.split(TAB_OR_NEWLINE_REGEX).map(int.parse).toList(growable: false);
    checksum += calculateChecksum(list);
  }

  return checksum;
}

int _getChecksumA(List<int> list) {
  return list.reduce(math.max) - list.reduce(math.min);
}

int _getChecksumB(List<int> list) {
  list.sort();
  for (int i = (list.length - 1); i > 0; i--) {
    for (int k = (i - 1); k >= 0; k--) {
      if (list[i] % list[k] == 0) {
        return list[i] ~/ list[k];
      }
    }
  }
}
