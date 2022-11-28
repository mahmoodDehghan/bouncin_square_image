import 'package:bouncing_square_image/src/bouncing_square/bouncing_square.dart';

class ImageMapper implements Mapper<ImageDto, BounceImageModel> {
  @override
  BounceImageModel map(ImageDto input) {
    return BounceImageModel(imagePath: input.path);
  }
}
