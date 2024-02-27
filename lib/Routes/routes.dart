// ignore_for_file: non_constant_identifier_names

import 'package:ad_brokers/UI/Pages/Authentications/check_user_status.dart';
import 'package:ad_brokers/UI/Pages/add_new_advertisement.dart';
import 'package:ad_brokers/UI/Pages/chat_page.dart';
import 'package:ad_brokers/UI/Pages/home_page.dart';
import 'package:ad_brokers/UI/Pages/Authentications/loginpage.dart';
import 'package:ad_brokers/UI/Pages/profile_page.dart';
import 'package:ad_brokers/UI/Pages/my_ads_page.dart';
import 'package:ad_brokers/UI/Pages/Authentications/signuppage.dart';
import 'package:ad_brokers/UI/Pages/visitors_page.dart';
import 'package:ad_brokers/UI/Widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

var AppRoutes = <String, WidgetBuilder>{
  "/chaekUserStatus": (context) => const CheckUserLoginStatus(),
  "/visitorHomePage": (context) => const VisitorSideHomePage(),
  "/loginPage": (context) => const LoginPage(),
  "/signupPage": (context) => const SignUpPage(),
  "/frontPage": (context) => const NavigationBarTemplate(),
  "/homePage": (context) => const HomePage(),
  "/reservationPage": (context) => const MyAdsPage(),
  "/chatPage": (context) => const ChatPage(),
  "/profilePage": (context) => const ProfilePage(),
  "/addNewAdPage": (context) => const AddNewAdvertisement(),
};
