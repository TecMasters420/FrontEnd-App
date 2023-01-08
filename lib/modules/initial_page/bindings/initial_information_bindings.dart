import 'package:get/get.dart';
import '../controllers/initial_announcements_controller.dart';

import '../controllers/announcements_carrousel_controller.dart';

class InitialInformationBindings implements Bindings {
  const InitialInformationBindings();
  @override
  void dependencies() {
    Get.put(AnnouncementsCarrouselController(), permanent: false);
    Get.put(InitialAnnouncementsController(), permanent: false);
  }
}
