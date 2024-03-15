import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/src/feature/global/logic/global_bloc.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/attribute/attribute_model.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/separate/dash_separate.dart';

class XSelectPage extends StatefulWidget {
  final String currentValue;
  final String attributeName;

  const XSelectPage({
    Key? key,
    required this.currentValue,
    required this.attributeName,
  }) : super(key: key);

  @override
  State<XSelectPage> createState() => _XSelectPageState();
}

class _XSelectPageState extends State<XSelectPage> {
  late List<String> _listValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.attributeName == S.of(context).categories
        ? _getListCategory()
        : _getListValue();
  }

  void _getListCategory() {
    final data = context.read<GlobalBloc>().state.listCategories;
    _listValue = data.map((e) => e.name).toList();
  }

  void _getListValue() {
    final data = context.read<GlobalBloc>().state.listAttributeData;
    _listValue = data
            .singleWhere(
              (e) =>
                  e.name.getAttributeText(context).toLowerCase() ==
                  widget.attributeName.toLowerCase(),
              orElse: () => MAttribute.empty(),
            )
            .data ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _renderAppBar(context),
        body: _renderBody(context),
      ),
    );
  }

  AppBar _renderAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        widget.attributeName.capitalizeEachText(),
        style: AppTextStyle.titleTextStyle,
      ),
      leading: IconButton(
          onPressed: () => AppCoordinator.pop(),
          icon: const Icon(Icons.arrow_back)),
    );
  }

  Widget _renderBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: isNullOrEmpty(_listValue)
                ? const SizedBox.shrink()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _listValue.length,
                    itemBuilder: (_, index) {
                      return _renderAttributeData(_listValue[index]);
                    },
                  ),
          ),
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p20),
      ],
    );
  }

  Widget _renderAttributeData(String attributeData) {
    return InkWell(
      onTap: () {
        AppCoordinator.pop(attributeData);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    attributeData,
                    style: AppTextStyle.contentTexStyle
                        .copyWith(color: AppColors.black2),
                  ),
                ),
                attributeData == widget.currentValue
                    ? const Icon(
                        Icons.check,
                        color: AppColors.green,
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
          const XDashSeparator(
            color: AppColors.divider,
          ),
        ],
      ),
    );
  }
}
