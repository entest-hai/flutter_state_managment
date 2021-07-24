// @dart = 2.10
/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';

class $AssetsDoctorsGen {
  const $AssetsDoctorsGen();

  AssetGenImage get bone => const AssetGenImage('assets/doctors/bone.png');
  AssetGenImage get brain => const AssetGenImage('assets/doctors/brain.png');
  AssetGenImage get dr1 => const AssetGenImage('assets/doctors/dr_1.png');
  AssetGenImage get dr2 => const AssetGenImage('assets/doctors/dr_2.png');
  AssetGenImage get dr3 => const AssetGenImage('assets/doctors/dr_3.png');
  AssetGenImage get heart => const AssetGenImage('assets/doctors/heart.png');
  AssetGenImage get profileImg =>
      const AssetGenImage('assets/doctors/profile_img.png');
  AssetGenImage get tooth => const AssetGenImage('assets/doctors/tooth.png');
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  String get chat => 'assets/icons/chat.svg';
  String get facebook => 'assets/icons/facebook.svg';
  String get googlePlus => 'assets/icons/google-plus.svg';
  String get login => 'assets/icons/login.svg';
  String get signup => 'assets/icons/signup.svg';
  String get twitter => 'assets/icons/twitter.svg';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  AssetGenImage get loginBottom =>
      const AssetGenImage('assets/images/login_bottom.png');
  AssetGenImage get mainBottom =>
      const AssetGenImage('assets/images/main_bottom.png');
  AssetGenImage get mainTop =>
      const AssetGenImage('assets/images/main_top.png');
  AssetGenImage get signupTop =>
      const AssetGenImage('assets/images/signup_top.png');
  AssetGenImage get tokyo => const AssetGenImage('assets/images/tokyo.jpeg');
  AssetGenImage get tokyo1 => const AssetGenImage('assets/images/tokyo1.jpeg');
  AssetGenImage get tokyo2 => const AssetGenImage('assets/images/tokyo2.jpeg');
  AssetGenImage get tokyo3 => const AssetGenImage('assets/images/tokyo3.jpeg');
  AssetGenImage get tokyo4 => const AssetGenImage('assets/images/tokyo4.jpeg');
}

class Assets {
  Assets._();

  static const AssetGenImage albert = AssetGenImage('assets/albert.png');
  static const AssetGenImage bgShape = AssetGenImage('assets/bg_shape.png');
  static const AssetGenImage cherly = AssetGenImage('assets/cherly.png');
  static const AssetGenImage clear = AssetGenImage('assets/clear.png');
  static const AssetGenImage cloudy = AssetGenImage('assets/cloudy.png');
  static const $AssetsDoctorsGen doctors = $AssetsDoctorsGen();
  static const String fheartrate = 'assets/fheartrate.txt';
  static const String heartrate = 'assets/heartrate.txt';
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const AssetGenImage mathew = AssetGenImage('assets/mathew.png');
  static const String mheartrate = 'assets/mheartrate.txt';
  static const String radio = 'assets/radio.json';
  static const AssetGenImage rainy = AssetGenImage('assets/rainy.png');
  static const AssetGenImage snow = AssetGenImage('assets/snow.png');
  static const AssetGenImage thunderstorm =
      AssetGenImage('assets/thunderstorm.png');
  static const AssetGenImage whale0 = AssetGenImage('assets/whale_0.jpg');
  static const AssetGenImage whale1 = AssetGenImage('assets/whale_1.jpg');
  static const AssetGenImage whale2 = AssetGenImage('assets/whale_2.jpg');
  static const AssetGenImage whale3 = AssetGenImage('assets/whale_3.jpg');
  static const AssetGenImage whale4 = AssetGenImage('assets/whale_4.jpg');
  static const AssetGenImage whale5 = AssetGenImage('assets/whale_5.jpg');
  static const AssetGenImage whale6 = AssetGenImage('assets/whale_6.jpg');
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName)
      : _assetName = assetName,
        super(assetName);
  final String _assetName;

  Image image({
    Key key,
    ImageFrameBuilder frameBuilder,
    ImageLoadingBuilder loadingBuilder,
    ImageErrorWidgetBuilder errorBuilder,
    String semanticLabel,
    bool excludeFromSemantics = false,
    double width,
    double height,
    Color color,
    BlendMode colorBlendMode,
    BoxFit fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => _assetName;
}
