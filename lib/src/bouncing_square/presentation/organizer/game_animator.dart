import 'package:bouncing_square_image/src/bouncing_square/bouncing_square.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GameAnimator extends HookWidget {
  const GameAnimator({
    Key? key,
    required this.leftTween,
    required this.topTween,
    required this.maxLeft,
    required this.maxTop,
    required this.currentImage,
    required this.animationController,
  }) : super(key: key);

  final Tween<double> topTween;
  final Tween<double> leftTween;
  final double maxLeft;
  final double maxTop;
  final BounceImageModel currentImage;
  final AnimationController animationController;

  void _onDragUpdate(BuildContext context, DragUpdateDetails details,
      double currentX, double currentY, AnimationController controller) {
    controller.stop();
    controller.reset();
    context.read<BouncingSquareBloc>().add(
          BouncerSquareSwipped(
            deltaX: details.delta.dx,
            deltaY: details.delta.dy,
            currentX: currentX,
            currentY: currentY,
          ),
        );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> curve =
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut);
    final topAnimation = useAnimation(topTween.animate(curve));
    final leftAnimation = useAnimation(leftTween.animate(curve));
    if (leftAnimation == maxLeft ||
        topAnimation == maxTop ||
        leftAnimation == 0 ||
        topAnimation == 0) {
      animationController.stop();
      animationController.reset();
      context.read<BouncingSquareBloc>().add(BouncerSquareHit());
    }
    animationController.forward();
    return SizedBox.expand(
      child: GestureDetector(
        onHorizontalDragUpdate: (details) => _onDragUpdate(
          context,
          details,
          leftAnimation,
          topAnimation,
          animationController,
        ),
        onVerticalDragUpdate: (details) => _onDragUpdate(
          context,
          details,
          leftAnimation,
          topAnimation,
          animationController,
        ),
        child: Stack(
          children: [
            Positioned(
              left: leftAnimation, //state.positionLeft,
              top: topAnimation,
              child: BouncingSquareWidget(
                image: currentImage,
                squareSize: 150.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
