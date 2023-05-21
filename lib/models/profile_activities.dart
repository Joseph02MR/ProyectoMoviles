Map<String, dynamic> hard_profile = Map.from({
  "name": "deportista",
  "water_goal": 3500,
  "sleep_goal": 8,
  "kcal_goal": 3400,
  "prot_goal": 81,
  "fat_goal": 70,
  "carbs_goal": 65
});

Map<String, dynamic> medium_profile = Map.from({
  "name": "moderada",
  "water_goal": 2500,
  "sleep_goal": 7,
  "kcal_goal": 3000,
  "prot_goal": 70,
  "fat_goal": 60,
  "carbs_goal": 55
});

Map<String, dynamic> low_profile = Map.from({
  "name": "baja",
  "water_goal": 2000,
  "sleep_goal": 7,
  "kcal_goal": 2500,
  "prot_goal": 61,
  "fat_goal": 53,
  "carbs_goal": 45
});

List profiles = List.from({hard_profile, medium_profile, low_profile});
