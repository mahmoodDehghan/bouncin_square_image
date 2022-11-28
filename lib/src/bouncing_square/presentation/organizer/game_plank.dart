import 'package:bouncing_square_image/src/bouncing_square/bouncing_square.dart';
import 'package:bouncing_square_image/src/bouncing_square/presentation/organizer/game_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GamePlot extends HookWidget {
  const GamePlot({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 10),
    );
    return BlocBuilder<BouncingSquareBloc, BouncingSquareState>(
        builder: (context, state) {
      final leftTween = Tween<double>(
        begin: state.positionLeftStart,
        end: state.positionLeftEnd,
      );
      final topTween = Tween<double>(
        begin: state.positionTopStart,
        end: state.positionTopEnd,
      );
      return GameAnimator(
        key: ValueKey(state.currentDirection),
        leftTween: leftTween,
        topTween: topTween,
        maxLeft: state.maxLeft,
        maxTop: state.maxTop,
        currentImage: state.currentImage,
        animationController: animationController,
      );
    });
  }
}
