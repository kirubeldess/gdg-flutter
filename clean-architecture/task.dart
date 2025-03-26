import 'dart:io';

// ---------------------
// Domain Layer Classes
// ---------------------

// Product Entity
class Product {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, imageUrl: $imageUrl, price: $price)';
  }
}

// In-Memory Repository to store products
class ProductRepository {
  final List<Product> _products = [];

  List<Product> getAllProducts() => _products;

  Product? getProductById(int id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  void addProduct(Product product) {
    if (getProductById(product.id) != null) {
      throw Exception('Product with id ${product.id} already exists.');
    }
    _products.add(product);
  }

  bool updateProduct(Product updatedProduct) {
    for (int i = 0; i < _products.length; i++) {
      if (_products[i].id == updatedProduct.id) {
        _products[i] = updatedProduct;
        return true;
      }
    }
    return false;
  }

  bool deleteProduct(int id) {
    final product = getProductById(id);
    if (product != null) {
      _products.remove(product);
      return true;
    }
    return false;
  }
}

// ---------------------
// Use Case Classes
// ---------------------

/// Use case for viewing all products.
class ViewAllProductsUsecase {
  final ProductRepository repository;
  ViewAllProductsUsecase(this.repository);

  List<Product> call() => repository.getAllProducts();
}

/// Use case for viewing a specific product by its id.
class ViewProductUsecase {
  final ProductRepository repository;
  ViewProductUsecase(this.repository);

  Product? call(int id) => repository.getProductById(id);
}

/// Use case for creating a new product.
class CreateProductUsecase {
  final ProductRepository repository;
  CreateProductUsecase(this.repository);

  void call(Product product) => repository.addProduct(product);
}

/// Use case for updating an existing product.
class UpdateProductUsecase {
  final ProductRepository repository;
  UpdateProductUsecase(this.repository);

  bool call(Product product) => repository.updateProduct(product);
}

/// Use case for deleting a product by its id.
class DeleteProductUsecase {
  final ProductRepository repository;
  DeleteProductUsecase(this.repository);

  bool call(int id) => repository.deleteProduct(id);
}

// ---------------------
// Interactive Application
// ---------------------

void main() {
  // Initialize repository and use cases
  final repository = ProductRepository();
  final viewAllProducts = ViewAllProductsUsecase(repository);
  final viewProduct = ViewProductUsecase(repository);
  final createProduct = CreateProductUsecase(repository);
  final updateProduct = UpdateProductUsecase(repository);
  final deleteProduct = DeleteProductUsecase(repository);

  while (true) {
    print('\n---------------------------------');
    print('eCommerce App - Product Management');
    print('1. View all products');
    print('2. View a product by ID');
    print('3. Create a new product');
    print('4. Update a product');
    print('5. Delete a product');
    print('6. Exit');
    print('---------------------------------');
    stdout.write('Select an option: ');
    String? input = stdin.readLineSync();

    if (input == null) {
      print('Invalid input, please try again.');
      continue;
    }

    int? option = int.tryParse(input);
    if (option == null) {
      print('Please enter a valid number.');
      continue;
    }

    switch (option) {
      case 1:
        // View all products.
        List<Product> products = viewAllProducts();
        if (products.isEmpty) {
          print('No products available.');
        } else {
          print('\n--- All Products ---');
          for (var product in products) {
            print(product);
          }
        }
        break;
      case 2:
        // View a specific product.
        stdout.write('Enter product ID: ');
        String? idInput = stdin.readLineSync();
        int? id = int.tryParse(idInput ?? '');
        if (id == null) {
          print('Invalid product ID.');
          break;
        }
        Product? product = viewProduct(id);
        if (product == null) {
          print('Product not found.');
        } else {
          print('\n--- Product Details ---');
          print(product);
        }
        break;
      case 3:
        // Create a new product.
        try {
          stdout.write('Enter product ID: ');
          String? idInput = stdin.readLineSync();
          int? id = int.tryParse(idInput ?? '');
          if (id == null) {
            print('Invalid ID.');
            break;
          }

          stdout.write('Enter product name: ');
          String? name = stdin.readLineSync();
          if (name == null || name.trim().isEmpty) {
            print('Name cannot be empty.');
            break;
          }

          stdout.write('Enter product description: ');
          String? description = stdin.readLineSync();
          if (description == null || description.trim().isEmpty) {
            print('Description cannot be empty.');
            break;
          }

          stdout.write('Enter product image URL: ');
          String? imageUrl = stdin.readLineSync();
          if (imageUrl == null || imageUrl.trim().isEmpty) {
            print('Image URL cannot be empty.');
            break;
          }

          stdout.write('Enter product price: ');
          String? priceInput = stdin.readLineSync();
          double? price = double.tryParse(priceInput ?? '');
          if (price == null) {
            print('Invalid price.');
            break;
          }

          Product newProduct = Product(
            id: id,
            name: name.trim(),
            description: description.trim(),
            imageUrl: imageUrl.trim(),
            price: price,
          );
          createProduct(newProduct);
          print('Product created successfully.');
        } catch (e) {
          print('Error: $e');
        }
        break;
      case 4:
        // Update a product.
        try {
          stdout.write('Enter product ID to update: ');
          String? idInput = stdin.readLineSync();
          int? id = int.tryParse(idInput ?? '');
          if (id == null) {
            print('Invalid product ID.');
            break;
          }

          // Check if product exists.
          Product? existingProduct = viewProduct(id);
          if (existingProduct == null) {
            print('Product with ID $id does not exist.');
            break;
          }

          stdout.write(
              'Enter new product name (leave blank to keep "${existingProduct.name}"): ');
          String? name = stdin.readLineSync();
          if (name == null || name.trim().isEmpty) {
            name = existingProduct.name;
          }

          stdout.write(
              'Enter new product description (leave blank to keep "${existingProduct.description}"): ');
          String? description = stdin.readLineSync();
          if (description == null || description.trim().isEmpty) {
            description = existingProduct.description;
          }

          stdout.write(
              'Enter new product image URL (leave blank to keep "${existingProduct.imageUrl}"): ');
          String? imageUrl = stdin.readLineSync();
          if (imageUrl == null || imageUrl.trim().isEmpty) {
            imageUrl = existingProduct.imageUrl;
          }

          stdout.write(
              'Enter new product price (leave blank to keep "${existingProduct.price}"): ');
          String? priceInput = stdin.readLineSync();
          double price;
          if (priceInput == null || priceInput.trim().isEmpty) {
            price = existingProduct.price;
          } else {
            double? parsedPrice = double.tryParse(priceInput);
            if (parsedPrice == null) {
              print('Invalid price input.');
              break;
            }
            price = parsedPrice;
          }

          Product updatedProduct = Product(
            id: id,
            name: name.trim(),
            description: description.trim(),
            imageUrl: imageUrl.trim(),
            price: price,
          );

          bool updated = updateProduct(updatedProduct);
          if (updated) {
            print('Product updated successfully.');
          } else {
            print('Failed to update product.');
          }
        } catch (e) {
          print('Error: $e');
        }
        break;
      case 5:
        // Delete a product.
        stdout.write('Enter product ID to delete: ');
        String? idInput = stdin.readLineSync();
        int? id = int.tryParse(idInput ?? '');
        if (id == null) {
          print('Invalid product ID.');
          break;
        }
        bool deleted = deleteProduct(id);
        if (deleted) {
          print('Product deleted successfully.');
        } else {
          print('Product not found.');
        }
        break;
      case 6:
        print('Exiting application.');
        return;
      default:
        print('Invalid option, please try again.');
    }
  }
}
