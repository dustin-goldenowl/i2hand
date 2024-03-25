import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';

class XPaymentMethodBottomsheet extends StatelessWidget {
  const XPaymentMethodBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.r12),
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            _renderAppBar(context),
            _renderListBankCardsSection(context),
          ],
        )),
      ),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      child: XAppBar(titlePage: S.of(context).paymentMethod),
    );
  }

  Widget _renderListBankCardsSection(BuildContext context) {
    return CreditCardWidget(
      cardNumber: S.of(context).sampleCardNumber,
      expiryDate: S.of(context).sampleCardValid,
      cardHolderName: S.of(context).sampleCardHolder,
      cvvCode: S.of(context).sampleCardCVV,
      showBackView: false, //true when you want to show cvv(back) view
      onCreditCardWidgetChange: (CreditCardBrand
          brand) {}, // Callback for anytime credit card brand is changed
    );
  }
}
