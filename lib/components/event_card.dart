import 'package:flutter/material.dart';
import 'package:raven_for_nitc/pages/event_details.dart';

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
      height: 360,
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
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
                ? child
                : Container(
                    width: 240,
                    height: 360,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailsPage(docId: id)),
        );
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: cardBody,
      ),
    );
  }

  static Widget dummy() {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 240,
        height: 360,
        alignment: Alignment.center,
        margin: EdgeInsets.all(16),
        child: Container(),
      ),
    );
  }
}
