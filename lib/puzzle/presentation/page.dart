import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_2/puzzle/presentation/widget/colored_shape.dart';

import '../application/cubit_puzzle.dart';
import '../application/state_puzzle.dart';


class PuzzlePage extends StatelessWidget {
  const PuzzlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PuzzleCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Color Match Puzzle (Clean + Cubit)'),
          actions: [
            IconButton(
              onPressed: () => context.read<PuzzleCubit>().reset(),
              icon: const Icon(Icons.restart_alt),
            )
          ],
        ),
        body: BlocBuilder<PuzzleCubit, PuzzleState>(
          builder: (context, state) {
            final mq = MediaQuery.of(context).size;
            final shapes = state.shapes;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Drag each shape to the appropriate color.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),

                  // Targets
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: shapes.map((targetShape) {
                      return Column(
                        children: [
                          Text(targetShape.name.toUpperCase()),
                          const SizedBox(height: 8),
                          DragTarget<String>(
                            onAccept: (data) {
                              if (data == targetShape.name) {
                                context.read<PuzzleCubit>().placeShape(data);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Error! Try again.'),
                                  ),
                                );
                              }
                            },
                            builder: (context, candidateData, rejectedData) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: mq.width * 0.25,
                                height: mq.width * 0.25,
                                decoration: BoxDecoration(
                                  color: targetShape.isPlaced
                                      ? Colors.white
                                      : targetShape.color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: targetShape.color,
                                    width: 3,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: targetShape.isPlaced
                                    ? ColoredShape(
                                  shape: targetShape.name,
                                  color: targetShape.color,
                                  size: mq.width * 0.18,
                                )
                                    : Text(
                                  'Put color here\n${_colorName(targetShape.color)}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  ),

                  const Spacer(),

                  // Draggables
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: shapes.map((shape) {
                      if (shape.isPlaced) return const SizedBox.shrink();
                      return Draggable<String>(
                        data: shape.name,
                        feedback: Material(
                          color: Colors.transparent,
                          child: ColoredShape(
                            shape: shape.name,
                            color: shape.color,
                            size: 80,
                          ),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: ColoredShape(
                            shape: shape.name,
                            color: shape.color,
                            size: 80,
                          ),
                        ),
                        child: ColoredShape(
                          shape: shape.name,
                          color: shape.color,
                          size: 80,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _colorName(Color c) {
    if (c == Colors.red) return 'red';
    if (c == Colors.green) return 'green';
    if (c == Colors.blue) return 'blue';
    return 'لون';
  }
}
