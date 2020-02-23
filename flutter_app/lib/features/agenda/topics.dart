import 'package:bratur/utils/generate_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Topics extends StatelessWidget {
  final List<String> topics;

  const Topics({
    Key key,
    @required this.topics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(padding: EdgeInsets.only(left: 2)),
        ...topics.expand(
          (category) {
            return [
              Container(
                width: 12,
                height: 12,
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: generateColor(category),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text('$category ',
                    style: GoogleFonts.robotoMono(
                        textStyle: Theme.of(context).textTheme.caption)),
              ),
            ];
          },
        )
      ],
      crossAxisAlignment: WrapCrossAlignment.center,
    );
  }
}
