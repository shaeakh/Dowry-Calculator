import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/app/modules/home/widgets/widgets.dart';

import '../controllers/home_controller.dart';
import '../widgets/inputterDex.dart';
import '../widgets/inputterMob.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;

          // Define screen type based on width
          Widget responsiveContent;
          if (screenWidth >= 1024) {
            responsiveContent = _buildDesktopLayout(context);
          } else if (screenWidth >= 600) {
            responsiveContent = _buildTabletLayout(context);
          } else {
            responsiveContent = _buildMobileLayout(context);
          }

          return Center(child: responsiveContent);
        },
      ),
    );
  }

  /// Mobile Layout (vertical stack)
  Widget _buildMobileLayout(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GroomAnimation(controller: controller),
              InputterMob(controller: controller),
            ],
          ),
        ),
      ),
    );
  }

  /// Tablet Layout (spaced column)
  Widget _buildTabletLayout(BuildContext context) {
    return _buildDesktopLayout(context);
  }

  /// Desktop Layout (horizontal row)
  Widget _buildDesktopLayout(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Inputter(controller: controller),
              GroomAnimation(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
