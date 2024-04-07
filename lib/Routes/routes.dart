// ignore_for_file: non_constant_identifier_names

import 'package:ad_brokers/UI/Pages/Advertisers/adv_business_details_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/show_business_details_page.dart';
import 'package:ad_brokers/UI/Pages/Authentications/check_user_status.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/add_new_advertisement.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_chat_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_home_page.dart';
import 'package:ad_brokers/UI/Pages/Authentications/adv_loginpage.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_profile_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/my_ads_page.dart';
import 'package:ad_brokers/UI/Pages/Authentications/adv_signuppage.dart';
import 'package:ad_brokers/UI/Pages/Authentications/pub_loginpage.dart';
import 'package:ad_brokers/UI/Pages/Authentications/pub_signuppage.dart';
import 'package:ad_brokers/UI/Pages/Publishers/pub_bussiness_details_page.dart';
import 'package:ad_brokers/UI/Pages/Publishers/pub_all_platfroms_page.dart';
import 'package:ad_brokers/UI/Pages/Publishers/pub_home_page.dart';
import 'package:ad_brokers/UI/Pages/Publishers/pub_profile_page.dart';
import 'package:ad_brokers/UI/Pages/Publishers/pub_profit_page.dart';
import 'package:ad_brokers/UI/Pages/Publishers/show_pub_bussiness_details_page.dart';
import 'package:ad_brokers/UI/Pages/Visitors/visiters_about_us_page.dart';
import 'package:ad_brokers/UI/Pages/Visitors/visiters_contact_us_page.dart';
import 'package:ad_brokers/UI/Pages/Visitors/visiters_home_page.dart';
import 'package:ad_brokers/UI/Widgets/adv_navigation_bar.dart';
import 'package:ad_brokers/UI/Widgets/pub_navigation_bar.dart';
import 'package:flutter/material.dart';

var AppRoutes = <String, WidgetBuilder>{
  "/checkUserStatus": (context) => const CheckUserLoginStatus(),
  "/visitor/homePage": (context) => const VisitorSideHomePage(),
  "/visitor/aboutUsPage": (context) => const VisitorSideAboutUsPage(),
  "/visitor/contactUsPage": (context) => const VisitorSideContactUsPage(),
  "/adv/loginPage": (context) => const AdvLoginPage(),
  "/adv/signupPage": (context) => const AdvSignUpPage(),
  "/adv/registerBusinessPage": (context) => const AdvBusinessDetailsPage(),
  "/adv/frontPage": (context) => const AdvNavigationBarTemplate(),
  "/adv/homePage": (context) => const AdvHomePage(),
  "/adv/myAdsPage": (context) => const MyAdsPage(),
  "/adv/chatPage": (context) => const AdvChatPage(),
  "/adv/profilePage": (context) => const AdvProfilePage(),
  "/adv/addNewAdPage": (context) => const AddNewAdvertisement(),
  "/adv/showAdvBusinessDetailsPage": (context) => const ShowBusinessDetailsPage(),
  "/pub/loginPage": (context) => const PubLoginPage(),
  "/pub/signupPage": (context) => const PubSignUpPage(),
  "/pub/registerBusinessPage": (context) => const PubBusinessDetailsPage(),
  "/pub/frontPage": (context) => const PubNavigationBarTemplate(),
  "/pub/homePage": (context) => const PubHomePage(),
  "/pub/profitPage": (context) => const ProfitPage(),
  "/pub/chatPage": (context) => const PubAllPlatformPage(),
  "/pub/profilePage": (context) => const PubProfilePage(),
  "/pub/showAdvBusinessDetailsPage": (context) => const ShowPublisherBusinessDetails(),
};
