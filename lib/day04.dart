// --- Day 4: High-Entropy Passphrases ---
// https://adventofcode.com/2017/day/4

typedef bool PassphraseValidator(String passphrase);

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
  Set<String> set = new Set();

  for (String word in passphrase.split(" ")) {
    if (set.contains(word)) {
      return false;
    } else {
      set.add(word);
    }
  }

  return true;
}

bool _containsNoAnagrams(String passphrase) {
  List<String> words = new List();

  for (String word in passphrase.split(" ")) {
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
    for (int i = 0; i < word1.length; i++) {
      if (!word2.contains(word1[i])) {
        return false;
      } else {
        word2 = word2.replaceFirst(word1[i], "");
      }
    }
    return true;
  }
  return false;
}
