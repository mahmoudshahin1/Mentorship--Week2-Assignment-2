import 'package:flutter/material.dart';
import 'package:widget_2/puzzle/presentation/widget/tringel_parinter.dart';

class ColoredShape extends StatelessWidget {
  final String shape;
  final Color color;
  final double size;
  const ColoredShape({
    super.key,
    required this.shape,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    switch (shape) {
      case 'circle':
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        );
      case 'square':
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      case 'triangle':
        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(painter: TrianglePainter(color)),
        );
      default:
        return const SizedBox();
    }
  }
}
