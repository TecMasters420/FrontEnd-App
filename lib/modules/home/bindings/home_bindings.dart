import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeBindings implements Bindings {
  const HomeBindings();
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }
}
