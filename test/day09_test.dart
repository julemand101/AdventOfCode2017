// --- Day 9: Stream Processing ---
// https://adventofcode.com/2017/day/9

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day09.dart';

const String DATA_FILE_PATH = "test/data/day09.txt";

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA("{}"), equals(1));
    });
    test('Example 2', () {
      expect(solveA("{{{}}}"), equals(6));
    });
    test('Example 3', () {
      expect(solveA("{{},{}}"), equals(5));
    });
    test('Example 4', () {
      expect(solveA("{{{},{},{{}}}}"), equals(16));
    });
    test('Example 5', () {
      expect(solveA("{<a>,<a>,<a>,<a>}"), equals(1));
    });
    test('Example 6', () {
      expect(solveA("{{<ab>},{<ab>},{<ab>},{<ab>}}"), equals(9));
    });
    test('Example 7', () {
      expect(solveA("{{<!!>},{<!!>},{<!!>},{<!!>}}"), equals(9));
    });
    test('Example 8', () {
      expect(solveA("{{<a!>},{<a!>},{<a!>},{<ab>}}"), equals(3));
    });
    test('Solution', () {
      File f = new File(DATA_FILE_PATH);
      expect(
          solveA(
              f.readAsLinesSync().firstWhere((line) => line.trim().isNotEmpty)),
          equals(14212));
    });
  });

//  group("Part Two", () {
//    test('Example 1', () {
//      expect(solveB(EXAMPLE), equals(10));
//    });
//    test('Solution', () {
//      File f = new File(DATA_FILE_PATH);
//      expect(
//          solveB(f
//              .readAsLinesSync()
//              .where((line) => line.trim().isNotEmpty)
//              .toList(growable: false)),
//          equals(6209));
//    });
//  });
}
