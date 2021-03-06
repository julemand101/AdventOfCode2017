// --- Day 13: Packet Scanners ---
// https://adventofcode.com/2017/day/13

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day13.dart';

const String DATA_FILE_PATH = 'test/data/day13.txt';

final List<String> EXAMPLE = ['0: 3', '1: 2', '4: 4', '6: 4'];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(EXAMPLE), equals(24));
    });
    test('Solution', () {
      expect(
          solveA(File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)),
          equals(2160));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(EXAMPLE), equals(10));
    });
    test('Solution', () {
      expect(
          solveB(File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)),
          equals(3907470));
    });
  });

  group('Part Two - with isolates', () {
    const chunksize = 1000;

    test('Example 1', () {
      expect(solveB_with_isolates(EXAMPLE, chunksize), completion(equals(10)));
    });
    test('Solution', () {
      expect(
          solveB_with_isolates(
              File(DATA_FILE_PATH)
                  .readAsLinesSync()
                  .where((line) => line.trim().isNotEmpty),
              chunksize),
          completion(equals(3907470)));
    });
  });
}
