import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The name line to show in a list item.
  Widget buildName(BuildContext context);
  /// The description line, if any, to show in a list item.
  Widget buildDescription(BuildContext context);

  /// The price line, if any, to show in a list item.
  Widget buildPrice(BuildContext context);

  /// The image line, if any, to show in a list item.
  Widget buildImage(BuildContext context);

  Widget buildFavorite(BuildContext context) {
    return const SizedBox.shrink();
  }
 

}

/// A ListItem that contains data to display a message.
class PadelRaquet implements ListItem {
  final String name;
  final String description;
  final double? price;
  final String? image;
  final bool isFavorite;

  PadelRaquet(this.name, this.description, this.price, this.image, this.isFavorite);
  @override
  Widget buildName(BuildContext context) => Text(name);

  @override
  Widget buildDescription(BuildContext context) => Text(description);

  @override
  Widget buildFavorite(BuildContext context) {
    if (isFavorite) {
      return Container(
        child: Row(
          children: [
            Icon(Icons.favorite, color: Colors.red),
            Text('Retirer des favoris')
          ]
        ),
      );
    } else {
      return Container(
        child: Row(
            children: [
              Icon(Icons.favorite_border),
              Text('Ajouter aux favoris')
            ]
        ),
      );
    }
  }

  @override
  Widget buildImage(BuildContext context) {
    if (image != null) {
      return Image.network(image!);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget buildPrice(BuildContext context) {
    if (price != null) {
      return Text(price.toString());
    } else {
      return const SizedBox.shrink();
    }
  }
}