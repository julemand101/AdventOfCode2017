// --- Day 13: Packet Scanners ---
// https://adventofcode.com/2017/day/13

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;

int solveA(Iterable<String> inputs) {
  return _solve(_parse(inputs));
}

int solveB(Iterable<String> inputs) {
  var delay = 0;

  while (_solve(_parse(inputs), startTime: delay, stopWhenCaught: true) != 0) {
    delay++;
  }

  return delay;
}

Future<int> solveBWithIsolates(Iterable<String> inputs, int chunkSize) {
  final completer = Completer<int>();
  final map = _parse(inputs);
  var delay = 0;
  var lowestResult = -1;
  var numberOfActiveIsolates = Platform.numberOfProcessors + 1;

  final rport = RawReceivePort((List<Object> input) {
    final result = input[0] as int;
    final sport = input[1] as SendPort;

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

void _work(List<Object> args) {
  final map = args[0] as Map<int, int>;
  final sport = args[1] as SendPort;

  final rport = RawReceivePort();
  rport.handler = (List<int> input) {
    final from = input[0];
    final to = input[1];

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
  };

  sport.send([-1, rport.sendPort]);
}

int _solve(Map<int, int> map,
    {int startTime = 0, bool stopWhenCaught = false}) {
  final max = map.keys.reduce(math.max);
  int score = 0;

  for (int depth = 0; depth <= max; depth++) {
    if (map.containsKey(depth)) {
      final range = map[depth]!;

      if (_move(depth + startTime, range) == 0) {
        score += depth * range;

        if (stopWhenCaught) {
          return 1;
        }
      }
    }
  }

  return score;
}

Map<int, int> _parse(Iterable<String> inputs) {
  final map = <int, int>{};

  for (final input in inputs) {
    final parts = input.split(": "); // e.g. "0: 3"
    final depth = int.parse(parts[0]);
    final range = int.parse(parts[1]);

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
