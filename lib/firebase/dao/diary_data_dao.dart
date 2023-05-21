import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_moviles/models/diary_data.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class DiaryDataDAO extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final diaryCollection = FirebaseFirestore.instance.collection('diary');
  QuerySnapshot<Map<String, dynamic>>? diaryEntries;
  Map<String, dynamic>? daysData;
  DocumentReference? diaryDocument;

  @override
  void onInit() async {
    diaryEntries = await firestore
        .collection('diary')
        .where(
          'user_id',
          isEqualTo: DiaryData.userId,
        )
        .where('date', isEqualTo: DiaryData.date)
        .get();
    if (diaryEntries!.size > 0) {
      for (final QueryDocumentSnapshot<Map<String, dynamic>> entries
          in diaryEntries!.docs) {
        daysData = entries.data();
        diaryDocument = diaryCollection.doc(entries.id);
        logger.i(daysData.toString());
      }
    } else {
      diaryDocument = diaryCollection.doc();
    }
    super.onInit();
  }

  void saveData() {
    diaryDocument!.set(DiaryData.toMap());
  }
}
