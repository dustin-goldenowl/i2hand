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
