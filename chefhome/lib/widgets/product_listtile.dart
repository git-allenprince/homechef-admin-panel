// ignore_for_file: deprecated_member_use

import 'package:chefhome/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:chefhome/models/models.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          product.imageUrl,
        ),
      ),
      title: Text(
        product.name,
        style: Theme.of(context).textTheme.headline5,
      ),
      subtitle: Text(
        product.description,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
