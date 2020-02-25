import 'dart:ui';

Color generateColor(String seed) => Color(
      (seed.hashCode * 0xFFFFFF).toInt() << 0,
    ).withOpacity(1.0);
