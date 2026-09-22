import 'package:flutter/material.dart';

class PadelRaquet {
  final String name;
  final String description;
  final double? price;
  final String? image;
  bool isFavorite;

  PadelRaquet(this.name, this.description, this.price, this.image, this.isFavorite);

  Widget buildName(BuildContext context) => Text(name);

  Widget buildDescription(BuildContext context) => Text(description);

  Widget buildFavorite(BuildContext context, VoidCallback onToggle) {
    if (isFavorite) {
      return Row(
        children: [
          IconButton(onPressed: onToggle, icon: Icon(Icons.favorite, color: Colors.red)),
          Text('Retirer des favoris')
        ],
      );
    } else {
      return Row(
        children: [
          IconButton(onPressed: onToggle, icon: Icon(Icons.favorite_border)),
          Text('Ajouter aux favoris')
        ],
      );
    }
  }

  Widget buildImage(BuildContext context) {
    if (image != null) {
      return Image.network(image!);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildPrice(BuildContext context) {
    if (price != null) {
      return Text('$price €');
    } else {
      return const SizedBox.shrink();
    }
  }

  void setIsFavorite(bool isFavoriteValue) {
    isFavorite = isFavoriteValue;
  }
}