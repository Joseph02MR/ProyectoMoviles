Map<String, dynamic> hard_profile = Map.from(
    {"name": "baja", "water_goal": 3500, "sleep_goal": 8, "carbs_goal": 3400});

Map<String, dynamic> medium_profile = Map.from({
  "name": "moderada",
  "water_goal": 2500,
  "sleep_goal": 7,
  "carbs_goal": 3000
});

Map<String, dynamic> low_profile = Map.from({
  "name": "deportista",
  "water_goal": 2000,
  "sleep_goal": 7,
  "carbs_goal": 2500
});

List profiles = List.from({hard_profile, medium_profile, low_profile});
