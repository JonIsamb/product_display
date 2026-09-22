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

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildName(BuildContext context) {
    return Text(heading, style: Theme.of(context).textTheme.headlineSmall);
  }

  @override
  Widget buildDescription(BuildContext context) => const SizedBox.shrink();
  @override
  Widget buildPrice(BuildContext context) => const SizedBox.shrink();
  @override
  Widget buildImage(BuildContext context) => const SizedBox.shrink();
  @override
  Widget buildFavorite(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;
  final String? price;
  final String? image;
  final bool isFavorite;

  MessageItem(this.sender, this.body, {this.price, this.image, this.isFavorite = false});
  @override
  Widget buildName(BuildContext context) => Text(sender);

  @override
  Widget buildDescription(BuildContext context) => Text(body);

  @override
  Widget buildFavorite(BuildContext context) {
    if (isFavorite) {
      return const Icon(Icons.favorite, color: Colors.red);
    } else {
      return const Icon(Icons.favorite_border);
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
      return Text(price!);
    } else {
      return const SizedBox.shrink();
    }
  }
}