import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:i2hand/src/config/enum/picture_options_enum.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/bottomsheet/image_picker_bottom_sheet.dart';
import 'package:i2hand/widget/image/pick_image_app.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ImageHandler {
  static void pickImagehandler(BuildContext context,
      {Uint8List? image, required Function(Uint8List) setImage}) {
    showCupertinoModalBottomSheet(
        duration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeOut,
        barrierColor: AppColors.black.withOpacity(0.5),
        context: context,
        builder: (_) => XImagePickerBottomSheet(
            isPhotoExisted: !isNullOrEmpty(image),
            onSelectedValue: (value) async {
              AppCoordinator.pop();
              switch (value as PictureOptionsEnum) {
                case PictureOptionsEnum.takePhoto:
                  try {
                    final image = await PickerImageApp.show(ImageSource.camera);
                    if (image != null) {
                      if (!context.mounted) return;
                      setImage(image.bytes);
                    }
                  } catch (error) {
                    xLog.e("pickImagehandler $error");
                  }
                  break;
                case PictureOptionsEnum.choosePhoto:
                  try {
                    final image =
                        await PickerImageApp.show(ImageSource.gallery);
                    if (image != null) {
                      if (!context.mounted) return;
                      setImage(image.bytes);
                    }
                  } catch (error) {
                    xLog.e("pickImagehandler $error");
                  }
                  break;
                case PictureOptionsEnum.removePhoto:
                  try {
                    setImage(Uint8List(0));
                  } catch (error) {
                    xLog.e("pickImagehandler $error");
                  }
                  break;
              }
            }));
  }
}
