import 'package:equatable/equatable.dart';

class BounceImageModel extends Equatable {
  const BounceImageModel({
    required this.imagePath,
  });

  final String imagePath;

  @override
  List<Object> get props => [imagePath];

  @override
  bool get stringify => true;
}
