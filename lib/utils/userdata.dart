import 'package:final_moviles/firebase/dao/diary_data_dao.dart';

class UserData {
  static String name = "";
  static String email = "";
  static String activityProfile = "";
  static String uid = "";

  static DiaryDataDAO dao = DiaryDataDAO();

  static void setData(act, id) {
    activityProfile = act ?? activityProfile;
    uid = id ?? uid;
  }

  static void setActivity(act) {
    activityProfile = act;
  }
}
