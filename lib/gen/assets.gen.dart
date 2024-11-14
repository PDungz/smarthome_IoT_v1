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

  /// File path: assets/icons/campaign_regular.svg
  String get campaignRegular => 'assets/icons/campaign_regular.svg';

  /// File path: assets/icons/close-solid.svg
  String get closeSolid => 'assets/icons/close-solid.svg';

  /// File path: assets/icons/door-regular.svg
  String get doorRegular => 'assets/icons/door-regular.svg';

  /// File path: assets/icons/droplet-solid.svg
  String get dropletSolid => 'assets/icons/droplet-solid.svg';

  /// File path: assets/icons/fan-regular.svg
  String get fanRegular => 'assets/icons/fan-regular.svg';

  /// File path: assets/icons/fire-solid.svg
  String get fireSolid => 'assets/icons/fire-solid.svg';

  /// File path: assets/icons/home_regular.svg
  String get homeRegular => 'assets/icons/home_regular.svg';

  /// File path: assets/icons/home_solid.svg
  String get homeSolid => 'assets/icons/home_solid.svg';

  /// File path: assets/icons/lightbulb-regular.svg
  String get lightbulbRegular => 'assets/icons/lightbulb-regular.svg';

  /// File path: assets/icons/notification_regular.svg
  String get notificationRegular => 'assets/icons/notification_regular.svg';

  /// File path: assets/icons/notification_solid.svg
  String get notificationSolid => 'assets/icons/notification_solid.svg';

  /// File path: assets/icons/plus-solid-round.svg
  String get plusSolidRound => 'assets/icons/plus-solid-round.svg';

  /// File path: assets/icons/plus-solid.svg
  String get plusSolid => 'assets/icons/plus-solid.svg';

  /// File path: assets/icons/plus_regular.svg
  String get plusRegular => 'assets/icons/plus_regular.svg';

  /// File path: assets/icons/right-from-bracket-solid.svg
  String get rightFromBracketSolid =>
      'assets/icons/right-from-bracket-solid.svg';

  /// File path: assets/icons/screwdriver-wrench-solid.svg
  String get screwdriverWrenchSolid =>
      'assets/icons/screwdriver-wrench-solid.svg';

  /// File path: assets/icons/search-solid.svg
  String get searchSolid => 'assets/icons/search-solid.svg';

  /// File path: assets/icons/temperature-solid.svg
  String get temperatureSolid => 'assets/icons/temperature-solid.svg';

  /// File path: assets/icons/trash-can-solid.svg
  String get trashCanSolid => 'assets/icons/trash-can-solid.svg';

  /// File path: assets/icons/warning_regular.svg
  String get warningRegular => 'assets/icons/warning_regular.svg';

  /// List of all assets
  List<String> get values => [
        campaignRegular,
        closeSolid,
        doorRegular,
        dropletSolid,
        fanRegular,
        fireSolid,
        homeRegular,
        homeSolid,
        lightbulbRegular,
        notificationRegular,
        notificationSolid,
        plusSolidRound,
        plusSolid,
        plusRegular,
        rightFromBracketSolid,
        screwdriverWrenchSolid,
        searchSolid,
        temperatureSolid,
        trashCanSolid,
        warningRegular
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Profile.png
  AssetGenImage get profile => const AssetGenImage('assets/images/Profile.png');

  /// File path: assets/images/bg_login.png
  AssetGenImage get bgLogin =>
      const AssetGenImage('assets/images/bg_login.png');

  /// File path: assets/images/bg_login1.png
  AssetGenImage get bgLogin1 =>
      const AssetGenImage('assets/images/bg_login1.png');

  /// File path: assets/images/sunAndSnow.png
  AssetGenImage get sunAndSnowPng =>
      const AssetGenImage('assets/images/sunAndSnow.png');

  /// File path: assets/images/sunAndSnow.svg
  String get sunAndSnowSvg => 'assets/images/sunAndSnow.svg';

  /// List of all assets
  List<dynamic> get values =>
      [profile, bgLogin, bgLogin1, sunAndSnowPng, sunAndSnowSvg];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/es.svg
  String get es => 'assets/svg/es.svg';

  /// File path: assets/svg/us-flag.svg
  String get usFlag => 'assets/svg/us-flag.svg';

  /// File path: assets/svg/vietnam-flag.svg
  String get vietnamFlag => 'assets/svg/vietnam-flag.svg';

  /// List of all assets
  List<String> get values => [es, usFlag, vietnamFlag];
}

class Assets {
  Assets._();

  static const String aEnv = '.env';
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
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
