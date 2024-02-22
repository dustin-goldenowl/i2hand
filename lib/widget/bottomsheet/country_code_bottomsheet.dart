import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i2hand/src/feature/common/country_logic/search_dial_code_bloc.dart';
import 'package:i2hand/src/feature/common/country_logic/search_dial_code_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/widget/separate/dash_separate.dart';
import 'package:i2hand/widget/text_field/search_input.dart';

/// Creates a list of Countries with a search textfield.
class SearchDialCodeBottomSheet extends StatefulWidget {
  final ValueChanged<CountryCode> onCountrySelected;

  const SearchDialCodeBottomSheet({
    Key? key,
    required this.onCountrySelected,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  State<SearchDialCodeBottomSheet> createState() =>
      _SearchDialCodeBottomSheetState();
}

class _SearchDialCodeBottomSheetState extends State<SearchDialCodeBottomSheet> {
  @override
  void initState() {
    context.read<SearchDialCodeBloc>().initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => AppCoordinator.pop(),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: _renderBody(),
      ),
    );
  }

  Widget _renderBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: XSearchInput(
            onChanged: _onChangedSearchInput,
            placeHolder: S.of(context).searchCountry,
            onPressClearButton: () =>
                context.read<SearchDialCodeBloc>().clearSearchInput(),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: BlocSelector<SearchDialCodeBloc, SearchDialCodeState,
                List<CountryCode>?>(
              selector: (state) {
                return state.countryCodes;
              },
              builder: (context, countryCodes) {
                if (countryCodes?.isNotEmpty == true) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: countryCodes!.length,
                    itemBuilder: (_, index) {
                      return _renderCountryCell(countryCodes[index]);
                    },
                  );
                }
                return _renderNoResultsView();
              },
            ),
          ),
        ),
      ],
    );
  }

  void _onChangedSearchInput(String value) {
    context.read<SearchDialCodeBloc>().onChangedSearchInput(value);
  }

  Widget _renderCountryCell(CountryCode countryCodeDomain) {
    return InkWell(
      onTap: () {
        widget.onCountrySelected(countryCodeDomain);
        AppCoordinator.pop(countryCodeDomain);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Row(
              children: [
                StringUtils.isNullOrEmpty(countryCodeDomain.flag)
                    ? const SizedBox.shrink()
                    : SvgPicture.network(
                        countryCodeDomain.flag!,
                        width: AppSize.s24,
                      ),
                const SizedBox(width: AppMargin.m8),
                Expanded(
                  child: Text(
                    countryCodeDomain.name ?? '',
                    style: AppTextStyle.contentTexStyle,
                  ),
                ),
                Text(
                  countryCodeDomain.dial ?? '',
                  style: AppTextStyle.contentTexStyle,
                ),
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

  Widget _renderNoResultsView() {
    return Text(
      S.of(context).someThingWentWrong,
      style: AppTextStyle.hintTextStyle,
    );
  }
}
