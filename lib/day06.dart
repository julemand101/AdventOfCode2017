// --- Day 6: Memory Reallocation ---
// https://adventofcode.com/2017/day/6

import 'package:collection/collection.dart';

const ListEquality<int> listEquality = ListEquality();

int solveA(List<int> banks) {
  return _solve(banks).length;
}

int solveB(List<int> banks) {
  final history = _solve(banks);

  for (int i = 0; i < history.length; i++) {
    if (listEquality.equals(history[i], history.last)) {
      return history.length - i - 1;
    }
  }

  throw Exception('Somethings wrong with the loop!');
}

List<List<int>> _solve(List<int> banks) {
  final history = <List<int>>[];
  var next = _nextBanksState(banks);

  while (!history.any((List<int> prev) => listEquality.equals(next, prev))) {
    history.add(next);
    next = _nextBanksState(next);
  }

  return history..add(next);
}

List<int> _nextBanksState(List<int> banks) {
  final nextBanksState = banks.toList(growable: false);
  final bankToEmpty = _findNextBankToEmpty(nextBanksState);
  var blocks = nextBanksState[bankToEmpty];

  nextBanksState[bankToEmpty] = 0;

  for (int i = bankToEmpty + 1; blocks > 0; i++, blocks--) {
    nextBanksState[i % nextBanksState.length]++;
  }

  return nextBanksState;
}

int _findNextBankToEmpty(List<int> banks) {
  int bigPos = 0;
  int bigValue = banks[0];

  for (int i = 1; i < banks.length; i++) {
    if (banks[i] > bigValue) {
      bigPos = i;
      bigValue = banks[i];
    }
  }

  return bigPos;
}
