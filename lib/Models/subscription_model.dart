class SubscriptionModel {
  final String planName;
  final num planPrice;
  final num noOfViews;

  SubscriptionModel({
    required this.planName,
    required this.planPrice,
    required this.noOfViews,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      planName: json['name'],
      planPrice: json['price'],
      noOfViews: json['views'],
    );
  }
}
