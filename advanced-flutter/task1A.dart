//Write a dart program to create a class Laptop with properties [ id , name , ram ] and create 3 objects of it and print all details.
class Laptop {
  int? id;
  String? name;
  int? ram;

  Laptop(this.id, this.name, this.ram);

  void showInfo() {
    print('Laptop ID: $id');
    print('Laptop Name: $name');
    print('Laptop RAM: ${ram} GB');

    print('-------------------');
  }
}

void main() {
  Laptop laptop1 = Laptop(1, 'HP Elitebook', 12);
  Laptop laptop2 = Laptop(2, 'HP Pavillon', 8);
  Laptop laptop3 = Laptop(3, 'Asus', 4);

  laptop1.showInfo();
  laptop2.showInfo();
  laptop3.showInfo();
}