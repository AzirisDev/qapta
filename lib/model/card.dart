class CardModel{
  final String cardNumber;
  final String cardHolder;

  CardModel({required this.cardNumber, required this.cardHolder});

  CardModel.fromJson(Map<String, dynamic> json)
      : this(
    cardNumber: json["card_number"] as String,
    cardHolder: json['card_holder'] as String,
  );

  toJson() {
    return {
      'card_number': cardNumber,
      'card_holder': cardHolder,
    };
  }

  factory CardModel.empty() => CardModel(cardHolder: '', cardNumber: '');
}