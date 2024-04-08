class APIConstant {
  static String baseURL = "https://admanager-s9eo.onrender.com";

  //Advertisements
  static String addNewAdvertisementEndPoint = "/advertise";
  static String getAdvertisementByIdEndPoint = "/advertise/id";

  //Publishers
  static String getAllPublisherPlatforms = "/application/myApplicaitons";

  //Subscriptions
  static String getAllSubscriptions = "/plans";

  //Payment
  static String makeAdvertiserPayment = "/transaction/advertise";
  static String makePublisherWithdrawal = "/transaction/withdrawal";

  //Register New Platform
  static String registerNewPlatform = "/application";

  //Wallet
  static String getAllAdvTransactions = "/transaction/advertiser";
  static String getAllPubTransactions = "/transaction/publisher";
  static String getAdvTotalExpense = "/transaction/myTotalExpense";
  static String getPubTotalRevenue = "/transaction/myTotalEarning";
  static String getPubCurrentBalance = "/transaction/currentBalance";

  // Contact Us Service
  static String contactUsServiceEndPoint = "/message";
}
