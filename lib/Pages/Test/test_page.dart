import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:the_shavi/Reusable%20Function/reusable_funtion.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Hello!'),),
    );
  }
}


class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}

class ProductGridPage extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Product 1', price: 29.99, imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Product 2', price: 49.99, imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Product 3', price: 19.99, imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Product 4', price: 99.99, imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Product 5', price: 59.99, imageUrl: 'https://via.placeholder.com/150'),
  ];

  ProductGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ResponsiveGridList(
          // Adjust the minimum spacing between items
          minItemWidth: MyFun.isWebOrRotate(context)?400: 200,
          children: products.map((product) {
            return Card(
              elevation: 4,
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$${product.price.toString()}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
