// ignore_for_file: use_build_context_synchronously

import 'package:ad_brokers/Services/payment_service.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AdvPaymentService extends StatefulWidget {
  final String adId;
  final String advId;
  final String brandName;
  final String brandURL;
  final String adTitle;
  final String adImageUrl;
  final String adCategory;
  final String adType;
  final String subscriptionName;
  final num adPrice;
  final num noOfViews;
  const AdvPaymentService({
    super.key,
    required this.adId,
    required this.advId,
    required this.brandName,
    required this.brandURL,
    required this.adTitle,
    required this.adImageUrl,
    required this.adCategory,
    required this.adType,
    required this.subscriptionName,
    required this.adPrice,
    required this.noOfViews,
  });

  @override
  State<AdvPaymentService> createState() => _AdvPaymentServiceState();
}

class _AdvPaymentServiceState extends State<AdvPaymentService> {
  var razorpay = Razorpay();
  final paymentService = PaymentService();
  String paymentId = "";

  void openCheckout(amount) {
    amount = amount * 100;
    var option = {
      // "key": "rzp_test_1DP5mmOlF5G5ag",
      "key": "rzp_test_nG92pkaR93uqFE",
      // Above is my RazorPay Account Key.
      'amount': amount,
      'currency': "INR",
      'name': 'AdBrokers',
      'description': widget.adTitle,
      'prefill': {
        'contact': '1234567890',
        'email': 'test@example.com',
      },
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'external': {
        'wallets': [
          'paytm',
        ],
      }
    };
    try {
      razorpay.open(option);
    } catch (e) {
      debugPrint('Error : $e');
      UiHelper.customErrorSnackBar(context, e.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      paymentId = response.paymentId!.toString();
    });
    afterSuccessPaymentService();
  }

  void handlePaymentEror(PaymentFailureResponse response) {
    debugPrint('Payment Failed ${response.message!}');
    UiHelper.customFailureAlertBox(
        context, "Payment Failed \n\n${response.message!}");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet ${response.walletName!}');
    UiHelper.customSnackBar(context, 'External wallet ${response.walletName!}');
  }

  @override
  void initState() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentEror);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2.0,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        title: Text(
          "Payment Service",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(
              widget.brandName,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.adImageUrl,
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).shadowColor,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.adTitle,
              style: Theme.of(context).textTheme.displayMedium,
            ).centered(),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.brandURL,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ).centered(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      "Fields",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Data",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          "Category",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      DataCell(
                        Text(
                          widget.adCategory,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          "Type",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      DataCell(
                        Text(
                          widget.adType,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  DataRow(cells: [
                    DataCell(
                      Text(
                        "Plan Name",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    DataCell(
                      Text(
                        widget.subscriptionName,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(
                      Text(
                        "Plan Price",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    DataCell(
                      Text(
                        widget.adPrice.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(
                      Text(
                        "Plan Price",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    DataCell(
                      Text(
                        widget.noOfViews.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Make Payment",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            CupertinoButton(
              onPressed: () {
                openCheckout(widget.adPrice);
              },
              color: const Color(0xffFFE501),
              child: const Text(
                "Confirm & Process",
                style: TextStyle(
                  color: Color(0xFF3C096C),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ).centered().p8(),
      ),
    );
  }

  afterSuccessPaymentService() async {
    UiHelper.customSnackBar(context, "Wait a moment Don't Close your Screen..");
    await paymentService
        .makeAdvertisementsPayment(
      widget.adId,
      paymentId,
      widget.advId,
      widget.adPrice,
      widget.noOfViews,
    )
        .then((value) async {
      if (value == true) {
        await UiHelper.customSuccessAlertBox(
          context,
          "Your Ad successfully uploaded\n\nWe send ad request to the admin.\n\nYour ad will be live after admin's permission.",
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/adv/frontPage",
          (route) => false,
        );
      } else {
        UiHelper.customErrorSnackBar(
          context,
          value.toString(),
        );
      }
    });
  }
}
