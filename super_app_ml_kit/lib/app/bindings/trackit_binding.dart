import 'package:get/get.dart';
import 'package:super_app_ml_kit/app/controllers/trackit_controller.dart';
import '../controllers/textsnap_controller.dart';

class TrackitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackitController>(() => TrackitController());
  }
}
