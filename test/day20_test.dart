// --- Day 20: Particle Swarm ---
// https://adventofcode.com/2017/day/20

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2017/day20.dart';

const String dataFilePath = 'test/data/day20.txt';

final List<String> examplePartOne = [
  'p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>',
  'p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>'
];

final List<String> examplePartTwo = [
  'p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>',
  'p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>',
  'p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>',
  'p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>'
];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(examplePartOne), equals(0));
    });
    test('Solution', () {
      expect(
          solveA(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(170));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(examplePartTwo), equals(1));
    });
    test('Solution', () {
      expect(
          solveB(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(571));
    });
  });
}
