import 'package:bouncing_square_image/src/bouncing_square/bouncing_square.dart';

abstract class ImageRepository {
  Future<BounceImageModel> getRandomImage();
}
