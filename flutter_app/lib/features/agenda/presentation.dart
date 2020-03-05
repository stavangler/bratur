import 'dart:io';

import 'package:bratur/features/agenda/topics.dart';
import 'package:bratur/knowit_colors.dart';
import 'package:bratur/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendaPage extends StatelessWidget {
  final List<Event> events;
  final Function(String eventId, bool starred) toggleStarredEvent;

  const AgendaPage({
    Key key,
    @required this.events,
    @required this.toggleStarredEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Agenda'),
              titlePadding: EdgeInsetsDirectional.only(
                start: Platform.isIOS ? 0 : 90,
                bottom: 16,
              ),
            ),
            floating: false,
            pinned: true,
            expandedHeight: 80,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final event = events[index];

                return ListTile(
                  leading: Text(
                    DateFormat.jm().format(event.startTime),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  title: Text(event.title),
                  subtitle: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 4)),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: KnowitColors.clay,
                          ),
                          Text(event.location),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 4)),
                      Topics(topics: [
                        event.track,
                        ...event.topics,
                      ]),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: Icon(event.starred ? Icons.star : Icons.star_border),
                    onPressed: () {
                      toggleStarredEvent(event.id, !event.starred);
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/event',
                      arguments: event,
                    );
                  },
                );
              },
              childCount: events.length,
            ),
          ),
        ],
      ),
    );
  }
}
