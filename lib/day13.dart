// --- Day 13: Packet Scanners ---
// https://adventofcode.com/2017/day/13

import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;

int solveA(Iterable<String> inputs) {
  Map<int, int> map = _parse(inputs);
  return _solve(map);
}

int solveB(Iterable<String> inputs) {
  Map<int, int> map = _parse(inputs);
  int delay = 0;

  while (true) {
    if (_solve(map, startTime: delay, stopWhenCaught: true) == 0) {
      return delay;
    } else {
      delay++;
    }
  }
}

Future<int> solveB_with_isolates(Iterable<String> inputs, int chunkSize) {
  Completer<int> completer = new Completer();
  Map<int, int> map = _parse(inputs);
  int delay = 0;
  int lowestResult = -1;
  int numberOfActiveIsolates = Platform.numberOfProcessors + 1;

  RawReceivePort rport = new RawReceivePort((List input) {
    int result = input[0];
    SendPort sport = input[1];

    if (result == -1) {
      if (lowestResult == -1) {
        sport.send([delay, delay += chunkSize]);
      } else {
        numberOfActiveIsolates--;
        sport.send([-1, -1]);
      }
    } else {
      numberOfActiveIsolates--;
      if (lowestResult == -1 || result < lowestResult) {
        lowestResult = result;
      }
    }

    if (numberOfActiveIsolates == 0) {
      completer.complete(lowestResult);
    }
  });

  for (int i = 0; i < numberOfActiveIsolates; i++) {
    Isolate.spawn(_work, [map, rport.sendPort]);
  }

  return completer.future;
}

void _work(List args) {
  Map<int, int> map = args[0];
  SendPort sport = args[1];

  RawReceivePort rport = new RawReceivePort();
  rport.handler = ((List input) {
    int from = input[0];
    int to = input[1];

    if (from == -1 || to == -1) {
      rport.close();
      return;
    }

    for (int delay = from; delay < to; delay++) {
      if (_solve(map, startTime: delay, stopWhenCaught: true) == 0) {
        sport.send([delay, rport.sendPort]);
        rport.close();
        return;
      }
    }

    sport.send([-1, rport.sendPort]);
  });

  sport.send([-1, rport.sendPort]);
}

int _solve(Map<int, int> map, {startTime: 0, stopWhenCaught: false}) {
  int max = map.keys.reduce(math.max);
  int score = 0;

  for (int depth = 0; depth <= max; depth++) {
    if (map.containsKey(depth)) {
      int range = map[depth];

      if (_move(depth + startTime, range) == 0) {
        score += (depth * range);

        if (stopWhenCaught) {
          return 1;
        }
      }
    }
  }

  return score;
}

Map<int, int> _parse(Iterable<String> inputs) {
  Map<int, int> map = new Map();

  for (String input in inputs) {
    var parts = input.split(": "); // e.g. "0: 3"
    int depth = int.parse(parts[0]);
    int range = int.parse(parts[1]);

    map[depth] = range;
  }

  return map;
}

int _move(int time, int range) {
  int pos = 0;
  bool back = false;

  for (int i = 0; i < time % ((range - 1) * 2); i++) {
    if (back) {
      if (--pos == 0) {
        back = false;
      }
    } else {
      if (++pos == (range - 1)) {
        back = true;
      }
    }
  }

  return pos;
}
