class Food {
  final String foodId;
  final String label;
  final int enercKcal;
  final double procnt;
  final int fat;
  final double chocdf;
  final int fibtg;

  Food({
    required this.foodId,
    required this.label,
    required this.enercKcal,
    required this.procnt,
    required this.fat,
    required this.chocdf,
    required this.fibtg,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        foodId: json["foodId"],
        label: json["label"],
        enercKcal: json["nutrients"]["ENERC_KCAL"],
        procnt: json["nutrients"]["PROCNT"]?.toDouble(),
        fat: json["nutrients"]["FAT"],
        chocdf: json["nutrients"]["CHOCDF"]?.toDouble(),
        fibtg: json["nutrients"]["FIBTG"],
      );
}
