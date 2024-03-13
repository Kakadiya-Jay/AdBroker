class AdvertiseModel {
  String? sId;
  String? title;
  String? advertiserId;
  String? redirect;
  String? image;
  String? type;
  String? category;
  int? remainViews;
  String? status;
  bool? approve;
  // List<int>? previousPlans;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AdvertiseModel(
      {this.sId,
      this.title,
      this.advertiserId,
      this.redirect,
      this.image,
      this.type,
      this.category,
      this.remainViews,
      this.status,
      this.approve,
      // this.previousPlans,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AdvertiseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    advertiserId = json['advertiserId'];
    redirect = json['redirect'];
    image = json['image'];
    type = json['type'];
    category = json['category'];
    remainViews = json['remain_Views'];
    status = json['status'];
    approve = json['approve'];
    // if (json['previous_plans'] != null) {
    //   previousPlans = <int>[];
    //   json['previous_plans'].forEach((v) {
    //     previousPlans!.add(new int.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['advertiserId'] = this.advertiserId;
    data['redirect'] = this.redirect;
    data['image'] = this.image;
    data['type'] = this.type;
    data['category'] = this.category;
    data['remain_Views'] = this.remainViews;
    data['status'] = this.status;
    data['approve'] = this.approve;
    // if (this.previousPlans != null) {
    //   data['previous_plans'] =
    //       this.previousPlans!.map((int) => int.toJson()).toList();
    // }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
