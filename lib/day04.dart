// --- Day 4: High-Entropy Passphrases ---
// https://adventofcode.com/2017/day/4

typedef PassphraseValidator = bool Function(String passphrase);

int solveA(List<String> passphrases) {
  return _solve(passphrases, _containsNoDuplicatedWords);
}

int solveB(List<String> passphrases) {
  return _solve(passphrases, _containsNoAnagrams);
}

int _solve(List<String> passphrases, PassphraseValidator validate) {
  return passphrases
      .where((line) => line.trim().isNotEmpty)
      .where(validate)
      .length;
}

bool _containsNoDuplicatedWords(String passphrase) {
  final set = <String>{};

  for (final word in passphrase.split(" ")) {
    if (set.contains(word)) {
      return false;
    } else {
      set.add(word);
    }
  }

  return true;
}

bool _containsNoAnagrams(String passphrase) {
  final words = <String>[];

  for (final word in passphrase.split(' ')) {
    if (words.any((String x) => _isAnagram(x, word))) {
      return false;
    } else {
      words.add(word);
    }
  }

  return true;
}

bool _isAnagram(String word1, String word2) {
  if (word1.length == word2.length) {
    final word2AsList =
        List.generate(word2.length, (int index) => word2[index]);

    for (int i = 0; i < word1.length; i++) {
      if (!word2AsList.contains(word1[i])) {
        return false;
      } else {
        word2AsList.remove(word1[i]);
      }
    }
    return true;
  }
  return false;
}
