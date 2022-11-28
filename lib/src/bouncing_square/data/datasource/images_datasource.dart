import 'dart:math';

import 'package:bouncing_square_image/src/bouncing_square/bouncing_square.dart';

class ImagesDatasource {
  final imagesList = [
    ImagePaths.image1,
    ImagePaths.image2,
    ImagePaths.image3,
    ImagePaths.image4,
    ImagePaths.image5,
  ];

  ImageDto getRandomImage() {
    final choosenIndex = Random().nextInt(imagesList.length);
    return ImageDto(
      path: imagesList[choosenIndex],
    );
  }
}
