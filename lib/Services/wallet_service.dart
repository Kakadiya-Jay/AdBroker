import 'dart:convert';

import 'package:ad_brokers/Shared/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WalletService {
  Future advTotalExpanse(String advId) async {
    try {
      var response = await http.post(
        Uri.parse(APIConstant.baseURL + APIConstant.getAdvTotalExpense),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'advertiserId': advId,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        num totalExpanse = data[0]["totalExpense"];
        return totalExpanse;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future pubTotalRevenue(String pubId) async {
    try {
      var response = await http.post(
        Uri.parse(APIConstant.baseURL + APIConstant.getPubTotalRevenue),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'publisherId': pubId,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        num totalExpanse = data[0]["totalEarning"];
        return totalExpanse;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future pubCurrentBalance(String pubId) async {
    try {
      var response = await http.post(
        Uri.parse(APIConstant.baseURL + APIConstant.getPubCurrentBalance),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'publisherId': pubId,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        num totalExpanse = data["balance"];
        return totalExpanse;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }


}
