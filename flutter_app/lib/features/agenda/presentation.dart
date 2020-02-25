import 'package:bratur/features/agenda/topics.dart';
import 'package:bratur/knowit_colors.dart';
import 'package:bratur/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendaPage extends StatelessWidget {
  final List<Event> events;
  final List<String> starredEvents;
  final Function(String eventId, bool starred) toggleStarredEvent;

  const AgendaPage({
    Key key,
    @required this.events,
    @required this.starredEvents,
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
            ),
            floating: false,
            pinned: true,
            expandedHeight: 80,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final starred = starredEvents.contains(events[index].id);

                return ListTile(
                  leading: Text(
                    DateFormat.jm().format(events[index].startTime),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  title: Text(events[index].title),
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
                          Text(events[index].location),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 4)),
                      Topics(topics: [
                        events[index].track,
                        ...events[index].topics,
                      ]),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: Icon(starred ? Icons.star : Icons.star_border),
                    onPressed: () {
                      toggleStarredEvent(events[index].id, !starred);
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/event',
                      arguments: events[index],
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
