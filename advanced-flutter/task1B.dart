/* Write a dart program to create a class Animal with properties [ id, name , color ]. 
Create another class called Cat and extends it from Animal. Add new properties 
sound in String . Create an object of a Cat and print all details.  */

class Animal {
  int? id;
  String? name;
  String? color;

  Animal(this.id, this.name, this.color);
}

class Cat extends Animal {
  String? sound;

  Cat(int id, String name, String color, this.sound) : super(id, name, color);
  void showInfo() {
    print('ID of the cat: $id');
    print('Name of the cat: $name');
    print('Color of the cat: $color');
    print('Sound of the cat: $sound');

    print('--------------');
  }
}

void main() {
  Cat meaw = Cat(1, 'Megatron', 'Black', 'Meaw');
  Cat woof = Cat(2, 'Bomboclat', 'Black', 'Awuu');

  meaw.showInfo();
  woof.showInfo();
}
