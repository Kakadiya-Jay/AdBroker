import 'dart:convert';

import 'package:ad_brokers/Shared/constant.dart';
import 'package:ad_brokers/Shared/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PublisherPlatformService {
  Future ragisterNewPlatform(String name, String pubId, String bundleId,
      String category, String redirectURL) async {
    try {
      var url =
          Uri.parse(APIConstant.baseURL + APIConstant.registerNewPlatform);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "publisherId": pubId,
          "bundleId": bundleId,
          "catagory": category,
          "redirect": redirectURL,
        }),
      );
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        debugPrint("resonse:- $res");
        String id = res["createOne"]["_id"];
        debugPrint("Id:- $id");
        return id;
      }
    } on APIException catch (ex) {
      debugPrint("Oops Error occurred ${ex.printErrorMessage()}");
      return null;
    } catch (e) {
      debugPrint("Oops Error occured :-  ${e.toString()}");
      return null;
    }
  }
}
