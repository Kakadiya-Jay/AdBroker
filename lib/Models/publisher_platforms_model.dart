class PlatformModel {
  final String id;
  final String name;
  final String bundleId;
  final String redirectURL;
  final String category;
  final num totalClicks;
  final num totalViews;
  final num totalEarnings;

  PlatformModel({
    required this.id,
    required this.name,
    required this.bundleId,
    required this.redirectURL,
    required this.category,
    required this.totalClicks,
    required this.totalViews,
    required this.totalEarnings,
  });

  factory PlatformModel.fromJson(Map<String, dynamic> json) {
    return PlatformModel(
      id: json['_id'],
      name: json['name'],
      bundleId: json['bundleId'],
      redirectURL: json['redirect'],
      category: json['catagory'],
      totalClicks: json['totalClicks'],
      totalViews: json['total_Views'],
      totalEarnings: json['totalEarn'],
    );
  }
}
