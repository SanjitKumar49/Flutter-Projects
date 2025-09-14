import 'package:get/get.dart';
import '../controllers/textsnap_controller.dart';

class TextSnapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextSnapController>(() => TextSnapController());
  }
}
