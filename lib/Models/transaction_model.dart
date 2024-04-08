class AdvTransactionModel {
  final String advertiserId;
  final String transactionId;
  final String type;
  final num amount;
  final DateTime createdDate;

  AdvTransactionModel({
    required this.advertiserId,
    required this.transactionId,
    required this.type,
    required this.amount,
    required this.createdDate,
  });

  factory AdvTransactionModel.fromJson(Map<String, dynamic> json) {
    return AdvTransactionModel(
      advertiserId: json["advertiserId"],
      transactionId: json["transactionId"],
      type: json["type"],
      amount: json["amount"],
      createdDate: DateTime.parse(json["createdAt"]),
    );
  }
}

class PubTransactionModel {
  final String publisherId;
  final String transactionId;
  final String type;
  final num amount;
  final DateTime createdDate;

  PubTransactionModel({
    required this.publisherId,
    required this.transactionId,
    required this.type,
    required this.amount,
    required this.createdDate,
  });

  factory PubTransactionModel.fromJson(Map<String, dynamic> json) {
    return PubTransactionModel(
      publisherId: json["publisherId"],
      transactionId: json["transactionId"],
      type: json["type"],
      amount: json["amount"],
      createdDate: DateTime.parse(json["createdAt"]),
    );
  }
}
