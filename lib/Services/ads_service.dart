import 'dart:convert';

import 'package:ad_brokers/Shared/constant.dart';
import 'package:ad_brokers/Shared/exceptions.dart';
import 'package:http/http.dart' as http;

class AdService {
  Future addNewAdvertisement(String advId,String adTitle,String adURL,String adCategory,String adType,String imageUrl) async {
    try {
      var url = Uri.parse(
          APIConstant.baseURL + APIConstant.addNewAdvertisementEndPoint);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "title" : adTitle,
          "advertiserId": advId,
          "category": adCategory,
          "redirect" : adURL,
          "image" : adURL,
          "type": adType,
          "remain_Views" : "40",
          "status" : "pending" ,
        }),
      );

      if(response.statusCode == 200) {
        return response;
      } else {
        throw APIException();
      }
    } on APIException catch(ex) {
      return ex.printErrorMessage();
    }
    catch (ex) {
      return ex.toString();
    }
  }
}
