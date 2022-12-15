import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  List<String> list = await readFile();

  print(list);
}

Future<List<String>> readFile() async {
  final input =
      await File('inputs/day_seven/example.txt').readAsString(encoding: utf8);
  final list = input.split("\n");
  return list;
}
