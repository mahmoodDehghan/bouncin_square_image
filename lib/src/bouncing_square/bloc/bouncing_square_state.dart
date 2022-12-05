part of 'bouncing_square_bloc.dart';

class BouncingSquareState extends Equatable {
  const BouncingSquareState({
    this.currentImage = const BounceImageModel(
      imagePath: ImagePaths.image1,
    ),
    this.currentDirection = SwipeDirection.none,
    required this.pageWidth,
    required this.pageHeight,
    double? positionLeftStart,
    double? positionTopStart,
    double? positionLeftEnd,
    double? positionTopEnd,
    required this.squareWidth,
  })  : positionLeftStart =
            positionLeftStart ?? (pageWidth / 2) - (squareWidth / 2),
        positionLeftEnd =
            positionLeftEnd ?? (pageWidth / 2) - (squareWidth / 2),
        positionTopStart =
            positionTopStart ?? (pageHeight / 2) - (squareWidth / 2),
        positionTopEnd = positionTopEnd ?? (pageHeight / 2) - (squareWidth / 2),
        maxLeft = pageWidth - squareWidth,
        maxTop = pageHeight - squareWidth;

  final BounceImageModel currentImage;
  final SwipeDirection currentDirection;
  final double positionLeftStart;
  final double positionLeftEnd;
  final double positionTopStart;
  final double positionTopEnd;
  final double pageWidth;
  final double pageHeight;
  final double squareWidth;
  final double maxLeft;
  final double maxTop;

  BouncingSquareState copyWith({
    BounceImageModel? currentImage,
    SwipeDirection? currentDirection,
    // double? currentDistance,
    double? positionLeftStart,
    double? positionLeftEnd,
    double? positionTopEnd,
    double? positionTopStart,
    double? pageWidth,
    double? pageHeight,
  }) {
    return BouncingSquareState(
      currentDirection: currentDirection ?? this.currentDirection,
      currentImage: currentImage ?? this.currentImage,
      // currentDistance: currentDistance ?? this.currentDistance,
      squareWidth: squareWidth,
      pageWidth: pageWidth ?? this.pageWidth,
      pageHeight: pageHeight ?? this.pageHeight,
      positionTopStart: positionTopStart ?? this.positionTopStart,
      positionTopEnd: positionTopEnd ?? this.positionTopEnd,
      positionLeftEnd: positionLeftEnd ?? this.positionLeftEnd,
      positionLeftStart: positionLeftStart ?? this.positionLeftStart,
    );
  }

  @override
  List<Object> get props => [
        currentImage,
        currentDirection,
        positionLeftEnd,
        positionLeftStart,
        positionTopEnd,
        positionTopStart,
        pageHeight,
        pageWidth,
      ];

  @override
  bool get stringify => true;
}
