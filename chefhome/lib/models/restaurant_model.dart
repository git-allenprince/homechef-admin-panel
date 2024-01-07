import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '/models/models.dart';

class Restaurant extends Equatable {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? description;
  final List<String>? tags;
  final List<Category>? categories;
  final List<Product>? products;

  const Restaurant({
    this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.tags,
    this.categories,
    this.products,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      imageUrl,
      description,
      tags,
      categories,
      products,
    ];
  }

  Restaurant copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
    List<String>? tags,
    List<Category>? categories,
    List<Product>? products,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      categories: categories ?? this.categories,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id ?? '',
      'name': name ?? '',
      'imageUrl': imageUrl ?? '',
      'description': description ?? '',
      'tags': tags ?? [],
      'categories': categories!.map(
        (category) {
          return category.toDocument();
        },
      ).toList(),
      'products': products!.map(
        (product) {
          return product.toDocument();
        },
      ).toList(),
    };
  }

  String toJson() => json.encode(toDocument());

  // factory RestaurantOne.fromJson(String source) => RestaurantOne.fromMap(json.decode(source));

  factory Restaurant.fromSnapshot(DocumentSnapshot snap) {
    return Restaurant(
      id: snap.id,
      name: snap['name'],
      imageUrl: snap['imageUrl'],
      description: snap['description'],
      tags: (snap['tags'] as List).map(
        (tag) {
          return tag as String;
        },
      ).toList(),
      categories: (snap['categories'] as List).map(
        (category) {
          return Category.fromSnapshot(category);
        },
      ).toList(),
      products: (snap['products'] as List).map(
        (product) {
          return Product.fromSnapshot(product);
        },
      ).toList(),
    );
  }

  static List<Restaurant> restaurants = [
    Restaurant(
      id: '1',
      name: 'HomeMakerD',
      imageUrl: 'assets/images/dosa.jpeg',
      description: 'Breakfast,Lunch,Dinner',
      tags: const ['Breakfast', 'Lunch'],
      categories: Category.categories,
      products: Product.products,
    ),
  ];
}
