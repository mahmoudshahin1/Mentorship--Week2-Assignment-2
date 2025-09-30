
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:widget_2/puzzle/application/state_puzzle.dart';

import '../domain/entities.dart';



class PuzzleCubit extends Cubit<PuzzleState> {
  PuzzleCubit()
      : super(PuzzleState(
    shapes: [
      ShapeEntity(name: 'circle', color: Colors.red),
      ShapeEntity(name: 'square', color: Colors.green),
      ShapeEntity(name: 'triangle', color: Colors.blue),
    ],
  ));

  void reset() {
    emit(PuzzleState(
      shapes: state.shapes
          .map((s) => s.copyWith(isPlaced: false))
          .toList(),
    ));
  }

  void placeShape(String shapeName) {
    final updated = state.shapes.map((s) {
      if (s.name == shapeName) {
        return s.copyWith(isPlaced: true);
      }
      return s;
    }).toList();

    emit(PuzzleState(shapes: updated));
  }
}
