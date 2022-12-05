import 'package:bouncing_square_image/src/bouncing_square/bloc/bouncing_square_bloc.dart';
import 'package:bouncing_square_image/src/bouncing_square/presentation/organizer/game_plank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatelessWidget {
  static const String routeName = '/';

  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<BouncingSquareBloc>(
        create: (context) => BouncingSquareBloc(
          pageHeight: pageSize.height,
          pageWidth: pageSize.width,
          squareSize: 150.0,
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            context.read<BouncingSquareBloc>().add(
                  BouncerPlankResized(
                    newWidth: constraints.maxWidth,
                    newHeight: constraints.maxHeight,
                  ),
                );
            return const GamePlot();
          },
        ),
      ),
      // const GamePlot()),
    );
  }
}
