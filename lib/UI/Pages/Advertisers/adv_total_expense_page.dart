import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/transaction_model.dart';
import 'package:ad_brokers/Services/wallet_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AdvTotalExpansePage extends StatefulWidget {
  const AdvTotalExpansePage({super.key});

  @override
  State<AdvTotalExpansePage> createState() => _AdvTotalExpansePageState();
}

class _AdvTotalExpansePageState extends State<AdvTotalExpansePage> {
  num totalExpanse = 0;
  final walletService = WalletService();
  String brandName = "";

  @override
  void initState() {
    getTotalExpanse();
    getUserData();
    gettingPlatforms();
    super.initState();
  }

  void getUserData() async {
    await HelperFunctions.getAdvBrandNameSF().then((value) {
      setState(() {
        brandName = value!;
      });
    });
  }

  getTotalExpanse() async {
    await walletService
        .advTotalExpanse(FirebaseAuth.instance.currentUser!.uid.toString())
        .then((value) {
      if (value != null) {
        setState(() {
          totalExpanse = value;
        });
      } else {
        totalExpanse = 0;
      }
    });
  }

  List<AdvTransactionModel> totalTransactions = [];

  gettingPlatforms() async {
    try {
      final platformResponse = await walletService.getAllAdvertiersTransactions(
          FirebaseAuth.instance.currentUser!.uid.toString());
      setState(() {
        totalTransactions = platformResponse!;
      });
    } catch (e) {
      debugPrint("Error :- ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          brandName,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        elevation: 4.0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Your Total Expense",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            color: Theme.of(context).cardColor,
            elevation: 4.0,
            child: ListTile(
              leading: ImageIcon(
                const AssetImage("assets/icons/Expense.png"),
                color: Theme.of(context).shadowColor,
              ).scale(scaleValue: 1.5),
              title: Text(
                "Total Expense",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              subtitle: Text(
                "$totalExpanse₹",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 0.7,
            color: Theme.of(context).shadowColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Your All Transactions",
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
    );
  }
}
