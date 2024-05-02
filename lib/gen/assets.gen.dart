import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';


class $AssetsIconsGen {
  const $AssetsIconsGen();

  // ======== Background images ======== //

  /// File path: assets/images/background/background-01.jpeg
  ImageGen get tempBg01 => const ImageGen('assets/images/background/background-01.jpeg');

  /// File path: assets/images/background/background-02.jpeg
  ImageGen get tempBg02 => const ImageGen('assets/images/background/background-02.jpeg');

  /// File path: assets/images/background/jiwon.jpeg
  ImageGen get tempBgJiwon => const ImageGen('assets/images/background/jiwon.jpeg');


  // ======== Icons ======== //

  /// File path: assets/images/icon/heart.png
  ImageGen get blackHeart => const ImageGen('assets/images/icon/heart.png');

  /// List of all assets
  List<ImageGen> get values => [
      tempBg01
    , tempBg02
    , tempBgJiwon
    , blackHeart
  ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class ImageGen {
  const ImageGen(this._assetName);

  final String _assetName;

  Widget image({
      Key? key
    , bool matchTextDirection = false
    , AssetBundle? bundle
    , String? package
    , double? width
    , double? height
    , BoxFit fit = BoxFit.contain
    , AlignmentGeometry alignment = Alignment.center
    , String? semanticsLabel
    , bool excludeFromSemantics = false
    , FilterQuality filterQuality = FilterQuality.high, // Added to control the quality of image scaling.
  }) {
    return Image.asset(
        _assetName
      , key: key
      , matchTextDirection: matchTextDirection
      , bundle: bundle
      , package: package
      , width: width
      , height: height
      , fit: fit
      , alignment: alignment
      , semanticLabel: semanticsLabel
      , excludeFromSemantics: excludeFromSemantics
      , filterQuality: filterQuality,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}