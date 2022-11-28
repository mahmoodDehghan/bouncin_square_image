import 'package:bouncing_square_image/src/bouncing_square/domain/model/bounce_image_model.dart';

abstract class GetRandomImageUsecase {
  Future<BounceImageModel> getRandomImage();
}
