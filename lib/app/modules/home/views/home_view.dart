import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/app/modules/home/widgets/widgets.dart';

import '../controllers/home_controller.dart';

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
            responsiveContent = _buildTabletLayout();
          } else {
            responsiveContent = _buildMobileLayout();
          }

          return Center(child: responsiveContent);
        },
      ),
    );
  }

  /// Mobile Layout (vertical stack)
  Widget _buildMobileLayout() {
    return Text("This is mobile view", style: const TextStyle(fontSize: 28));
  }

  /// Tablet Layout (spaced column)
  Widget _buildTabletLayout() {
    return Text("This is tablet view", style: const TextStyle(fontSize: 28));
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
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: controller.base_100,
                    borderRadius: BorderRadius.circular(
                      controller.borderRadius,
                    ),
                  ),
                  margin: EdgeInsets.all(controller.maRgin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TitleWidget(controller: controller),
                      SizedBox(height: 20),
                      SizedBox(
                        width: controller.fieldWidth.value + 40,
                        height: 120,
                        child: PageView(
                          controller: controller.pageController.value,
                          children: [
                            Center(child: AgeWidget(controller: controller)),
                            Center(child: HeightWidget(controller: controller)),
                            Center(child: BMIWidget(controller: controller)),
                            Center(
                              child: ComplexionWidget(controller: controller),
                            ),
                            Center(child: Salary(controller: controller)),
                            Center(child: RealEstate(controller: controller)),
                            Center(child: Division(controller: controller)),
                            Center(child: Shahbagi(controller: controller)),                            
                            Center(child: DowryResult(controller: controller)),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      ProceedButton(controller: controller),
                    ],
                  ),
                ),
              ),
              GroomAnimation(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
