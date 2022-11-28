import 'package:bouncing_square_image/src/bouncing_square/bouncing_square.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetRandomImageUsecase)
class GetRandomImageUsecaseImpl implements GetRandomImageUsecase {
  GetRandomImageUsecaseImpl(
      @Named(BouncingSquareConsts.randRepImpl) this.imageRepository);
  final ImageRepository imageRepository;

  @override
  Future<BounceImageModel> getRandomImage() async {
    return imageRepository.getRandomImage();
  }
}
