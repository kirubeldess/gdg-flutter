/*Write a program in dart that uses Future class to perform multiple 
asynchronous operations, wait for all of them to complete, and 
then print the results. */

import 'dart:async';

void main() async {

  Future<String> step1 = Future.delayed(Duration(seconds: 3), () {
    return 'step 1';
  });

  Future<String> step2 = Future.delayed(Duration(seconds: 2), () {
    return 'step 2';
  });
  Future<String> step3 = Future.delayed(Duration(seconds: 1), () {
    return 'step 3';
  });

  List<String> steps =
      await Future.wait([step1, step2, step3]);

  for (var step in steps) {
    print(step);
  }
}
