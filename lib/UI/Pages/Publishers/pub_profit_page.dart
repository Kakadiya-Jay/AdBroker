// ignore_for_file: use_build_context_synchronously

import 'package:ad_brokers/Models/transaction_model.dart';
import 'package:ad_brokers/Services/payment_service.dart';
import 'package:ad_brokers/Services/wallet_service.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfitPage extends StatefulWidget {
  const ProfitPage({super.key});

  @override
  State<ProfitPage> createState() => _ProfitPageState();
}

class _ProfitPageState extends State<ProfitPage> {
  final formkey = GlobalKey<FormState>();
  final walletService = WalletService();
  num currentBalance = 0;
  num totalRevenue = 0;
  bool isValidAmount = true;
  final withdrawalamount = TextEditingController();
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
      'description': "WithDraw",
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

  List<PubTransactionModel> totalTransactions = [];

  gettingTransactions() async {
    try {
      final platformResponse = await walletService.getAllPublishersTransactions(
          FirebaseAuth.instance.currentUser!.uid.toString());
      setState(() {
        totalTransactions = platformResponse!;
      });
    } catch (e) {
      debugPrint("Error :- ${e.toString()}");
    }
  }

  @override
  void initState() {
    isValidAmount = true;
    getCurrentBalance();
    getTotalRevenue();
    gettingTransactions();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentEror);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        elevation: 2.0,
        title: Text(
          "Profit",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                "/pub/frontPage",
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Current Balance",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "$currentBalance₹",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Card(
                  color: Theme.of(context).cardColor,
                  elevation: 4.0,
                  child: ListTile(
                    leading: Icon(
                      CupertinoIcons.money_dollar_circle,
                      color: Theme.of(context).shadowColor,
                    ),
                    title: Text(
                      "Total Revenue",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(
                      "$totalRevenue₹",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Theme.of(context).shadowColor,
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Withdraw earning to your account",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter Amount",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: withdrawalamount,
                  style: Theme.of(context).textTheme.displaySmall,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value != "") {
                      if (double.parse(value) <= currentBalance) {
                        setState(() {
                          isValidAmount = true;
                        });
                      } else {
                        setState(() {
                          isValidAmount = false;
                        });
                      }
                    }
                    return;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter amount";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Ex:- 100",
                    prefixIcon: Icon(
                      CupertinoIcons.money_dollar,
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                isValidAmount == false
                    ? const Text(
                        "Note:- You have not enough amount to Withdraw",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(""),
                const SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      var amount =
                          double.parse(withdrawalamount.text.toString());
                      if (amount < currentBalance) {
                        openCheckout(amount);
                      }
                    }
                  },
                  color: const Color(0xffFFE501),
                  child: const Text(
                    "Withdraw",
                    style: TextStyle(
                      color: Color(0xFF3C096C),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ).centered(),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Theme.of(context).shadowColor,
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Your All Withdrawals",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                totalTransactions.isEmpty
                    ? Center(
                        child: Image.asset(
                          "assets/images/No data-amico.png",
                          height: 330,
                          width: MediaQuery.of(context).size.width * 0.80,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                        ),
                      )
                    : ListView.builder(
                        itemCount: totalTransactions.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(
                              Icons.currency_rupee,
                              color: Theme.of(context).shadowColor,
                            ),
                            title: Text(
                              totalTransactions[index].type,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            subtitle: Text(
                              totalTransactions[index].createdDate.toString(),
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            trailing: Text(
                              "${totalTransactions[index].amount}₹",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: Colors.green),
                            ),
                          );
                        },
                      ),
              ],
            ).p8(),
          ),
        ).centered(),
      ),
    );
  }

  getCurrentBalance() async {
    await walletService
        .pubCurrentBalance(FirebaseAuth.instance.currentUser!.uid.toString())
        .then((value) {
      if (value != null) {
        setState(() {
          currentBalance = value;
        });
      } else {
        currentBalance = 0;
      }
    });
  }

  getTotalRevenue() async {
    await walletService
        .pubTotalRevenue(FirebaseAuth.instance.currentUser!.uid.toString())
        .then((value) {
      if (value != null) {
        setState(() {
          totalRevenue = value;
        });
      } else {
        totalRevenue = 0;
      }
    });
  }

  afterSuccessPaymentService() async {
    UiHelper.customSnackBar(context, "Wait a moment Don't Close your Screen..");
    await paymentService
        .makePublisherWithdrawal(
      FirebaseAuth.instance.currentUser!.uid.toString(),
      double.parse(withdrawalamount.text),
    )
        .then((value) async {
      if (value != null) {
        await UiHelper.customSuccessAlertBox(
          context,
          "${value['message']}\n\nTransaction id = ${value['transaction_id']}",
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/pub/frontPage",
          (route) => false,
        );
      } else {
        UiHelper.customErrorSnackBar(
          context,
          "Something went wrong",
        );
      }
    });
  }
}
