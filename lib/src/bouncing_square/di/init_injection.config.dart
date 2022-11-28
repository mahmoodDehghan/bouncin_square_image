// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bouncing_square_image/src/bouncing_square/bouncing_square.dart'
    as _i3;
import 'package:bouncing_square_image/src/bouncing_square/di/repository/random_image_repository.dart'
    as _i4;
import 'package:bouncing_square_image/src/bouncing_square/di/usecase/get_random_image_usecase_impl.dart'
    as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.ImageRepository>(
    _i4.RandomImageRepository(),
    instanceName: 'RandomImagesRep',
  );
  gh.factory<_i3.GetRandomImageUsecase>(() => _i5.GetRandomImageUsecaseImpl(
      gh<_i3.ImageRepository>(instanceName: 'RandomImagesRep')));
  return getIt;
}
