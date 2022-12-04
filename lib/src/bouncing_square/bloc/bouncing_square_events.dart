part of 'bouncing_square_bloc.dart';

enum SwipeDirection {
  left,
  right,
  up,
  down,
  upLeft,
  upRight,
  downLeft,
  downRight,
  none,
}

abstract class BouncingSquareEvent extends Equatable {
  const BouncingSquareEvent();

  @override
  List<Object> get props => [];
}

class BouncerSquareClicked extends BouncingSquareEvent {}

class BouncerSquareSwipped extends BouncingSquareEvent {
  final SwipeDirection? direction;
  final double deltaX;
  final double deltaY;
  final double currentX;
  final double currentY;
  const BouncerSquareSwipped({
    this.direction = SwipeDirection.none,
    required this.deltaX,
    required this.deltaY,
    required this.currentX,
    required this.currentY,
  });
}

enum HitWall {
  left,
  right,
  top,
  down,
}

class BouncerSquareHit extends BouncingSquareEvent {
  final HitWall reachingWall;
  final double breakPoint;
  const BouncerSquareHit({
    required this.reachingWall,
    required this.breakPoint,
  });
}

class BouncerPlankResized extends BouncingSquareEvent {
  final double newWidth;
  final double newHeight;
  const BouncerPlankResized({
    required this.newWidth,
    required this.newHeight,
  });
}
