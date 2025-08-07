// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import 'widgets.dart';

class InputterMob extends StatelessWidget {
  const InputterMob({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
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
            ProceedButton(controller: controller),
          ],
        ),
      ),
    );
  }
}
