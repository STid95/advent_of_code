import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  await partOne();
  await partTwo();
}

Future<void> partOne() async {
  List<String> list = await readFile();
  final instructions = createInstructions(list);
  Map<String, List<String>> stocks = createStocks(list);
  for (var element in instructions) {
    stocks = executeInstruction(element, stocks, true);
  }
  print("Results for part one");
  for (var element in stocks.entries) {
    if (element.value.isEmpty) {
      print(' ');
    } else {
      print(element.value.first);
    }
  }
}

Future<void> partTwo() async {
  List<String> list = await readFile();
  final instructions = createInstructions(list);
  Map<String, List<String>> stocks = createStocks(list);
  for (var element in instructions) {
    stocks = executeInstruction(element, stocks, false);
  }
  print("Results for part two");

  for (var element in stocks.entries) {
    if (element.value.isEmpty) {
      print(' ');
    } else {
      print(element.value.first);
    }
  }
}

Map<String, List<String>> executeInstruction(
    String element, Map<String, List<String>> stocks, bool partOne) {
  final move = RegExp('move ');
  final from = RegExp('from ');
  final to = RegExp('to ');

  int amount = int.parse(element.substring(
      move.firstMatch(element)!.end, move.firstMatch(element)!.end + 2));
  String start = element
      .substring(
          from.firstMatch(element)!.end, from.firstMatch(element)!.end + 2)
      .trimRight();
  String end = element.substring(to.firstMatch(element)!.end);

  Iterable<String> stocksToAdd = [];
  if (amount == stocks[start]!.length) {
    stocksToAdd = stocks[start]!;
  } else {
    stocksToAdd = stocks[start]!.getRange(0, amount);
  }
  if (partOne) {
    for (var element in stocksToAdd) {
      stocks[end]!.insert(0, element);
    }
  } else {
    stocks[end]!.insertAll(0, stocksToAdd);
  }
  stocks[start]!.removeRange(
      0, amount > stocks[start]!.length - 1 ? stocks[start]!.length : amount);
  return stocks;
}

Map<String, List<String>> createStocks(List<String> list) {
  List<String> stacks = list
      .firstWhere((element) => element.contains("1"))
      .replaceAll("  ", "")
      .split(" ");
  stacks.removeWhere((element) => element == "");
  list.removeAt(8);
  List<String> crates = list.sublist(
      0, list.indexOf(list.firstWhere((element) => element == '')));
  crates = crates.map((e) {
    e = e.replaceAll('[', '').replaceAll(']', '').replaceAll('  ', ' ');
    return e;
  }).toList();
  Map<String, List<String>> totalStocks = {};
  int offset = -1;
  for (var stackNum in stacks) {
    List<String> cratesInStack = [];
    for (var crate in crates) {
      cratesInStack.add(crate[int.parse(stackNum) + offset]);
    }
    cratesInStack.removeWhere((element) => element == ' ');
    totalStocks.addAll({stackNum: cratesInStack});
    offset++;
  }
  return totalStocks;
}

List<String> createInstructions(List<String> list) {
  return list.sublist(
      list.indexOf(list.firstWhere((element) => element == '')) + 1,
      list.length - 1);
}

Future<List<String>> readFile() async {
  final input =
      await File('inputs/day_five/input.txt').readAsString(encoding: utf8);
  final list = input.split("\n");
  return list;
}
