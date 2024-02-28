// ignore_for_file: non_constant_identifier_names

import 'package:ad_brokers/UI/Pages/Authentications/check_user_status.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/add_new_advertisement.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_chat_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_home_page.dart';
import 'package:ad_brokers/UI/Pages/Authentications/adv_loginpage.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_profile_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/my_ads_page.dart';
import 'package:ad_brokers/UI/Pages/Authentications/adv_signuppage.dart';
import 'package:ad_brokers/UI/Pages/Visitors/visiters_about_us_page.dart';
import 'package:ad_brokers/UI/Pages/Visitors/visiters_contact_us_page.dart';
import 'package:ad_brokers/UI/Pages/Visitors/visiters_home_page.dart';
import 'package:ad_brokers/UI/Widgets/adv_navigation_bar.dart';
import 'package:flutter/material.dart';

var AppRoutes = <String, WidgetBuilder>{
  "/checkUserStatus": (context) => const CheckUserLoginStatus(),
  "/visitor/homePage": (context) => const VisitorSideHomePage(),
  "/visitor/aboutUsPage": (context) => const VisitorSideAboutUsPage(),
  "/visitor/contactUsPage": (context) => const VisitorSideContactUsPage(),
  "/adv/loginPage": (context) => const AdvLoginPage(),
  "/adv/signupPage": (context) => const AdvSignUpPage(),
  "/adv/frontPage": (context) => const AdvNavigationBarTemplate(),
  "/adv/homePage": (context) => const AdvHomePage(),
  "/adv/reservationPage": (context) => const MyAdsPage(),
  "/adv/chatPage": (context) => const AdvChatPage(),
  "/adv/profilePage": (context) => const AdvProfilePage(),
  "/adv/addNewAdPage": (context) => const AddNewAdvertisement(),
};
