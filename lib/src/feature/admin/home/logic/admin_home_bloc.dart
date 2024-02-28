import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/config/enum/attribute.dart';
import 'package:i2hand/src/config/enum/options.dart';
import 'package:i2hand/src/config/enum/picture_options_enum.dart';
import 'package:i2hand/src/feature/admin/home/logic/admin_home_state.dart';
import 'package:i2hand/src/feature/admin/home/widget/admin_edit_category_bts.dart';
import 'package:i2hand/src/feature/global/logic/global_bloc.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/category/category_repository.dart';
import 'package:i2hand/src/network/model/attribute/attribute.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/bottomsheet/image_picker_bottom_sheet.dart';
import 'package:i2hand/widget/bottomsheet/modal_bottomsheet.dart';
import 'package:i2hand/widget/image/pick_image_app.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AdminHomeBloc extends Cubit<AdminHomeState> {
  AdminHomeBloc()
      : super(AdminHomeState(
          listAttributes: List.empty(growable: true),
          listCategories: List.empty(growable: true),
          listAllAttributes: List.empty(growable: true),
        ));

  void onTappedCategoryButton(BuildContext context,
      {required MCategory category}) {
    showCupertinoModalBottomSheet(
      duration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeOut,
      context: context,
      builder: (context) => XOptionsBottomSheet(
        listOptions: AppConstantData.categorysOptions,
      ),
      barrierColor: Colors.transparent.withOpacity(0.5),
      enableDrag: false,
    ).then((valueCallback) {
      if (isNullOrEmpty(valueCallback) ||
          valueCallback.runtimeType != OptionsEnum) return;
      _onChangedCategory(context, option: valueCallback, category: category);
    });
  }

  void _onChangedCategory(BuildContext context,
      {required OptionsEnum option, required MCategory category}) {
    switch (option) {
      case OptionsEnum.edit:
        break;
      case OptionsEnum.remove:
        _removeCategory(context, category);
        break;
      default:
        break;
    }
  }

  Future<void> _removeCategory(BuildContext context, MCategory category) async {
    try {
      emit(state.copyWith(status: AdminHomeStatus.loading));
      final result =
          await GetIt.I.get<CategoryRepository>().deleteCategory(category);
      if (result.data == true) {
        final listCategories = state.listCategories;
        List<MCategory> newList = listCategories.take(100).toList();
        newList.removeWhere((element) => element.name == category.name);
        emit(state.copyWith(
          status: AdminHomeStatus.success,
          listCategories: newList,
        ));
        return;
      }
      emit(state.copyWith(status: AdminHomeStatus.fail));
    } catch (e) {
      emit(state.copyWith(status: AdminHomeStatus.fail));
      xLog.e(e);
    }
  }

  Future<void> showAttributesDetailBottomsheet(BuildContext context,
      {MCategory? category, bool isEdit = false}) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocProvider(
              create: (context) => AdminHomeBloc(),
              child: XCategoryAttributesBottomSheet(
                  isEdit: isEdit, category: category),
            )),
      ),
      isScrollControlled: true,
      barrierColor: AppColors.black.withOpacity(0.6),
      enableDrag: true,
      isDismissible: false,
    ).then((value) {
      if (value != null) {
        _updateListCategory(context, category: value);
      }
    });
  }

  void _updateListCategory(BuildContext context,
      {required MCategory category}) {
    try {
      emit(state.copyWith(status: AdminHomeStatus.loading));
      final listCategories = state.listCategories;
      List<MCategory> newList = listCategories.take(100).toList();
      newList.add(category);
      emit(state.copyWith(
        status: AdminHomeStatus.success,
        listCategories: newList,
      ));
      context.read<GlobalBloc>().updateListCategories(newList);
    } catch (e) {
      emit(state.copyWith(status: AdminHomeStatus.fail));
      xLog.e(e);
    }
  }

  void initial(MCategory category) {
    _initCategoryName(category);
    _initCategoryImage(category);
    _initCategoryAttributes(category);
  }

  void _initCategoryName(MCategory category) {
    emit(state.copyWith(name: category.name.capitalize()));
  }

  void _initCategoryImage(MCategory category) {
    emit(state.copyWith(
        categoryImage: (category.image ?? []).convertToUint8List()));
  }

  void _initCategoryAttributes(MCategory category) {
    List<MAttribute> listAttributes = [];
    for (String attribute in category.attributes) {
      listAttributes.add(
        MAttribute(attribute: AttributeEnum.getAttributeEnum(attribute)),
      );
    }
    emit(state.copyWith(listAttributes: listAttributes));
  }

  Future<void> onPressSaveButton(BuildContext context) async {
    if (state.status == AdminHomeStatus.loading) return;
    if (_checkInvalidInput()) return;
    emit(state.copyWith(status: AdminHomeStatus.loading));
    MCategory category = _createCategory(context);
    try {
      final result =
          await GetIt.I.get<CategoryRepository>().getOrAddCategory(category);
      if (isNullOrEmpty(result.data)) {
        emit(state.copyWith(status: AdminHomeStatus.fail));
        return;
      }
      await _updateImage();
      emit(state.copyWith(status: AdminHomeStatus.success));
      AppCoordinator.pop(category);
    } catch (e) {
      xLog.e(e);
      emit(state.copyWith(status: AdminHomeStatus.fail));
    }
  }

  bool _checkInvalidInput() {
    final nameError = StringUtils.isNullOrEmpty(state.name);
    final imageError = isNullOrEmpty(state.categoryImage) ||
        state.categoryImage == Uint8List(0);
    emit(state.copyWith(
      nameError: nameError ? S.text.thisFieldIsNotEmpty : '',
      isImageError: imageError,
    ));
    return nameError || imageError;
  }

  MCategory _createCategory(BuildContext context) {
    final bytes = state.categoryImage!.map((e) => e.toString()).toList();
    return MCategory(
        name: state.name.toLowerCase(),
        image: bytes,
        attributes: state.listAttributes
            .map((e) => e.attribute.getAttributeText(context).toLowerCase())
            .toList());
  }

  Future<void> _updateImage() async {
    try {
      await GetIt.I
          .get<CategoryRepository>()
          .addImage(state.name.toLowerCase(), state.categoryImage!);
    } catch (e) {
      rethrow;
    }
  }

  void createAttributes(BuildContext context) {
    final List<MAttribute> listAttributes = state.listAttributes;
    List<MAttribute> listAdd = listAttributes.take(100).toList();
    final newAttribute = _getNewAttribute();
    if (isNullOrEmpty(newAttribute)) return;
    listAdd.add(newAttribute!);
    emit(state.copyWith(listAttributes: listAdd));
    _updateListAllAttributes(context);
  }

  MAttribute? _getNewAttribute() {
    if (state.listAttributes.isEmpty) {
      return MAttribute(attribute: AttributeEnum.status);
    }
    for (int index = 0; index < state.listAllAttributes.length; index++) {
      bool isExist = false;
      for (MAttribute attribute in state.listAttributes) {
        if (state.listAllAttributes[index].value == attribute.attribute) {
          isExist = true;
        }
      }
      if (!isExist) {
        return MAttribute(
            attribute:
                state.listAllAttributes[index].value ?? AttributeEnum.status);
      }
    }
    return null;
  }

  void onChangedAttributes(BuildContext context,
      {required AttributeEnum oldAttribute, AttributeEnum? attribute}) {
    if (isNullOrEmpty(attribute)) return;
    final List<MAttribute> listAttributes = state.listAttributes;
    List<MAttribute> listAdd = listAttributes.take(100).toList();
    final index = _getAttributeIndex(oldAttribute);
    listAdd.replaceRange(index, index + 1, [MAttribute(attribute: attribute!)]);
    emit(state.copyWith(listAttributes: listAdd));
    _updateListAllAttributes(context);
  }

  void onChangedAttributeRequired(
      {required bool isRequired, required AttributeEnum attribute}) {
    final List<MAttribute> listAttributes = state.listAttributes;
    List<MAttribute> listAdd = listAttributes.take(100).toList();
    final index = _getAttributeIndex(attribute);
    listAdd.replaceRange(index, index + 1,
        [MAttribute(attribute: attribute, isRequired: isRequired)]);
    emit(state.copyWith(listAttributes: listAdd));
  }

  int _getAttributeIndex(AttributeEnum attribute) {
    return state.listAttributes
        .indexWhere((element) => element.attribute == attribute);
  }

  void initListCategories(BuildContext context) {
    emit(state.copyWith(
      listCategories: context.read<GlobalBloc>().state.listCategories,
    ));
  }

  void onChangedCategorysName(String name) {
    emit(state.copyWith(name: name, nameError: ''));
  }

  void getAllAttributes(BuildContext context) {
    final allAttributes = AppConstantData.getAllDropdownAttributes(context);
    emit(
      state.copyWith(
        listAllAttributes: allAttributes,
      ),
    );
  }

  void _updateListAllAttributes(BuildContext context) {
    final listAllAttributes = AppConstantData.getAllDropdownAttributes(context);
    List<DropdownMenuItem<AttributeEnum>> listAfterChange =
        listAllAttributes.take(100).toList();
    final listSelectedAttributes = state.listAttributes;
    for (MAttribute attribute in listSelectedAttributes) {
      int index = _getAttributeEnumIndex(attribute.attribute);
      listAfterChange.replaceRange(index, index + 1, [
        DropdownMenuItem<AttributeEnum>(
          value: attribute.attribute,
          enabled: false,
          child: Text(attribute.attribute.getAttributeText(context),
              style: AppTextStyle.contentTexStyleBold,
              overflow: TextOverflow.ellipsis),
        )
      ]);
    }
    emit(state.copyWith(listAllAttributes: listAfterChange));
  }

  int _getAttributeEnumIndex(AttributeEnum attribute) {
    return state.listAllAttributes
        .indexWhere((element) => element.value == attribute);
  }

  void pickImagehandler(BuildContext context, Uint8List? avatar) {
    showCupertinoModalBottomSheet(
        duration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeOut,
        barrierColor: AppColors.black.withOpacity(0.5),
        context: context,
        builder: (_) => XImagePickerBottomSheet(
            isPhotoExisted: !isNullOrEmpty(avatar),
            onSelectedValue: (value) async {
              AppCoordinator.pop();
              switch (value as PictureOptionsEnum) {
                case PictureOptionsEnum.takePhoto:
                  try {
                    final image = await PickerImageApp.show(ImageSource.camera);
                    if (image != null) {
                      if (!context.mounted) return;
                      _setCategoryImage(bytes: image.bytes);
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
                      _setCategoryImage(bytes: image.bytes);
                    }
                  } catch (error) {
                    xLog.e("pickImagehandler $error");
                  }
                  break;
                case PictureOptionsEnum.removePhoto:
                  try {
                    _setCategoryImage(bytes: Uint8List(0));
                  } catch (error) {
                    xLog.e("pickImagehandler $error");
                  }
                  break;
              }
            }));
  }

  void _setCategoryImage({required Uint8List bytes}) {
    emit(state.copyWith(categoryImage: bytes));
  }

  void onDeteledAttribute(BuildContext context,
      {required AttributeEnum attribute}) {
    if (isNullOrEmpty(attribute)) return;
    final List<MAttribute> listAttributes = state.listAttributes;
    List<MAttribute> listAdd = listAttributes.take(100).toList();
    listAdd.removeWhere((element) => element.attribute == attribute);
    emit(state.copyWith(listAttributes: listAdd));
    _updateListAllAttributes(context);
  }
}
