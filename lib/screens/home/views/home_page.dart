import 'package:budget_tracker_app/components/add_component.dart';
import 'package:budget_tracker_app/components/overall_component.dart';
import 'package:budget_tracker_app/components/recent_component.dart';
import 'package:budget_tracker_app/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController controller = Get.put(NavigationController());
    List components = [OverallComponent(),AddComponent(),RecentComponent()];
    return Scaffold(
      body: Obx(() => components[controller.index.value],),
      bottomNavigationBar: Obx(
         () {
          return NavigationBar(
            selectedIndex: controller.index.value ,
            onDestinationSelected: (value) {
              controller.index.value = value;
            },
            destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "home"),
            NavigationDestination(icon: Icon(Icons.add), label: "add"),
            NavigationDestination(icon: Icon(Icons.history), label: "history"),
          ]);
        }
      ),
    );
  }
}
