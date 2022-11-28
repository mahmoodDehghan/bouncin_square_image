part of 'bouncing_square_bloc.dart';

enum SwipeDirection { left, right, up, down, none }

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

class BouncerSquareHit extends BouncingSquareEvent {}
