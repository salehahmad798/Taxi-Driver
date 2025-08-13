class WalletModel {
  double? balance;
  List<Transaction>? transactions;

  WalletModel({this.balance, this.transactions});

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        balance: json["balance"]?.toDouble(),
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
      };
}

class Transaction {
  String? id;
  double? amount;
  String? type;
  String? description;
  DateTime? createdAt;

  Transaction({
    this.id,
    this.amount,
    this.type,
    this.description,
    this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        amount: json["amount"]?.toDouble(),
        type: json["type"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "type": type,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
      };
}
