// --- Day 2: Corruption Checksum ---
// https://adventofcode.com/2017/day/2

import 'dart:math' as math;

final Pattern tabOrNewlineRegExp = RegExp('[ \t]');

typedef ChecksumCalculator = int Function(List<int> input);

int solveA(String input) {
  return _solve(input, _getChecksumA);
}

int solveB(String input) {
  return _solve(input, _getChecksumB);
}

int _solve(String input, ChecksumCalculator calculateChecksum) {
  var checksum = 0;

  for (final row in input.split('\n').where((x) => x.trim().isNotEmpty)) {
    final list =
        row.split(tabOrNewlineRegExp).map(int.parse).toList(growable: false);
    checksum += calculateChecksum(list);
  }

  return checksum;
}

int _getChecksumA(List<int> list) {
  return list.reduce(math.max) - list.reduce(math.min);
}

int _getChecksumB(List<int> list) {
  list.sort();
  for (var i = list.length - 1; i > 0; i--) {
    for (var k = i - 1; k >= 0; k--) {
      if (list[i] % list[k] == 0) {
        return list[i] ~/ list[k];
      }
    }
  }
  throw Exception('Bad input: $list');
}
