// --- Day 13: Packet Scanners ---
// https://adventofcode.com/2017/day/13

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2017/day13.dart';

const String dataFilePath = 'test/data/day13.txt';

final List<String> example = ['0: 3', '1: 2', '4: 4', '6: 4'];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(example), equals(24));
    });
    test('Solution', () {
      expect(
          solveA(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)),
          equals(2160));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(example), equals(10));
    });
    test('Solution', () {
      expect(
          solveB(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)),
          equals(3907470));
    });
  });

  group('Part Two - with isolates', () {
    const chunksize = 1000;

    test('Example 1', () {
      expect(solveBWithIsolates(example, chunksize), completion(equals(10)));
    });
    test('Solution', () {
      expect(
          solveBWithIsolates(
              File(dataFilePath)
                  .readAsLinesSync()
                  .where((line) => line.trim().isNotEmpty),
              chunksize),
          completion(equals(3907470)));
    });
  });
}
