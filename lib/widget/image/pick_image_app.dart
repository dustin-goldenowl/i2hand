import 'package:i2hand/src/network/model/common/image_section.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickerImageApp {
  static Future<ImageSelection?> show(ImageSource source) async {
    final imagePicker = ImagePicker();
    final XFile? xFile = await imagePicker.pickImage(source: source);
    final cropImage = await ImageCropper().cropImage(
      sourcePath: xFile?.path ?? "",
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      cropStyle: CropStyle.circle,
    );
    final type = (xFile?.name ?? '.').split('.').last;
    final bytes = await cropImage?.readAsBytes();
    return ImageSelection(
        name: xFile?.name ?? "",
        type: type,
        bytes: bytes!,
        path: cropImage!.path);
  }
}
