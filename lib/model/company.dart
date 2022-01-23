class Company {
  String name;
  String description;
  Map<String, dynamic> prices;
  String logo;

  Company({
    required this.name,
    required this.description,
    required this.logo,
    required this.prices,
  });

  Company.fromJson(Map<String, Object?> json)
      : this(
    name: json["name"] as String,
    description: json["description"] as String,
    logo: json["logo"] as String,
    prices: Map<String, dynamic>.from(json['prices'] as Map<String, dynamic>),
  );

  toJson() {
    return {
      'name': name,
      'description': description,
      'logo': logo,
      'prices': prices,
    };
  }
}
