import 'package:flutter/material.dart';

class ShapeEntity {
  final String name;   // circle, square, triangle
  final Color color;
  final bool isPlaced;

  ShapeEntity({
    required this.name,
    required this.color,
    this.isPlaced = false,
  });

  ShapeEntity copyWith({bool? isPlaced}) {
    return ShapeEntity(
      name: name,
      color: color,
      isPlaced: isPlaced ?? this.isPlaced,
    );
  }
}
