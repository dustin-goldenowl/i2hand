import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/config/enum/attribute.dart';
import 'package:i2hand/src/feature/admin/home/logic/admin_home_bloc.dart';
import 'package:i2hand/src/feature/admin/home/logic/admin_home_state.dart';
import 'package:i2hand/src/feature/admin/home/widget/items/attribute_field.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/attribute/attribute.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/text_field/text_field.dart';
import 'package:dotted_border/dotted_border.dart';

class XCategoryAttributesBottomSheet extends StatefulWidget {
  const XCategoryAttributesBottomSheet(
      {Key? key, required this.isEdit, this.category})
      : super(key: key);
  final bool isEdit;
  final MCategory? category;

  @override
  State<XCategoryAttributesBottomSheet> createState() =>
      _XCategoryAttributesBottomSheetState();
}

class _XCategoryAttributesBottomSheetState
    extends State<XCategoryAttributesBottomSheet> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    if (widget.isEdit && !isNullOrEmpty(widget.category)) {
      context.read<AdminHomeBloc>().initial(widget.category!);
    }
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AdminHomeBloc>().getAllAttributes(context);
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyBoard(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.r30),
          topRight: Radius.circular(AppRadius.r30),
        ),
        child: Container(
          color: AppColors.white3,
          child: Stack(
            children: [
              _renderBackground(),
              Column(
                children: [
                  _renderAppBar(context),
                  Expanded(
                    child: _renderCreateBody(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderBackground() {
    return Positioned(
        right: 0,
        top: 0,
        child:
            Assets.svg.bubbles3.svg(fit: BoxFit.fitWidth, width: AppSize.s150));
  }

  Widget _renderAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => AppCoordinator.pop(),
          icon: const Icon(
            Icons.clear,
            size: AppSize.s20,
          ),
          splashRadius: 1,
        ),
        BlocSelector<AdminHomeBloc, AdminHomeState, AdminHomeStatus>(
          selector: (state) {
            return state.status;
          },
          builder: (context, resultState) {
            if (resultState == AdminHomeStatus.loading) {
              return _loadingIconSave();
            }
            return IconButton(
              onPressed: () {
                context.read<AdminHomeBloc>().onPressSaveButton(context);
              },
              icon: const Icon(
                Icons.check,
                size: AppSize.s20,
                color: AppColors.white,
              ),
              splashRadius: 1,
            );
          },
        ),
      ],
    );
  }

  Widget _loadingIconSave() {
    return const Padding(
      padding: EdgeInsets.all(AppPadding.p16),
      child: SizedBox(
        height: AppSize.s16,
        width: AppSize.s16,
        child: CircularProgressIndicator(
          color: AppColors.white,
          strokeWidth: AppSize.s2,
        ),
      ),
    );
  }

  Widget _renderCreateBody(BuildContext context) {
    return BlocBuilder<AdminHomeBloc, AdminHomeState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.listAttributes, current.listAttributes) ||
          !listEquals(previous.listAllAttributes, current.listAllAttributes),
      builder: (context, state) {
        return state.listAttributes.isEmpty
            ? _renderEmptyAttributeScreen(context)
            : _renderListAttributes(
                context,
                listAttributes: state.listAttributes,
                listAllAttributes: state.listAllAttributes,
              );
      },
    );
  }

  Widget _renderEmptyAttributeScreen(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.svg.emptyAttributes.svg(
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width - AppSize.s48,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p45, vertical: AppPadding.p23),
          child: XFillButton(
            onPressed: () =>
                context.read<AdminHomeBloc>().createAttributes(context),
            label: Text(
              S.of(context).createAttributes,
              style: AppTextStyle.buttonTextStylePrimary,
            ),
          ),
        )
      ],
    );
  }

  Widget _renderListAttributes(BuildContext context,
      {required List<MAttribute> listAttributes,
      required List<DropdownMenuItem<AttributeEnum>> listAllAttributes}) {
    return ListView.builder(
      itemCount: listAttributes.length + 3,
      itemBuilder: (context, index) {
        if (index == 0) return _renderCategorysName(context);
        if (index == 1) return _renderImageField();
        if (index == listAttributes.length + 2) return _renderAddButtonIcon();
        return _renderAttributeItem(
            attribute: listAttributes[index - 2],
            listAllAttribute: listAllAttributes);
      },
      padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p2, horizontal: AppPadding.p16),
    );
  }

  Widget _renderAttributeItem(
      {required MAttribute attribute,
      required List<DropdownMenuItem<AttributeEnum>> listAllAttribute}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p12),
      child: XAttributeField(
        attribute: attribute.attribute,
        items: listAllAttribute,
        isRequired: attribute.isRequired,
        onChangedAttribute: (newAttribute) {
          context.read<AdminHomeBloc>().onChangedAttributes(
                context,
                oldAttribute: attribute.attribute,
                attribute: newAttribute,
              );
        },
        onDeleteAttribute: (attribute) {
          context.read<AdminHomeBloc>().onDeteledAttribute(
                context,
                attribute: attribute,
              );
        },
        onChangedAttributeRequired: (isRequired) => context
            .read<AdminHomeBloc>()
            .onChangedAttributeRequired(
                isRequired: isRequired, attribute: attribute.attribute),
      ),
    );
  }

  Widget _renderAddButtonIcon() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        bottom: AppPadding.p23,
        left: AppPadding.p16,
        right: AppPadding.p16,
      ),
      child: IconButton(
        onPressed: () =>
            context.read<AdminHomeBloc>().createAttributes(context),
        icon: const Icon(Icons.add),
        color: AppColors.primary,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            AppColors.backgroundButton,
          ),
        ),
      ),
    );
  }

  Widget _renderCategorysName(BuildContext context) {
    return BlocBuilder<AdminHomeBloc, AdminHomeState>(
      buildWhen: (pre, cur) =>
          pre.name != cur.name || pre.nameError != cur.nameError,
      builder: (context, state) {
        return XTextField(
            hintText: S.of(context).name,
            initText: widget.isEdit ? state.name : null,
            errorText: StringUtils.isNullOrEmpty(state.nameError)
                ? null
                : state.nameError,
            isEnable: !widget.isEdit,
            cursorColor: AppColors.primary,
            onChanged: (name) =>
                context.read<AdminHomeBloc>().onChangedCategorysName(name));
      },
    );
  }

  Widget _renderImageField() {
    return BlocBuilder<AdminHomeBloc, AdminHomeState>(
      buildWhen: (previous, current) =>
          previous.categoryImage != current.categoryImage ||
          previous.isImageError != current.isImageError,
      builder: (context, state) {
        return (state.categoryImage == null ||
                state.categoryImage == Uint8List(0))
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p45, vertical: AppPadding.p12),
                child: DottedBorder(
                  color: state.isImageError == true
                      ? AppColors.errorColor
                      : AppColors.black2,
                  padding: const EdgeInsets.all(AppPadding.p15),
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(AppRadius.r10),
                  child: Center(
                    child: IconButton(
                        onPressed: () => context
                            .read<AdminHomeBloc>()
                            .pickImagehandler(context, state.categoryImage),
                        icon: const Icon(
                          Icons.image,
                          size: AppSize.s48,
                        )),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p45, vertical: AppPadding.p12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.r10),
                  clipBehavior: Clip.hardEdge,
                  child: Image.memory(
                    state.categoryImage!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
      },
    );
  }
}
