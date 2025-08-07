// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import 'widgets.dart';

class InputterDex extends StatelessWidget {
  const InputterDex({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: BoxDecoration(
          color: controller.base_100,
          borderRadius: BorderRadius.circular(controller.borderRadius),
        ),
        margin: EdgeInsets.all(controller.maRgin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TitleWidgetDex(controller: controller),
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
                  Center(child: ComplexionWidget(controller: controller)),
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
    );
  }
}
