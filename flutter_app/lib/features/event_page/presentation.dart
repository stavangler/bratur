import 'package:bratur/models/event.dart';
import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  final Event event;

  const EventPage({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.title, style: Theme.of(context).textTheme.headline6),
            Text(event.location, style: Theme.of(context).textTheme.subtitle2),
            Wrap(
              children: [...event.categories.map((category) => Text(category))],
            )
          ],
        ),
      ),
    );
  }
}
