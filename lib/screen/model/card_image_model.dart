import 'dart:convert';

CardImageModel cardImageModelFromJson(String str) => CardImageModel.fromJson(json.decode(str));

String cardImageModelToJson(CardImageModel data) => json.encode(data.toJson());

class CardImageModel {
  CardImageModel({
    required this.cards,
    required this.message,
  });

  List<Carding> cards;
  String message;

  factory CardImageModel.fromJson(Map<String, dynamic> json) => CardImageModel(
    cards: List<Carding>.from(json["cards"].map((x) => Carding.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
    "message": message,
  };
}

class Carding {
  Carding({
    required this.cardId,
    required this.fullName,
    required this.email,
    required this.phone,
    this.instagram,
    this.whatsapp,
    this.facebook,
    this.twitter,
    this.description,
    this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.backgroundImageId,
    required this.cardType,
    this.usersId,
    required this.cardImages,
  });

  String cardId;
  String fullName;
  String email;
  String phone;
  dynamic instagram;
  dynamic whatsapp;
  dynamic facebook;
  dynamic twitter;
  dynamic description;
  dynamic address;
  DateTime createdAt;
  DateTime updatedAt;
  String backgroundImageId;
  String cardType;
  dynamic usersId;
  CardImages cardImages;

  factory Carding.fromJson(Map<String, dynamic> json) => Carding(
      cardId: json["cardId"],
      fullName: json["fullName"],
      email: json["email"],
      phone: json["phone"],
      instagram: json["instagram"],
      whatsapp: json["whatsapp"],
      facebook: json["facebook"],
      twitter: json["twitter"],
      description: json["description"],
      address: json["address"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      backgroundImageId: json["backgroundImageId"],
      cardType: json["cardType"],
      usersId: json["usersId"],
      cardImages: CardImages.fromJson(json["cardImages"])
  );

  Map<String, dynamic> toJson() => {
    "cardId": cardId,
    "fullName": fullName,
    "email": email,
    "phone": phone,
    "instagram": instagram,
    "whatsapp": whatsapp,
    "facebook": facebook,
    "twitter": twitter,
    "description": description,
    "address": address,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "backgroundImageId": backgroundImageId,
    "cardType": cardType,
    "usersId": usersId,
    "cardImages": cardImages.toJson(),
  };
}

class CardImages {
  CardImages({
    required this.cardImageId,
    required this.imageUrl,
  });

  String cardImageId;
  String imageUrl;

  factory CardImages.fromJson(Map<String, dynamic> json) => CardImages(
    cardImageId: json["cardImageId"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "cardImageId": cardImageId,
    "imageUrl": imageUrl,
  };
}
