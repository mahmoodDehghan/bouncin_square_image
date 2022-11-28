import 'package:bouncing_square_image/src/bouncing_square/bouncing_square.dart';
import 'package:injectable/injectable.dart';

@Named(BouncingSquareConsts.randRepImpl)
@Singleton(as: ImageRepository)
class RandomImageRepository extends ImageRepository {
  final ImagesDatasource datasource = ImagesDatasource();
  @override
  Future<BounceImageModel> getRandomImage() async {
    return ImageMapper().map(datasource.getRandomImage());
  }
}
