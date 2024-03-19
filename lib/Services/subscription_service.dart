import 'dart:convert';

import 'package:ad_brokers/Models/subscription_model.dart';
import 'package:ad_brokers/Shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubscriptionService {
  List<SubscriptionModel> subscriptions = [];

  Future<List<SubscriptionModel>?> getAllSubscriptions() async {
    try {
      var url =
          Uri.parse(APIConstant.baseURL + APIConstant.getAllSubscriptions);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var plansList = json.decode(response.body);
        for (var plans in plansList) {
          subscriptions.add(SubscriptionModel.fromJson(plans));
        }
        return subscriptions;
      } 
    } catch (ex) {
      debugPrint("Oops Error :- ${ex.toString()}");
    }
    return null;
  }
}
