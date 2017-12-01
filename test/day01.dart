// --- Day 1: Inverse Captcha ---
// http://adventofcode.com/2017/day/1

import 'package:test/test.dart';
import 'package:AdventOfCode2017/day01.dart';

const String PUZZLE_INPUT =
    "23736999148234612466339528635467298545732686574853341217977818839783527958"
    "41499719997985122794292687271717554614189745585382464299867475324178461575"
    "26523238931351898548279549456694488433438982744782258279173323381571985454"
    "23656939397573571533143825679557951415994653786835873593683248742293867819"
    "47576876981432241392431512224751313371358437936117423832671861586657269279"
    "67655583875485515512626142935357421852953775733748941926983377725386196187"
    "48613133745857482984872371135592968462522356448948559756476831743289383662"
    "92552734527762323192654225334495499562447915655737277626874392218626327222"
    "77129613329167189874939414298584616496839223239197277563641853746193232543"
    "22281329819516934518649986614758655978152383459568349615158154682911274553"
    "33477962136738149958491563216743796443231592591319254449612968211674836288"
    "12395391533572555624159939279125341335147234653572977345582135728994395631"
    "68561813556366268985469197684343578587995275126662764565398128189164382371"
    "75287573411367478815186114392468773739357581511191855879213321751893324365"
    "22732144278613486716525897262879287772969529445511736924962777262394961547"
    "57924873134324524196391477599129217715155444669513465359663343317186661854"
    "19572334635481421732358211681566368242334879837666123384988742516729939174"
    "46366865832618475491341253973267556113323245113845148121546526396995991171"
    "73983714747997864516641798891828928784438451397436939797437881984855215396"
    "16518815281346248694545634888586252613567635627232617678735426837966757971"
    "24322382732437235544965647934514871672522777378931524994784845817584793564"
    "97428513986797218588718598735346848815528369846422641595158313835283994362"
    "12941172624835598676615962997539863472447863395431745942664228157946584776"
    "29829383461829261994591318851587963554829459353892825847978971823347219468"
    "51678485734864969318517219939823412374541527122289116117578871373344449759"
    "28532217431383242359342166583237172677153187445376894591131885498967375816"
    "37879552568829548365738314593851221113932919767844137362623398623853789938"
    "824592";

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA("1122"), equals(3));
    });
    test('Example 2', () {
      expect(solveA("1111"), equals(4));
    });
    test('Example 3', () {
      expect(solveA("1234"), equals(0));
    });
    test('Example 4', () {
      expect(solveA("91212129"), equals(9));
    });
    test('Solution', () {
      expect(solveA(PUZZLE_INPUT), equals(995));
    });
  });
  
  group("Part Two", () {
    test('Example 1', () {
      expect(solveB("1212"), equals(6));
    });
    test('Example 2', () {
      expect(solveB("1221"), equals(0));
    });
    test('Example 3', () {
      expect(solveB("123425"), equals(4));
    });
    test('Example 4', () {
      expect(solveB("123123"), equals(12));
    });
    test('Example 5', () {
      expect(solveB("12131415"), equals(4));
    });
    test('Solution', () {
      expect(solveB(PUZZLE_INPUT), equals(1130));
    });
  });
}
