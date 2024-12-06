import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class SliderCaptchaClientProvider {
  ///Data of the image after decode base64
  late Uint8List puzzleUnit8List;

  ///Data of the piece after decode base64
  late Uint8List pieceUnit8List;

  /// Actual size of the image
  late Size puzzleSize;

  ///Actual size of the piece
  late Size pieceSize;

  ///Image is cut 1 piece
  Image? puzzleImage;

  ///piece is cut from Image
  Image? pieceImage;

  ///The ratio of the image to the actual size of the screen.
  late double ratio;

  ///Init piece base64 type
  final String puzzleBase64;

  /// Init piece base64 type:
  final String pieceBase64;

  ///Y coordinate of the puzzle piece.
  double coordinatesY;

  /// Provides Image information from the original base64 data
  SliderCaptchaClientProvider({
    required this.puzzleBase64,
    required this.pieceBase64,
    required this.coordinatesY,
  }) {
    puzzleUnit8List = Base64Decoder().convert(puzzleBase64);
    pieceUnit8List = Base64Decoder().convert(pieceBase64);
  }

  ///This is the required function to be executed to initialize the values.
  Future<bool> init(double maxWidth) async {
    puzzleSize = await _getSize(puzzleUnit8List);
    pieceSize = await _getSize(pieceUnit8List);
    ratio = puzzleSize.width / maxWidth;

    puzzleImage = Image.memory(puzzleUnit8List, scale: ratio,);
    pieceImage = Image.memory(
      pieceUnit8List,
      scale: ratio,
    );
    coordinatesY = coordinatesY / ratio;
    return true;
  }

  /// Actual size of the image in pixels
  Future<Size> _getSize(Uint8List puzzleUnit8List) async {
    var image = await decodeImageFromList(puzzleUnit8List);
    return Size(image.width.toDouble(), image.height.toDouble());
  }

}
