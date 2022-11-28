import 'package:equatable/equatable.dart';

class ImageDto extends Equatable {
  const ImageDto({required this.path});

  final String path;

  @override
  List<Object> get props => [path];

  @override
  bool get stringify => true;
}
