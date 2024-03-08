import 'package:flutter/material.dart';
import 'package:i2hand/src/network/model/attribute/attribute_model.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/separate/dash_separate.dart';

class XSelectPage extends StatefulWidget {
  final ValueChanged<String> onChangedValue;
  final String? currentValue;
  final MAttribute attribute;

  const XSelectPage({
    Key? key,
    required this.onChangedValue,
    this.currentValue,
    required this.attribute,
  }) : super(key: key);

  @override
  State<XSelectPage> createState() => _XSelectPageState();
}

class _XSelectPageState extends State<XSelectPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _renderAppBar(context),
        body: _renderBody(context),
      ),
    );
  }

  AppBar _renderAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        widget.attribute.name.getAttributeText(context),
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
                child: isNullOrEmpty(widget.attribute.data)
                    ? const SizedBox.shrink()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.attribute.data!.length,
                        itemBuilder: (_, index) {
                          return _renderAttributeData(
                              widget.attribute.data![index]);
                        },
                      )))
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
                    style: AppTextStyle.contentTexStyle,
                  ),
                ),
                const Icon(
                  Icons.check,
                  color: AppColors.green,
                )
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
