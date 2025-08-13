class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? profileImage;
  List<BankCard>? bankCards;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profileImage,
    this.bankCards,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        profileImage: json["profile_image"],
        bankCards: json["bank_cards"] == null
            ? []
            : List<BankCard>.from(
                json["bank_cards"]!.map((x) => BankCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "profile_image": profileImage,
        "bank_cards": bankCards == null
            ? []
            : List<dynamic>.from(bankCards!.map((x) => x.toJson())),
      };
}

class BankCard {
  String? id;
  String? bankName;
  String? accountNumber;
  String? cardType;

  BankCard({
    this.id,
    this.bankName,
    this.accountNumber,
    this.cardType,
  });

  factory BankCard.fromJson(Map<String, dynamic> json) => BankCard(
        id: json["id"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        cardType: json["card_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "account_number": accountNumber,
        "card_type": cardType,
      };
}