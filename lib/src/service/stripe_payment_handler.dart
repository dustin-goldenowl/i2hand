import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/config/enum/order_enum.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/network/data/payment_success/order_repository.dart';
import 'package:i2hand/src/network/data/user/user_repository.dart';
import 'package:i2hand/src/network/model/order/order.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class StripePaymentHandle {
  Map<String, dynamic>? paymentIntent;

  Future<void> stripeMakePayment({
    required String buyerMail,
    required String buyerPhone,
    required List<String> address,
    required double price,
    required String productId,
    double productPrice = 0.0,
  }) async {
    try {
      paymentIntent = await createPaymentIntent(price.toString(), 'USD');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              billingDetails: BillingDetails(
                name: 'Lance',
                email: buyerMail,
                phone: buyerPhone,
                address: Address(
                    city: address[2],
                    country: address[3],
                    line1: address.first,
                    line2: 'YOUR ADDRESS 2',
                    postalCode: 'YOUR PINCODE',
                    state: address[1]),
              ),
              //Gotten from payment intent
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.system,
              merchantDisplayName: 'Lance',
              billingDetailsCollectionConfiguration:
                  const BillingDetailsCollectionConfiguration(
                name: CollectionMode.always,
                phone: CollectionMode.always,
                email: CollectionMode.always,
              ),
              appearance: const PaymentSheetAppearance(
                primaryButton: PaymentSheetPrimaryButtonAppearance(
                  colors: PaymentSheetPrimaryButtonTheme(
                    light: PaymentSheetPrimaryButtonThemeColors(
                        background: AppColors.errorColor),
                  ),
                ),
              ),
            ),
          )
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(productId: productId, productPrice: productPrice);
    } catch (e) {
      xLog.e(e.toString());
      XToast.show(e.toString());
    }
  }

  void displayPaymentSheet(
      {required String productId, required double productPrice}) async {
    OrderStatusEnum status = OrderStatusEnum.succeeded;
    try {
      await Stripe.instance.presentPaymentSheet();

      XToast.show('Payment succesfully completed');
    } on Exception catch (e) {
      if (e is StripeException) {
        XToast.error('Error from Stripe: ${e.error.localizedMessage}');
        status = OrderStatusEnum.failed;
      } else {
        XToast.show('Unforeseen error: $e');
        status = OrderStatusEnum.failed;
      }
    }
    await _updateFirebase(
        productId: productId,
        productPrice: productPrice,
        paymentStatus: status);
  }

//create Payment
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//calculate Amount
  String calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount)) * 100;
    return calculatedAmount.toInt().toString();
  }

  Future<void> _updateFirebase(
      {required String productId,
      required double productPrice,
      required OrderStatusEnum paymentStatus}) async {
    await _updateBuyerFirebase(productId, paymentStatus);
    await _updateSellerFirebase(productPrice);
  }

  Future<void> _updateBuyerFirebase(
      String productId, OrderStatusEnum paymentStatus) async {
    await GetIt.I.get<OrderRepository>().getOrAddOrder(
          MOrder(
            id: StringUtils.createGenerateRandomOrderNumber(
                length: AppConstantData.orderNumberLength),
            productId: productId,
            createdOrderTime: DateTime.now().millisecondsSinceEpoch,
            status: paymentStatus,
          ),
        );
  }

  Future<void> _updateSellerFirebase(double productPrice) async {
    final user = SharedPrefs.I.getUser();
    final updateUser =
        user?.copyWith(moneyEarned: user.moneyEarned + productPrice);
    await SharedPrefs.I.setUser(updateUser);
    await GetIt.I.get<UserRepository>().upsertUser(updateUser ?? MUser.empty());
  }
}
