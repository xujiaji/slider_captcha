import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class CaptchaModel {
  final String? id;
  final String? puzzleImage;
  final String? pieceImage;
  final double? y;

  CaptchaModel({this.id, this.puzzleImage, this.pieceImage, this.y});

  factory CaptchaModel.fromJson(Map<String, dynamic> json) {
    String? id = '${json['id']}';
    String? puzzleImage = json['bgImage'];
    String? pieceImage = json['slideImage'];
    int y = json['y'];

    Image image = _getImage(puzzleImage);

    return CaptchaModel(
        id: id,
        puzzleImage: puzzleImage,
        pieceImage: pieceImage,
        y: y.toDouble());
  }

  static Image _getImage(String? puzzleImage) {
    Uint8List bytes = const Base64Decoder().convert(puzzleImage ?? '');
    return Image.memory(bytes);
  }
}
