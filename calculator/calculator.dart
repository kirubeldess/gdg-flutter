import 'dart:io';

void main() {
  stdout.write('Enter first number: ');
  double num1 = double.parse(stdin.readLineSync()!);

  stdout.write('Enter second number: ');
  double num2 = double.parse(stdin.readLineSync()!);

  stdout.write('Select operation (+, -, *, /): ');
  String? op = stdin.readLineSync();

  double result;

  switch (op) {
    case '+':
      result = num1 + num2;
      break;
    case '-':
      result = num1 - num2;
      break;
    case '*':
      result = num1 * num2;
      break;
    case '/':
      if (num2 == 0) {
        print('Error: Cannot divide by zero.');
        return;
      }
      result = num1 / num2;
      break;
    default:
      print('Error: Invalid operator.');
      return;
  }

  print('Result: $result');
}
