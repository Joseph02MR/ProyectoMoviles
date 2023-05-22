class Food {
  final String foodId;
  final String label;
  final double enercKcal;
  final double procnt;
  final double fat;
  final double chocdf;
  final double fibtg;
  int portion = 1;

  Food({
    required this.foodId,
    required this.label,
    required this.enercKcal,
    required this.procnt,
    required this.fat,
    required this.chocdf,
    required this.fibtg,
    required this.portion,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        foodId: json["foodId"],
        label: json["label"],
        enercKcal: json["nutrients"]["ENERC_KCAL"],
        procnt: json["nutrients"]["PROCNT"]?.toDouble(),
        fat: json["nutrients"]["FAT"],
        chocdf: json["nutrients"]["CHOCDF"]?.toDouble(),
        fibtg: json["nutrients"]["FIBTG"],
        portion: 0,
      );

  factory Food.fromMap(Map<String, dynamic> json) => Food(
        foodId: json["food_id"],
        label: json["label"],
        enercKcal: json["kcal"],
        procnt: json["prots"]?.toDouble(),
        fat: json["fats"],
        chocdf: json["carbs"]?.toDouble(),
        fibtg: 0,
        portion: json["portion"],
      );

  void setPortion(value) {
    portion = value;
  }

  Map<String, dynamic> toMap() {
    return Map.from({
      "food_id": foodId,
      "label": label,
      "kcal": enercKcal,
      "carbs": chocdf,
      "prots": procnt,
      "fats": fat,
      "portion": portion
    });
  }
}
