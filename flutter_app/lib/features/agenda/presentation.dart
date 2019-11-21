import 'package:bratur/features/event_page/presentation.dart';
import 'package:bratur/knowit_colors.dart';
import 'package:bratur/models/event.dart';
import 'package:flutter/material.dart';

class AgendaPage extends StatelessWidget {
  final List<Event> events;
  final GlobalKey<NavigatorState> navigatorState;

  const AgendaPage({
    Key key,
    @required this.events,
    @required this.navigatorState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildNavigator();
  }

  Widget buildNavigator() {
    return Navigator(
      key: navigatorState,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            switch (settings.name) {
              case '/':
                return buildAgenda();
              case '/event':
                return settings.arguments is Event
                    ? EventPage(event: settings.arguments)
                    : buildAgenda();
            }
            return buildAgenda();
          },
        );
      },
    );
  }

  Widget buildAgenda() {
    return CustomScrollView(
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
              return ListTile(
                leading: Text(
                  events[index].time,
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
                    Wrap(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 2)),
                        ...events[index].categories.expand(
                          (category) {
                            return [
                              Container(
                                width: 12,
                                height: 12,
                                margin: EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(
                                    (category.hashCode * 0xFFFFFF).toInt() << 0,
                                  ).withOpacity(1.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text('$category '),
                              ),
                            ];
                          },
                        )
                      ],
                      crossAxisAlignment: WrapCrossAlignment.center,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                isThreeLine: true,
                trailing: IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () {},
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
    );
  }
}
