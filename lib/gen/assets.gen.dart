/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/logo_text.png
  AssetGenImage get logoText =>
      const AssetGenImage('assets/icons/logo_text.png');
  AssetGenImage get bell => const AssetGenImage('assets/icons/bell.png');
  AssetGenImage get logo => const AssetGenImage('assets/icons/logo.png');
  AssetGenImage get google => const AssetGenImage('assets/icons/google.png');
  AssetGenImage get flash_card =>
      const AssetGenImage('assets/icons/flash_card.png');
  AssetGenImage get ielts_toeic =>
      const AssetGenImage('assets/icons/ielts_toeic.png');
  AssetGenImage get news => const AssetGenImage('assets/icons/news.png');
  AssetGenImage get topics => const AssetGenImage('assets/icons/topic.png');
  AssetGenImage get tag_save =>
      const AssetGenImage('assets/icons/tag_save.png');
  AssetGenImage get back_btn =>
      const AssetGenImage('assets/icons/back_btn.png');
  AssetGenImage get heart => const AssetGenImage('assets/icons/heart.png');
  AssetGenImage get heart_selected =>
      const AssetGenImage('assets/icons/heart_selected.png');
  AssetGenImage get start => const AssetGenImage('assets/icons/start.png');
  AssetGenImage get speaker => const AssetGenImage('assets/icons/speaker.png');

  /// List of all assets
  List<AssetGenImage> get values => [logoText, bell];
}

class Assets {
  Assets._();

  static const String dictionary = 'assets/dictionary.json';
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const String notification = 'assets/notification.wav';

  /// List of all assets
  static List<String> get values => [dictionary, notification];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
