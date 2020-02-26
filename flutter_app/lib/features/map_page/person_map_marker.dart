import 'package:bratur/models/user.dart';
import 'package:bratur/utils/generate_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PersonMapMarker extends StatelessWidget {
  final User user;
  final _tooltipKey = GlobalKey();

  PersonMapMarker({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      key: _tooltipKey,
      message: user.name,
      child: GestureDetector(
        onTap: () {
          dynamic tooltipState = _tooltipKey.currentState;
          tooltipState.ensureTooltipVisible();
        },
        child: Material(
          color: generateColor(user.userId),
          shape: CircleBorder(),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundImage:
                  user.photoUrl != null ? NetworkImage(user.photoUrl) : null,
              backgroundColor:
                  user.photoUrl == null ? generateColor(user.userId) : null,
              child: user.photoUrl == null
                  ? Text(
                      user.name.splitMapJoin(' ',
                          onMatch: (match) => '',
                          onNonMatch: (nonMatch) => nonMatch[0]),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
