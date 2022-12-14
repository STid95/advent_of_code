import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  String input = await readFile();
  findMarker(input, true);
  findMarker(input, false);
}

void findMarker(String input, bool partOne) {
  List<String> limitChars = [];
  int limit = partOne ? 4 : 14;

  for (int i = 0; i < input.length; i++) {
    String char = input[i];

    if (limitChars.length < limit) {
      limitChars.add(char);
    } else if (limitChars.toSet().length == limitChars.length) {
      print("The total number processed is $i");
      break;
    } else {
      limitChars.removeAt(0);
      limitChars.add(char);
    }
  }
}

Future<String> readFile() async {
  return File('inputs/day_six/input.txt').readAsString(encoding: utf8);
}
