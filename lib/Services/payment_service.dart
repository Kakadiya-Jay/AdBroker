import 'dart:convert';

import 'package:ad_brokers/Shared/constant.dart';
import 'package:ad_brokers/Shared/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Future makeAdvertisementsPayment(String id, String transactionId,
      String advId, num amount, num noOfViews) async {
    try {
      var url =
          Uri.parse(APIConstant.baseURL + APIConstant.makeAdvertiserPayment);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "advertisId": id,
          "transactionId": transactionId,
          "advertiserId": advId,
          "amount": amount,
          "views": noOfViews,
          "type": "Credit"
        }),
      );
      if (response.statusCode == 200) {
        // final res = json.decode(response.body);
        return true;
      } else {
        throw APIException();
      }
    } on APIException catch (ex) {
      debugPrint("Oops its an Error :- ${ex.printErrorMessage()}");
      return ex.printErrorMessage();
    } catch (ex) {
      debugPrint("Oops its an Error :- ${ex.toString()}");
      return ex.toString();
    }
  }

  Future makePublisherWithdrawal(String pubId, num amount) async {
    try {
      var url =
          Uri.parse(APIConstant.baseURL + APIConstant.makePublisherWithdrawal);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "publisherId": pubId,
          "amount": amount,
        }),
      );

      if (response.statusCode == 500) {
        final res = json.decode(response.body);
        return res;
      } else {
        throw APIException();
      }
    } on APIException catch (ex) {
      debugPrint("Oops its an Error :- ${ex.printErrorMessage()}");
      return null;
    } catch (ex) {
      debugPrint("Oops its an Error :- ${ex.toString()}");
      return null;
    }
  }
}
