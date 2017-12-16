// --- Day 11: Hex Ed ---
// https://adventofcode.com/2017/day/11

import 'dart:math' as math;

class HexEdResult {
  final int distanceAway;
  final int maxDistanceAway;

  HexEdResult(this.distanceAway, this.maxDistanceAway);
}

int solveA(List<String> steps) {
  return _solve(steps).distanceAway;
}

int solveB(List<String> steps) {
  return _solve(steps).maxDistanceAway;
}

HexEdResult _solve(List<String> steps) {
  int x = 0;
  int y = 0;
  int maxDistance = 0;

  for (String step in steps) {
    switch (step) {
      case 'n':
        y++;
        break;
      case 'ne':
        x++;
        break;
      case 'se':
        x++;
        y--;
        break;
      case 's':
        y--;
        break;
      case 'sw':
        x--;
        break;
      case 'nw':
        x--;
        y++;
        break;
      default:
        throw "Unknown step: $step";
    }

    maxDistance = math.max(maxDistance, _calcDistance(x, y));
  }

  return new HexEdResult(_calcDistance(x, y), maxDistance);
}

_calcDistance(int x, int y) =>
    math.max(x.abs(), math.max(y.abs(), (x + y).abs()));
