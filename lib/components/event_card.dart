import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard(
      {super.key, required this.title, required this.id, this.imageUrl});

  final String title;
  final String id;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    Widget cardBody = Container(
      width: 240,
      alignment: Alignment.center,
      margin: EdgeInsets.all(16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall,
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
      ),
    );

    if (imageUrl != null) {
      cardBody = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: 240,
      );
    }

    return GestureDetector(
      onTap: () {},
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: cardBody,
      ),
    );
  }
}
