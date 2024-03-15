import 'dart:convert';
import 'package:ad_brokers/Models/advertisement_model.dart';
import 'package:ad_brokers/Shared/constant.dart';
import 'package:ad_brokers/Shared/exceptions.dart';
import 'package:flutter/material.dart';
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
        return true;
      } else {
        throw APIException();
      }
    } on APIException catch (ex) {
      return ex.printErrorMessage();
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<List<Advertisements>?> getAdvertisementOfPerticularAdvertiser(
      String advId) async {
    try {
      var url = Uri.parse(
          APIConstant.baseURL + APIConstant.getAdvertisementByIdEndPoint);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "advertiserId": advId,
        }),
      );
      if (response.statusCode == 200) {
        List listresponse = json.decode(response.body);
        // final advertisements = jsonResult.map((e) {
        //   return Advertisements.fromJson(e);
        // }).toList();
        List<Advertisements> advertisements = [];
        for (var item in listresponse) {
          advertisements.add(Advertisements.fromJson(item));
        }
        return advertisements;
      }
    } on APIException catch (ex) {
      debugPrint("Oops Error....${ex.printErrorMessage()}");
      return null;
    } catch (ex) {
      debugPrint("Oops Error....${ex.toString()}");
      return null;
    }
    return null;
  }
}
