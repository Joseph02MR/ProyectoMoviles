import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_moviles/controllers/meals/meals_master_controller.dart';
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

  void initData() async {
    queryDaysData();
  }

  void queryDaysData() async {
    diaryEntries = await firestore
        .collection('diary')
        .where(
          'user_id',
          isEqualTo: DiaryData.email,
        )
        .where('date',
            isEqualTo:
                '${DiaryData.date.year}-${DiaryData.date.month}-${DiaryData.date.day}')
        .get()
        .then((value) {
      if (value.size > 0) {
        for (var entries in value.docs) {
          daysData = entries.data();
          diaryDocument = diaryCollection.doc(entries.id);
          setDayData(daysData);
          logger.i(daysData.toString());
        }
      } else {
        diaryDocument = diaryCollection.doc();
        logger.i(diaryDocument);
      }
    }).onError((error, stackTrace) {
      logger.w(error);
      logger.i(stackTrace);
    });
  }

  void setDayData(data) {
    MealsMasterController.mealsList.value = data['meals_data'];
    MealsMasterController.dayKcal.value =
        data['day_nutrient_data']['total_kcal'];
    MealsMasterController.dayCarbs.value =
        data['day_nutrient_data']['total_carb'];
    MealsMasterController.dayProts.value =
        data['day_nutrient_data']['total_prot'];
    MealsMasterController.dayFats.value =
        data['day_nutrient_data']['total_fat'];
  }

  void saveData(context) {
    diaryDocument!.set(DiaryData.toMap()).then((value) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Guardado finalizado',
        desc: 'Progreso actualizado',
        btnOkOnPress: () {},
      ).show();
      queryDaysData();
    }).onError((error, stackTrace) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error en el guardado',
        desc: 'El progreso no se actualizó',
        btnOkOnPress: () {},
      ).show();
    });
  }
}
