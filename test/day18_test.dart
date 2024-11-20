// --- Day 18: Duet ---
// https://adventofcode.com/2017/day/18

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2017/day18.dart';

const String dataFilePath = 'test/data/day18.txt';

final List<String> exampleA = [
  'set a 1',
  'add a 2',
  'mul a a',
  'mod a 5',
  'snd a',
  'set a 0',
  'rcv a',
  'jgz a -1',
  'set a 1',
  'jgz a -2'
];

final List<String> exampleB = [
  'snd 1',
  'snd 2',
  'snd p',
  'rcv a',
  'rcv b',
  'rcv c',
  'rcv d'
];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(exampleA), equals(4));
    });
    test('Solution', () {
      expect(
          solveA(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(4601));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(exampleB), equals(3));
    });
    test('Solution', () {
      expect(
          solveB(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(6858));
    });
  });
}
