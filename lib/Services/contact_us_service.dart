import 'dart:convert';

import 'package:ad_brokers/Shared/constant.dart';
import 'package:ad_brokers/Shared/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactUsService {
  Future sendNewQueryOfUser(String id, String roll, String email, String mobile,
      String title, String details) async {
    try {
      var url =
          Uri.parse(APIConstant.baseURL + APIConstant.contactUsServiceEndPoint);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "userId": id,
          "roll": roll,
          "email": email,
          "mobile": mobile,
          "title": title,
          "detail": details,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw APIException();
      }
    } on APIException catch (ex) {
      debugPrint("Oops error :- ${ex.printErrorMessage()}");
      return false;
    } catch (ex) {
      debugPrint("Oops error :- ${ex.toString()}");
      return false;
    }
  }
}
