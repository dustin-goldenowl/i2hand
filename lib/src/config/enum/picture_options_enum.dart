import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';

enum PictureOptionsEnum {
  choosePhoto,
  takePhoto,
  removePhoto;

  String getText(BuildContext context) {
    switch (this) {
      case PictureOptionsEnum.choosePhoto:
        return S.of(context).choosePhoto;
      case PictureOptionsEnum.takePhoto:
        return S.of(context).takePhoto;
      case PictureOptionsEnum.removePhoto:
        return S.of(context).removePhoto;
    }
  }
}

enum VideoOptionsEnum {
  chooseVideo,
  recordVideo;

  String getText(BuildContext context) {
    switch (this) {
      case VideoOptionsEnum.chooseVideo:
        return S.of(context).chooseVideo;
      case VideoOptionsEnum.recordVideo:
        return S.of(context).recordVideo;
    }
  }
}
