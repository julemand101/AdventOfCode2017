// --- Day 21: Fractal Art ---
// https://adventofcode.com/2017/day/21

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2017/day21.dart';

const String dataFilePath = 'test/data/day21.txt';

final List<String> example = [
  '../.# => ##./#../...',
  '.#./..#/### => #..#/..../..../#..#'
];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solve(example, 2), equals(12));
    });
    test('Solution', () {
      expect(
          solve(
              File(dataFilePath)
                  .readAsLinesSync()
                  .where((line) => line.trim().isNotEmpty)
                  .toList(growable: false),
              5),
          equals(150));
    });
  });

  group('Part Two', () {
    test('Solution', () {
      expect(
          solve(
              File(dataFilePath)
                  .readAsLinesSync()
                  .where((line) => line.trim().isNotEmpty)
                  .toList(growable: false),
              18),
          equals(2606275));
    });
  });
}
