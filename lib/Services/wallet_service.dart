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
        num totalExpense = 0;
        debugPrint("Advertiser id $advId");
        final data = json.decode(response.body);
        debugPrint("Response =  $data");
        if (data == [] || data.length == 0) {
          totalExpense = 0;
        } else {
          totalExpense = data[0]["totalExpense"];
        }
        return totalExpense;
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
        num totalExpanse = 0;
        if (data.length == 0) {
          totalExpanse = 0;
        } else {
          totalExpanse = data["balance"];
        }
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
        num totalExpanse = 0;
        if (data.length == 0 || data == []) {
          totalExpanse = 0;
        } else {
          totalExpanse = data["balance"];
        }
        return totalExpanse;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
