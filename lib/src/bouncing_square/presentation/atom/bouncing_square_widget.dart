import 'package:bouncing_square_image/src/bouncing_square/bouncing_square.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BouncingSquareWidget extends StatelessWidget {
  const BouncingSquareWidget({
    super.key,
    required this.image,
    required this.squareSize,
  });

  final BounceImageModel image;
  final double squareSize;

  @override
  Widget build(BuildContext context) {
    const radius = 10.0;
    return Card(
      child: InkWell(
        onTap: () =>
            context.read<BouncingSquareBloc>().add(BouncerSquareClicked()),
        child: Container(
          width: squareSize,
          height: squareSize,
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(radius),
            ),
            child: CachedNetworkImage(
              imageUrl: image.imagePath,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) =>
                  const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
            ),
          ),
        ),
      ),
    );
  }
}
