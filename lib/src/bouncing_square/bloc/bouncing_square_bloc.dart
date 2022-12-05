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
    on<BouncerPlankResized>(_onResized);
  }

  void _onClicked(
      BouncerSquareClicked event, Emitter<BouncingSquareState> emit) async {
    final randomImage = await GetRandomImageUsecaseImpl(RandomImageRepository())
        .getRandomImage();
    emit(state.copyWith(currentImage: randomImage));
  }

  void _onSquareSwiped(
      BouncerSquareSwipped event, Emitter<BouncingSquareState> emit) {
    // final SwipeDirection direction;
    if (event.deltaX == 0) {
      if (event.deltaY > 0) {
        emit(
          state.copyWith(
            currentDirection: SwipeDirection.down,
            positionTopEnd: state.maxTop,
            positionTopStart: event.currentY,
            positionLeftStart: event.currentX,
            positionLeftEnd: event.currentX,
          ),
        );
      } else if (event.deltaY < 0) {
        emit(
          state.copyWith(
            currentDirection: SwipeDirection.up,
            positionTopEnd: 0,
            positionTopStart: event.currentY,
            positionLeftStart: event.currentX,
            positionLeftEnd: event.currentX,
          ),
        );
      } else {
        return;
      }
    } else if (event.deltaY == 0) {
      if (event.deltaX > 0) {
        emit(
          state.copyWith(
            currentDirection: SwipeDirection.right,
            positionTopEnd: event.currentY,
            positionTopStart: event.currentY,
            positionLeftStart: event.currentX,
            positionLeftEnd: state.maxLeft,
          ),
        );
      } else if (event.deltaX < 0) {
        emit(
          state.copyWith(
            currentDirection: SwipeDirection.left,
            positionTopEnd: event.currentY,
            positionTopStart: event.currentY,
            positionLeftStart: event.currentX,
            positionLeftEnd: 0,
          ),
        );
      } else {
        return;
      }
    } else if (event.deltaY > 0) {
      if (event.deltaX < 0) {
        final endX = event.currentX -
            ((event.deltaX.abs() * (state.maxTop - event.currentY)) /
                event.deltaY);
        emit(
          state.copyWith(
            currentDirection: SwipeDirection.downLeft,
            positionTopEnd: state.maxTop,
            positionTopStart: event.currentY,
            positionLeftStart: event.currentX,
            positionLeftEnd: endX,
          ),
        );
      } else {
        final endX = ((event.deltaX.abs() * (state.maxTop - event.currentY)) /
                event.deltaY) +
            event.currentX;
        emit(
          state.copyWith(
            currentDirection: SwipeDirection.downRight,
            positionTopEnd: state.maxTop,
            positionTopStart: event.currentY,
            positionLeftStart: event.currentX,
            positionLeftEnd: endX,
          ),
        );
      }
    } else if (event.deltaY < 0) {
      if (event.deltaX > 0) {
        final endX =
            event.currentX - ((event.deltaX * event.currentY) / event.deltaY);
        emit(
          state.copyWith(
            currentDirection: SwipeDirection.upRight,
            positionTopEnd: 0,
            positionTopStart: event.currentY,
            positionLeftStart: event.currentX,
            positionLeftEnd: endX,
          ),
        );
      } else {
        final endX = ((event.deltaX.abs() * event.currentY) / event.deltaY) +
            event.currentX;
        emit(
          state.copyWith(
            currentDirection: SwipeDirection.upLeft,
            positionTopEnd: 0,
            positionTopStart: event.currentY,
            positionLeftStart: event.currentX,
            positionLeftEnd: -endX,
          ),
        );
      }
    }
  }

  void _onHitTheWall(
      BouncerSquareHit event, Emitter<BouncingSquareState> emit) {
    switch (event.reachingWall) {
      case HitWall.left:
        {
          if (state.currentDirection == SwipeDirection.upLeft) {
            emit(
              state.copyWith(
                currentDirection: SwipeDirection.upRight,
                positionTopStart: event.breakPoint,
                positionTopEnd: event.breakPoint +
                    (state.positionTopEnd - state.positionTopStart),
                positionLeftEnd: state.maxLeft,
                positionLeftStart: 0,
              ),
            );
          } else if (state.currentDirection == SwipeDirection.downLeft) {
            emit(
              state.copyWith(
                currentDirection: SwipeDirection.downRight,
                positionTopStart: event.breakPoint,
                positionTopEnd: event.breakPoint +
                    (state.positionTopEnd - state.positionTopStart),
                positionLeftEnd: state.maxLeft,
                positionLeftStart: 0,
              ),
            );
          } else {
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
        }
        break;
      case HitWall.down:
        if (state.currentDirection == SwipeDirection.downLeft) {
          emit(
            state.copyWith(
              currentDirection: SwipeDirection.upLeft,
              positionTopStart: state.maxTop,
              positionTopEnd: 0,
              positionLeftEnd: event.breakPoint +
                  (state.positionLeftEnd - state.positionLeftStart),
              positionLeftStart: event.breakPoint,
            ),
          );
        } else if (state.currentDirection == SwipeDirection.downRight) {
          emit(
            state.copyWith(
              currentDirection: SwipeDirection.upRight,
              positionTopStart: state.maxTop,
              positionTopEnd: 0,
              positionLeftEnd: event.breakPoint +
                  (state.positionLeftEnd - state.positionLeftStart),
              positionLeftStart: event.breakPoint,
            ),
          );
        } else {
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
      case HitWall.right:
        if (state.currentDirection == SwipeDirection.downRight) {
          emit(
            state.copyWith(
              currentDirection: SwipeDirection.downLeft,
              positionTopStart: event.breakPoint,
              positionTopEnd: event.breakPoint +
                  (state.positionTopEnd - state.positionTopStart),
              positionLeftEnd: 0,
              positionLeftStart: state.maxLeft,
            ),
          );
        } else if (state.currentDirection == SwipeDirection.upRight) {
          emit(
            state.copyWith(
              currentDirection: SwipeDirection.upLeft,
              positionTopStart: event.breakPoint,
              positionTopEnd: event.breakPoint +
                  (state.positionTopEnd - state.positionTopStart),
              positionLeftEnd: 0,
              positionLeftStart: state.maxLeft,
            ),
          );
        } else {
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
      case HitWall.top:
        if (state.currentDirection == SwipeDirection.upLeft) {
          emit(
            state.copyWith(
              currentDirection: SwipeDirection.downLeft,
              positionTopStart: 0,
              positionTopEnd: state.maxTop,
              positionLeftEnd: event.breakPoint +
                  (state.positionLeftEnd - state.positionLeftStart),
              positionLeftStart: event.breakPoint,
            ),
          );
        } else if (state.currentDirection == SwipeDirection.upRight) {
          emit(
            state.copyWith(
              currentDirection: SwipeDirection.downRight,
              positionTopStart: 0,
              positionTopEnd: state.maxTop,
              positionLeftEnd: event.breakPoint +
                  (state.positionLeftEnd - state.positionLeftStart),
              positionLeftStart: event.breakPoint,
            ),
          );
        } else {
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

  void _onResized(
      BouncerPlankResized event, Emitter<BouncingSquareState> emit) {
    emit(state.copyWith(
      pageHeight: event.newHeight,
      pageWidth: event.newWidth,
      currentDirection: SwipeDirection.none,
      positionLeftEnd: (event.newWidth / 2) - (state.squareWidth / 2),
      positionLeftStart: (event.newWidth / 2) - (state.squareWidth / 2),
      positionTopEnd: (event.newHeight / 2) - (state.squareWidth / 2),
      positionTopStart: (event.newHeight / 2) - (state.squareWidth / 2),
    ));
  }
}
