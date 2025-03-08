import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxMap<int, int> badgeCounts = RxMap<int, int>();

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void setBadgeCount(int index, int count) {
    badgeCounts[index] = count;
  }

  int getBadgeCount(int index) {
    return badgeCounts[index] ?? 0;
  }

  void clearBadge(int index) {
    badgeCounts.remove(index);
  }
}
