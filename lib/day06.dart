// --- Day 6: Memory Reallocation ---
// http://adventofcode.com/2017/day/6

import 'package:collection/collection.dart';

final ListEquality listEquality = new ListEquality();

int solveA(List<int> banks) {
  return _solve(banks).length;
}

int solveB(List<int> banks) {
  List<List<int>> history = _solve(banks);

  for (int i = 0; i < history.length; i++) {
    if (listEquality.equals(history[i], history.last)) {
      return history.length - i - 1;
    }
  }

  throw ("Something's wrong with the loop!");
}

List<List<int>> _solve(List<int> banks) {
  List<List<int>> history = new List();
  List<int> next = banks;

  while (true) {
    next = _nextBanksState(next);

    if (history.any((List<int> prev) => listEquality.equals(next, prev))) {
      history.add(next);
      return history;
    } else {
      history.add(next);
    }
  }
}

List<int> _nextBanksState(List<int> banks) {
  List<int> nextBanksState = new List.from(banks, growable: false);
  int bankToEmpty = _findNextBankToEmpty(nextBanksState);
  int blocks = nextBanksState[bankToEmpty];

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
