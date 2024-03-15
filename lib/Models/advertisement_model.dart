class Advertisements {
  final String id;
  final String advId;
  final String adTitle;
  final String adRedirect;
  final String adImageUrl;
  final String adType;
  final String adCategory;
  final int remainViews;
  final String adStatus;
  final bool adApprove;

  Advertisements({
    required this.id,
    required this.advId,
    required this.adTitle,
    required this.adRedirect,
    required this.adImageUrl,
    required this.adType,
    required this.adCategory,
    required this.remainViews,
    required this.adStatus,
    required this.adApprove,
  });

  factory Advertisements.fromJson(Map<String, dynamic> json) {
    return Advertisements(
      id: json['_id'],
      advId: json['advertiserId'],
      adTitle: json['title'],
      adRedirect: json['redirect'],
      adImageUrl: json['image'],
      adType: json['type'],
      adCategory: json['category'],
      remainViews: json['remain_Views'],
      adStatus: json['status'],
      adApprove: json['approve'],
    );
  }
}

class PreviousPlans {
  String planName;
  String planPrice;
  String noOfDays;

  PreviousPlans({
    required this.planName,
    required this.planPrice,
    required this.noOfDays,
  });

  factory PreviousPlans.fromJson(Map<String, dynamic> record) {
    return PreviousPlans(
      planName: record["plan_name"],
      planPrice: record["plan_price"],
      noOfDays: record["no_of_days"],
    );
  }
}
