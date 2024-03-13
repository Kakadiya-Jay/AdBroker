import 'dart:convert';

import 'package:ad_brokers/Shared/constant.dart';
import 'package:ad_brokers/Shared/exceptions.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AdService {
  Future addNewAdvertisement(String advId, String adTitle, String adURL,
      String adCategory, String imageUrl) async {
    try {
      var url = Uri.parse(
          APIConstant.baseURL + APIConstant.addNewAdvertisementEndPoint);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "title": adTitle,
          "advertiserId": advId,
          "category": adCategory,
          "redirect": adURL,
          "image": imageUrl,
          "type": "Banner",
          "remain_Views": "40",
          "status": "pending",
        }),
      );
      if (response.statusCode == 200) {
        print("Response" + response.toString());
        return true;
      } else {
        print("Oops Somthing went wrong");
        throw APIException();
      }
    } on APIException catch (ex) {
      return ex.printErrorMessage();
    } catch (ex) {
      return ex.toString();
    }
  }

  Future getAdvertisementOfPerticularAdvertiser(String advId) async {
    try {
      var url = Uri.parse(
          APIConstant.baseURL + APIConstant.addNewAdvertisementEndPoint);
      url.replace(
        queryParameters: {
          "advertiserId": advId,
        },
      );
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        print("Response" + response.body);
        return jsonDecode(response.body);
      } else {
        throw APIException();
      }
    } on APIException catch (ex) {
      return ex.printErrorMessage();
    } catch (ex) {
      return ex.toString();
    }
  }
}
