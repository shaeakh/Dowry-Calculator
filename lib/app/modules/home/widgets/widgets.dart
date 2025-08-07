// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;
import 'package:starter/app/modules/home/controllers/home_controller.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: controller.primary,
            size: 35,
          ),
          onPressed: () {
            try {
              controller.gotoPreviousPage();
              if (controller.stateI.value > 0) {
                controller.stateI.value = controller.stateI.value - 1;
              }
            } catch (e) {
              debugPrint('Error navigating to previous page: $e');
            }
          },
        ),

        /// Expanded widget for title
        Text(
          'Grooms Information',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: controller.primary,
          ),
        ),
        SizedBox(width: 35),
      ],
    );
  }
}

class TitleWidgetDex extends StatelessWidget {
  const TitleWidgetDex({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: controller.base_100.withAlpha(100),
        borderRadius: BorderRadius.circular(controller.borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: controller.primary,
              size: 35,
            ),
            onPressed: () {
              try {
                controller.gotoPreviousPage();
                if (controller.stateI.value > 0) {
                  controller.stateI.value = controller.stateI.value - 1;
                }
              } catch (e) {
                debugPrint('Error navigating to previous page: $e');
              }
            },
          ),

          /// Expanded widget for title
          Expanded(
            child: Text(
              'Grooms Personal Information',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: controller.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GroomAnimationMob extends StatelessWidget {
  const GroomAnimationMob({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: RepaintBoundary(
        key: controller.artboardKey,
        child: rive.RiveAnimation.asset(
          'assets/rive/groom.riv',
          fit: BoxFit.cover,
          alignment: Alignment.center,
          onInit: controller.onRiveInit,
        ),
      ),
    );
  }
}

class GroomAnimation extends StatelessWidget {
  const GroomAnimation({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 16, 10),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 16),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: RepaintBoundary(
              key: controller.artboardKey,
              child: rive.RiveAnimation.asset(
                'assets/rive/groom.riv',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                onInit: controller.onRiveInit,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProceedButton extends StatelessWidget {
  const ProceedButton({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: controller.fieldWidth.value,
      child: ElevatedButton(
        onPressed: () {
          controller.submit(context);
          controller.gotoNextPage();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.primary,
          elevation: 5,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'NEXT',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AgeWidget extends StatelessWidget {
  const AgeWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
              controller: controller.age.value,
              maxLines: 1, // equivalent to multiline: false
              decoration: InputDecoration(
                hintText: "",
                labelText: "Enter your age",
                labelStyle: TextStyle(color: controller.primary),
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: controller.primary,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: controller.base_100,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.primary, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HeightWidget extends StatelessWidget {
  const HeightWidget({super.key, required this.controller});

  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
              controller: controller.height.value,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: "Enter Height (Centimetre)",
                labelStyle: TextStyle(color: controller.primary),
                prefixIcon: Icon(Icons.height, color: controller.primary),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: controller.base_100,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.primary, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BMIWidget extends StatelessWidget {
  const BMIWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
              controller: controller.weight,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: "Enter Weight",
                labelStyle: TextStyle(color: controller.primary),
                prefixIcon: Icon(
                  Icons.monitor_weight,
                  color: controller.primary,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: controller.base_100,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.primary, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ComplexionWidget extends StatelessWidget {
  const ComplexionWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Color(0xffe6e8ed),
            gradient: null, // since disabled is true
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: controller.fieldWidth.value,
            child: ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Choose your complexion",
                  content: SizedBox(
                    height: 500,
                    width: 500,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 100,
                          left: 10,
                          child: Image.asset(
                            "assets/pic/hand.png",
                            height: 254.347826087,
                            width: 195,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: List.generate(
                                  controller.complexions_label.length,
                                  (index) {
                                    return Container(
                                      height: 245,
                                      width: 185,
                                      color: Color(
                                        controller
                                            .complexions_label[index]["color"],
                                      ),
                                      child: Center(
                                        child: Text(
                                          controller
                                              .complexions_label[index]["label"]
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 25,
                                            fontFamily: "my_font",
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: List.generate(
                                  controller.complexions.length,
                                  (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.set_Complexion(
                                          6 - index,
                                          controller
                                              .complexions[index]["complexion"],
                                        );
                                        Get.back();
                                      },
                                      child: Container(
                                        height: 81.667,
                                        width: 185,
                                        color: Color(
                                          controller
                                              .complexions[index]["color"],
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller
                                                .complexions[index]["complexion"],
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontFamily: "my_font",
                                              color: (index > 2)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 10,
                          child: Image.asset(
                            "assets/pic/finger.png",
                            height: 254.347826087,
                            width: 195,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              // disabled is true
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xfff7f2fa),
                shadowColor: Colors.transparent,
                minimumSize: const Size.fromHeight(60),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: controller.primary, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: controller.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox(
                      width: 0,
                      height: 0,
                    ), // if no icon, empty circle
                  ),
                  Text(
                    controller.complexion_button_title.value,
                    style: TextStyle(
                      color: controller.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Salary extends StatelessWidget {
  const Salary({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: controller.salary,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: "Monthly Salary (BDT)",
                labelStyle: TextStyle(color: controller.primary),
                prefixIcon: Icon(Icons.attach_money, color: controller.primary),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: controller.base_100,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.primary, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RealEstate extends StatelessWidget {
  const RealEstate({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: controller.wealthAmount,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: "Estimated Wealth Amount (BDT)",
                labelStyle: TextStyle(color: controller.primary),
                prefixIcon: Icon(
                  Icons.account_balance,
                  color: controller.primary,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: controller.base_100,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.primary, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Division extends StatelessWidget {
  const Division({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: const Color(0xfff7f2fa),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: controller.fieldWidth.value,
            child: ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Choose your division",
                  content: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: controller.divisions.map((division) {
                        return RadioListTile<int>(
                          title: Text(
                            division["division"],
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "my_font",
                            ),
                          ),
                          value: division["value"],
                          groupValue:
                              int.tryParse(controller.division.value.text) ??
                              -1,
                          onChanged: (value) {
                            controller.set_Division(
                              value!,
                              division["division"],
                            );
                            Get.back();
                          },
                          activeColor: controller.primary,
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
              // since disabled: true
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xfff7f2fa),
                shadowColor: Colors.transparent,
                minimumSize: const Size.fromHeight(60),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: controller.primary, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: controller.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox(
                      width: 0,
                      height: 0,
                    ), // No icon provided
                  ),
                  Text(
                    controller.divisions_button_title.value,
                    style: TextStyle(
                      color: controller.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Shahbagi extends StatelessWidget {
  const Shahbagi({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: const Color(0xfff7f2fa),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: controller.fieldWidth.value,
            child: ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Choose your hygiene level",
                  titlePadding: const EdgeInsets.all(20),
                  content: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: controller.hygiene_options.map((option) {
                        return RadioListTile<int>(
                          title: Text(
                            option["hygiene"],
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "my_font",
                            ),
                          ),
                          value: option["value"],
                          groupValue:
                              int.tryParse(controller.selfHygiene.value.text) ??
                              -1,
                          onChanged: (value) {
                            controller.set_hygiene(value!, option["hygiene"]);
                            Get.back();
                          },
                          activeColor: controller.primary,
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
              // disabled is true
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xfff7f2fa),
                shadowColor: Colors.transparent,
                minimumSize: const Size.fromHeight(60),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: controller.primary, width: 1),
                ),
              ),
              child: Text(
                controller.hygiene_button_title.value,
                style: TextStyle(
                  color: controller.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DowryResult extends StatelessWidget {
  const DowryResult({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Your dowry amount is: ${controller.dowryInt.value} BDT",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: controller.primary,
          ),
        ),
      ],
    );
  }
}

class PosterWidget extends StatelessWidget {
  final HomeController controller;
  final String dowryAmount;

  const PosterWidget({
    super.key,
    required this.controller,
    required this.dowryAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white, // Solid white background to avoid transparency
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  controller.primary.withOpacity(0.1),
                  controller.secondary.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          // Main content
          Column(
            children: [
              // Title
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Dowry Calculator",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: controller.primary,
                  ),
                ),
              ),
              // Rive animation
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: rive.RiveAnimation.asset(
                    'assets/rive/groom.riv',
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                    onInit: controller.onRiveInit,
                  ),
                ),
              ),
              // Dowry amount
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Dowry: ৳$dowryAmount",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: controller.primary,
                  ),
                ),
              ),
              // Brand name
              Container(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Powered by ",
                      style: TextStyle(
                        fontSize: 16,
                        color: controller.secondary,
                      ),
                    ),
                    Text(
                      "Despicable Apps",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: controller.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
