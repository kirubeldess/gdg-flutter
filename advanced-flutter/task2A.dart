/* Write a program to print current time after 5 seconds using 
Future.delayed() */

import 'dart:async';

void main() {
  Future.delayed(Duration(seconds: 5), () {
    DateTime fivesecTime = DateTime.now();
    print("Current time after 5 secs: $fivesecTime");
  });

}
