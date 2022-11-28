import 'package:bouncing_square_image/src/bouncing_square/bouncing_square.dart';
import 'package:bouncing_square_image/src/bouncing_square/di/repository/random_image_repository.dart';
import 'package:bouncing_square_image/src/bouncing_square/di/usecase/get_random_image_usecase_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bouncing_square_events.dart';
part 'bouncing_square_state.dart';

class BouncingSquareBloc
    extends Bloc<BouncingSquareEvent, BouncingSquareState> {
  BouncingSquareBloc({
    required double pageWidth,
    required double pageHeight,
    required double squareSize,
    double? initLeft,
    double? initTop,
  }) : super(BouncingSquareState(
          pageWidth: pageWidth,
          pageHeight: pageHeight,
          squareWidth: squareSize,
          positionLeftStart: initLeft,
          positionLeftEnd: initLeft,
          positionTopStart: initTop,
          positionTopEnd: initTop,
        )) {
    on<BouncerSquareClicked>(_onClicked);
    on<BouncerSquareSwipped>(_onSquareSwiped);
    on<BouncerSquareHit>(_onHitTheWall);
  }

  void _onClicked(
      BouncerSquareClicked event, Emitter<BouncingSquareState> emit) async {
    final randomImage = await GetRandomImageUsecaseImpl(RandomImageRepository())
        .getRandomImage();
    emit(state.copyWith(currentImage: randomImage));
  }

  void _onSquareSwiped(
      BouncerSquareSwipped event, Emitter<BouncingSquareState> emit) {
    final SwipeDirection direction;

    if (event.deltaX.abs() >= event.deltaY.abs()) {
      if (event.deltaX >= 0) {
        direction = SwipeDirection.right;
        emit(
          state.copyWith(
            currentDirection: direction,
            positionTopEnd: event.currentY,
            positionTopStart: event.currentY,
            positionLeftStart: event.currentX,
            positionLeftEnd: state.maxLeft,
          ),
        );
      } else {
        direction = SwipeDirection.left;
        emit(
          state.copyWith(
            currentDirection: direction,
            positionLeftStart: event.currentX,
            positionLeftEnd: 0,
            positionTopEnd: event.currentY,
            positionTopStart: event.currentY,
          ),
        );
      }
    } else {
      if (event.deltaY >= 0) {
        direction = SwipeDirection.down;
        emit(
          state.copyWith(
            currentDirection: direction,
            positionLeftEnd: event.currentX,
            positionLeftStart: event.currentX,
            positionTopStart: event.currentY,
            positionTopEnd: state.maxTop,
          ),
        );
      } else {
        direction = SwipeDirection.up;
        emit(
          state.copyWith(
            currentDirection: direction,
            positionTopStart: event.currentY,
            positionTopEnd: 0,
            positionLeftEnd: event.currentX,
            positionLeftStart: event.currentX,
          ),
        );
      }
    }
  }

  void _onHitTheWall(
      BouncerSquareHit event, Emitter<BouncingSquareState> emit) {
    switch (state.currentDirection) {
      case SwipeDirection.down:
        {
          emit(
            state.copyWith(
              currentDirection: SwipeDirection.up,
              positionTopStart: state.maxTop,
              positionTopEnd: 0,
              positionLeftEnd: state.positionLeftEnd,
              positionLeftStart: state.positionLeftEnd,
            ),
          );
        }
        break;
      case SwipeDirection.left:
        {
          emit(
            state.copyWith(
              currentDirection: SwipeDirection.right,
              positionLeftStart: 0,
              positionLeftEnd: state.maxLeft,
              positionTopEnd: state.positionTopEnd,
              positionTopStart: state.positionTopEnd,
            ),
          );
        }
        break;
      case SwipeDirection.right:
        {
          emit(
            state.copyWith(
              currentDirection: SwipeDirection.left,
              positionLeftStart: state.maxLeft,
              positionLeftEnd: 0,
              positionTopEnd: state.positionTopEnd,
              positionTopStart: state.positionTopEnd,
            ),
          );
        }
        break;
      case SwipeDirection.up:
        {
          emit(
            state.copyWith(
              currentDirection: SwipeDirection.down,
              positionTopStart: 0,
              positionTopEnd: state.maxTop,
              positionLeftEnd: state.positionLeftEnd,
              positionLeftStart: state.positionLeftEnd,
            ),
          );
        }
        break;
      default:
        break;
    }
  }
}
