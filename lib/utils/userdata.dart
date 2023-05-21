class UserData {
  static String name = "";
  static String email = "";
  static String activityProfile = "";
  static String uid = "";

  static void setData(act, id) {
    activityProfile = act ?? activityProfile;
    uid = id ?? uid;
  }

  static void setActivity(act) {
    activityProfile = act;
  }
}
