import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class StripePaymentHandle {
  Map<String, dynamic>? paymentIntent;

  Future<void> stripeMakePayment(
      {required String buyerMail,
      required String buyerPhone,
      required List<String> address, required double price}) async {
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
            ),
          )
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (e) {
      xLog.e(e.toString());
      XToast.show(e.toString());
    }
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      XToast.show('Payment succesfully completed');
    } on Exception catch (e) {
      if (e is StripeException) {
        XToast.error('Error from Stripe: ${e.error.localizedMessage}');
      } else {
        XToast.show('Unforeseen error: $e');
      }
    }
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
      xLog.e(json.decode(response.body));
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
}
