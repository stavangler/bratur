import 'package:bratur/features/agenda/topics.dart';
import 'package:bratur/models/event.dart';
import 'package:bratur/models/user.dart';
import 'package:bratur/utils/generate_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  final Event event;

  const EventPage({Key key, @required this.event}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<User> _speakers = [];

  @override
  void initState() {
    super.initState();
    Future.wait(widget.event.speakers).then(
      (speakers) => setState(() {
        _speakers = speakers;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 16)),
            Text(
                '${DateFormat.MMMMEEEEd().addPattern('', ', ').add_jm().format(widget.event.startTime)} - ${DateFormat.jm().format(widget.event.startTime.add(Duration(minutes: widget.event.duration)))}',
                style: Theme.of(context).textTheme.subtitle2),
            Padding(padding: EdgeInsets.only(top: 4)),
            Text(widget.event.location,
                style: Theme.of(context).textTheme.subtitle2),
            Padding(padding: EdgeInsets.only(top: 32)),
            Text(widget.event.description),
            Padding(padding: EdgeInsets.only(top: 16)),
            Topics(topics: [widget.event.track, ...widget.event.topics]),
            if (widget.event.speakers.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 32, bottom: 8),
                child: Text(
                  'Speakers'.toUpperCase(),
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ..._speakers.map((speaker) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(speaker.photoUrl),
                    backgroundColor: speaker.photoUrl == null
                        ? generateColor(speaker.name)
                        : null,
                    child: speaker.photoUrl == null
                        ? Text(
                            speaker.name.splitMapJoin(' ',
                                onMatch: (match) => '',
                                onNonMatch: (nonMatch) => nonMatch[0]),
                          )
                        : null,
                  ),
                  title: Text(speaker.name),
                )),
          ],
        ),
      ),
    );
  }
}
