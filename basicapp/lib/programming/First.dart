// print('Hello World');   Basic Program

import 'package:flutter/foundation.dart';

class Sanjit {
  // Class
  late int age;
  var city;
  late List mobile; // variable
  late bool isAlive;

  void showData(int age, var city, List mobile, bool isAlive) {
    this.mobile = mobile;
    this.city = city;
    this.age = age; // method
    this.isAlive = isAlive;
    print(age);
    print(city);
    print(mobile);
    print(isAlive);
  }
}

void main() {
  Sanjit obj = new Sanjit(); // Object
  obj.showData(21, 'Surat', [1, 2, 3, 4, 5, 6], true);
  var seeAge = obj.age;
  if (kDebugMode) {
    print(seeAge);
  }

  // Var vs Dayanmic
  
  var first='Sanjit';
   final  second='kumar';
   first='Sanjit Kumar';
  // second='Sanjit';
   print(first);
   print(second);

}
