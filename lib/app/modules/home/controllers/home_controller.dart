// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:math' show Random, pow;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' hide Image;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;

import '../widgets/share_dl_button.dart';

class HomeController extends GetxController {
  // ==================== UI Constants ====================
  Color primary = const Color(0xff006769);
  Color secondary = const Color(0xff3c4a7a);
  Color accent = const Color(0xff15b392);
  Color neutral = const Color(0xffe1ffbb);
  Color base_100 = const Color(0xffF0F0F0);
  Color info = const Color(0xff1e5972);
  Color success = const Color(0xff4ade80);
  Color warning = const Color(0xffda635d);
  Color error = const Color(0xffe21818);

  double borderRadius = 35;
  double maRgin = 16;
  double paDDing = 16;
  RxDouble fieldWidth = 400.0.obs;

  // ==================== Text Controllers ====================
  Rx<TextEditingController> age = TextEditingController().obs;
  Rx<TextEditingController> height = TextEditingController().obs;
  TextEditingController weight = TextEditingController();
  Rx<TextEditingController> complexion = TextEditingController().obs;
  TextEditingController salary = TextEditingController();
  TextEditingController wealthAmount = TextEditingController();
  Rx<TextEditingController> division = TextEditingController().obs;
  Rx<TextEditingController> selfHygiene = TextEditingController().obs;

  ScreenshotController screenshotController = ScreenshotController();
  bool isCapturing = false;
  Uint8List? capturedImage;

  // ==================== Page Navigation ====================
  Rx<PageController> pageController = PageController().obs;
  final int totalPages = 8;
  RxInt currentPage = 0.obs;

  void gotoNextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      pageController.value.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void gotoPreviousPage() {
    if (currentPage > 0) {
      currentPage--;
      pageController.value.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // ==================== Complexion ====================
  RxString complexion_button_title = "Complexion".obs;
  List<Map<String, dynamic>> complexions_label = [
    {"label": "Pookie", "color": 0xffe1ffbb},
    {"label": "Nigga", "color": 0xff9ed678},
  ];
  List<Map<String, dynamic>> complexions = [
    {"complexion": "very fair", "color": 0xfffef2f2, "value": 6},
    {"complexion": "fair", "color": 0xfff8e7cd, "value": 5},
    {"complexion": "whitish", "color": 0xfffad3ac, "value": 4},
    {"complexion": "whitish brown", "color": 0xffae7502, "value": 3},
    {"complexion": "brown", "color": 0xff724e10, "value": 2},
    {"complexion": "dark", "color": 0xff3b3b3b, "value": 1},
  ];

  void set_Complexion(int n, String s) {
    complexion.value.text = n.toString();
    complexion_button_title.value = s;
    print(
      "complexion text ${complexion.value.text} complexion_button_title $complexion_button_title",
    );
  }

  // ==================== Division ====================
  RxString divisions_button_title = "Division".obs;
  List<Map<String, dynamic>> divisions = [
    {"division": "Barishal", "value": -5},
    {"division": "Chattogram", "value": 11},
    {"division": "Cumilla", "value": 5},
    {"division": "Dhaka", "value": 11},
    {"division": "Khulna", "value": 9},
    {"division": "Mymensingh", "value": 6},
    {"division": "Noakhali", "value": -3},
    {"division": "Rajshahi", "value": 5},
    {"division": "Rangpur", "value": 4},
    {"division": "Sylhet", "value": 10},
  ];

  void set_Division(int n, String s) {
    division.value.text = n.toString();
    divisions_button_title.value = s;
    print(
      "Division text ${division.value.text} Division_button_title ${divisions_button_title.value}",
    );
  }

  // ==================== Hygiene ====================
  RxString hygiene_button_title = "Personal hygiene".obs;
  List<Map<String, dynamic>> hygiene_options = [
    {"hygiene": "Twice in a day", "value": 10},
    {"hygiene": "once in a day", "value": 8},
    {"hygiene": "once in a week", "value": 3},
    {"hygiene": "once in a month", "value": -5},
    {"hygiene": "once in a year", "value": -10},
    {"hygiene": "Shahbagi", "value": -20},
  ];

  void set_hygiene(int n, String s) {
    selfHygiene.value.text = n.toString();
    hygiene_button_title.value = s;
    print(
      "selfHygiene ${selfHygiene.value.text} selfHygiene_button_title ${hygiene_button_title.value}",
    );
  }

  // ==================== Rive Inputs ====================
  SMINumber? complexionInput;
  SMINumber? pantHeightInput;
  SMINumber? statesTriggerInput;
  SMINumber? manHeightInput;
  SMINumber? manBMIInput;

  void onRiveInit(Artboard artboard) {
    final StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'main');

    if (controller != null) {
      artboard.addController(controller);
      complexionInput = controller.getNumberInput('complexion');
      pantHeightInput = controller.getNumberInput('pantHeight');
      statesTriggerInput = controller.getNumberInput('statesTrigger');
      manHeightInput = controller.getNumberInput('manHeight');
      manBMIInput = controller.getNumberInput('manBMI');
    }
  }

  // ==================== Input Change Handlers ====================

  // void complexionChanged(String value) {
  //   complexionInput?.value = double.tryParse(complexion.value.text) ?? 0;
  // }

  // void pantHeightChanged(String value) {
  //   pantHeightInput?.value = double.tryParse(height.value.text) ?? 0;
  // }

  void statesTriggerChanged(String value) {
    statesTriggerInput?.value = double.tryParse(value) ?? 0;
  }

  // void manBMIChanged(String value) {
  //   manBMIInput?.value = double.tryParse(weight.text) ?? 0;
  // }

  // ==================== Main Logic ====================
  RxDouble dowryInt = 0.0.obs;
  RxInt stateI = 0.obs;
  void submit(BuildContext context) {
    switch (stateI.value) {
      case 0:
        changeAge();
        break;
      case 1:
        changeHeight();
        break;
      case 2:
        changeBMI();
        break;
      case 3:
        changeComplexion();
        break;
      case 4:
        changeSalary();
        break;
      case 5:
        changeWealth();
        break;
      case 6:
        // Handle case 6
        break;
      case 7:
        dowryInt.value = calculateDowry();
        trigger(context);
        break;
      case 8:
      default:
        // Handle any other cases or default behavior
        debugPrint("No matching case found for stateI: ${stateI.value}");
        return;
      // code if no cases match
    }
    stateI.value = stateI.value + 1; // Update state
  }

  void changeAge() {
    int parsedAge = int.tryParse(age.value.text) ?? 18;
    if (parsedAge < 18) {
      statesTriggerChanged("7"); // moch gone
      Future.delayed(const Duration(milliseconds: 10), () {
        statesTriggerChanged("9");
      });
    } else if (parsedAge >= 18 && parsedAge < 30) {
      statesTriggerChanged("7"); // moch gone
      Future.delayed(const Duration(milliseconds: 10), () {
        statesTriggerChanged("10");
      });
    } else if (parsedAge >= 30 && parsedAge < 40) {
      statesTriggerChanged("8"); // moch gone
      Future.delayed(const Duration(milliseconds: 10), () {
        statesTriggerChanged("9");
      });
    } else {
      // do nothing or handle age >= 40
    }
  }

  void changeHeight() {
    double parsedHeight = double.tryParse(height.value.text) ?? 152.4;

    // Clamp the value between 60 and 275
    parsedHeight = parsedHeight.clamp(125.0, 205.0);

    // Normalize: Map 125–205 to 0–20
    double normalizedHeight = ((parsedHeight - 125) / (205 - 125)) * 20;

    manHeightInput?.value = normalizedHeight;
  }

  void changeBMI() {
    double parsedWeight = double.tryParse(weight.text) ?? 60.0;
    double parsedHeight = double.tryParse(height.value.text) ?? 152.4;

    // Calculate BMI
    double bmi = parsedWeight / pow((parsedHeight / 100), 2);

    bmi = bmi.clamp(15.0, 40.0); // Clamp BMI between 15 and 40

    double temp_bmi = ((bmi - 15) / (40 - 15)) * (25);

    manBMIInput?.value = temp_bmi;
  }

  void changeComplexion() {
    int parsedComplexion = int.tryParse(complexion.value.text) ?? 3;
    double normalizedComplexion = ((parsedComplexion - 1) / 5) * 100;

    complexionInput?.value = normalizedComplexion;
  }

  void changeSalary() {
    double parsedSalary = double.tryParse(salary.text) ?? 5000;

    if (parsedSalary < 5000) {
      // Unemployed/Very Low Income - Naked
      statesTriggerChanged("0"); // khali ga (naked)
      pantHeightInput?.value = 0;
    } else if (parsedSalary >= 5000 && parsedSalary < 10000) {
      // Very Low Income - Basic pants only
      statesTriggerChanged("0"); // still naked torso
      pantHeightInput?.value = 30;
      Future.delayed(const Duration(milliseconds: 10), () {
        statesTriggerChanged("5"); // blue white pant (basic pants)
      });
    } else if (parsedSalary >= 10000 && parsedSalary < 20000) {
      // Low Income - Basic white shirt only (no pants upgrade)
      statesTriggerChanged("1"); // sendu (white shirt)
      pantHeightInput?.value = 0; // no pants
    } else if (parsedSalary >= 20000 && parsedSalary < 40000) {
      // Lower Middle Class - White shirt + better pants
      statesTriggerChanged("1"); // sendu (white shirt)
      pantHeightInput?.value = 100; // maximum pant height
      Future.delayed(const Duration(milliseconds: 10), () {
        statesTriggerChanged("4"); // black pant (better quality)
      });
    } else if (parsedSalary >= 40000 && parsedSalary < 60000) {
      // Middle Class - Brown shirt upgrade (keep black pants)
      statesTriggerChanged("2"); // brown shirt
      pantHeightInput?.value = 100; // maximum pant height
      Future.delayed(const Duration(milliseconds: 10), () {
        statesTriggerChanged("4"); // black pant
      });
    } else if (parsedSalary >= 60000 && parsedSalary < 80000) {
      // Upper Middle Class - Brown shirt + better fitted pants
      statesTriggerChanged("2"); // brown shirt
      pantHeightInput?.value = 100; // maximum pant height
      Future.delayed(const Duration(milliseconds: 10), () {
        statesTriggerChanged("4"); // black pant (better fit)
      });
    } else if (parsedSalary >= 80000 && parsedSalary < 100000) {
      // High Middle Class - Red shirt upgrade
      statesTriggerChanged("3"); // red shirt
      pantHeightInput?.value = 100; // maximum pant height
      Future.delayed(const Duration(milliseconds: 10), () {
        statesTriggerChanged("4"); // black pant
      });
    } else {
      // Very High Income (>100k) - Red shirt + luxury pants
      statesTriggerChanged("3"); // red shirt
      pantHeightInput?.value = 100; // maximum pant height
      Future.delayed(const Duration(milliseconds: 10), () {
        statesTriggerChanged("6"); // red black pant (luxury)
      });
    }
  }

  void changeWealth() {
    double parsedWealth = double.tryParse(wealthAmount.text) ?? 10000;

    if (parsedWealth >= 30000000) {
      statesTriggerChanged("14");
    } else {
      statesTriggerChanged("13");
    }
  }

  final GlobalKey artboardKey = GlobalKey();

  Future<Uint8List?> captureArtboard(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary;

      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 20));
        return captureArtboard(key); // Wait for next frame if not painted
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint("Error capturing screenshot: $e");
      return null;
    }
  }

  void showPoster(
    BuildContext context,
    Uint8List imageBytes,
    String dowryAmount,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Column(
            children: [
              Screenshot(
                controller: screenshotController,
                child: Container(
                  color: Colors.white,
                  width: 400,
                  height: 660, // slightly taller to fit buttons
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Image.memory(
                          imageBytes,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "Dowry: ৳$dowryAmount",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShareButtonWidget(controller: this),
                  DLButton(controller: this),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void trigger(BuildContext context) async {
    Uint8List? image = await captureArtboard(artboardKey);
    if (image != null) {
      showPoster(context, image, dowryInt.value.toStringAsFixed(0));
    }
  }

  double calculateDowry() {
    int parsedAge = int.tryParse(age.value.text) ?? 18;
    double parsedHeight = double.tryParse(height.value.text) ?? 152.4;
    double parsedWeight = double.tryParse(weight.text) ?? 60.0;
    int parsedComplexion = int.tryParse(complexion.value.text) ?? 3;
    double parsedSalary = double.tryParse(salary.text) ?? 5000;
    double parsedWealth = double.tryParse(wealthAmount.text) ?? 10000;
    int parsedDivision = int.tryParse(division.value.text) ?? 0;
    int parsedSelfHygiene = int.tryParse(selfHygiene.value.text) ?? 0;

    debugPrint(
      "Parsed Values: Age: $parsedAge, Height: $parsedHeight, "
      "Weight: $parsedWeight, Complexion: $parsedComplexion, "
      "Salary: $parsedSalary, Wealth: $parsedWealth, "
      "Division: $parsedDivision, Self Hygiene: $parsedSelfHygiene",
    );

    // Calculate BMI
    double bmi = parsedWeight / pow((parsedHeight / 100), 2);

    // Base dowry amount (realistic for BD context)
    double baseDowry = 35000; // 35k BDT base

    // Age factor (younger preferred, but not too young)
    double ageFactor = 0;
    if (parsedAge < 18) {
      ageFactor = -30000; // Heavily penalized
    } else if (parsedAge >= 18 && parsedAge <= 25) {
      ageFactor = 15000; // Prime age bonus
    } else if (parsedAge <= 30) {
      ageFactor = 5000; // Still good
    } else if (parsedAge <= 35) {
      ageFactor = -5000; // Slight penalty
    } else {
      ageFactor = -15000; // Higher penalty
    }

    // Height factor (taller generally preferred)
    double heightFactor = 0;
    if (parsedHeight >= 170) {
      heightFactor = 20000; // Tall bonus
    } else if (parsedHeight >= 165) {
      heightFactor = 10000; // Good height
    } else if (parsedHeight >= 160) {
      heightFactor = 5000; // Average
    } else if (parsedHeight >= 155) {
      heightFactor = 0; // Neutral
    } else {
      heightFactor = -10000; // Short penalty
    }

    // BMI factor (healthy weight preferred)
    double bmiFactor = 0;
    if (bmi >= 18.5 && bmi <= 24.9) {
      bmiFactor = 25000; // Healthy BMI bonus
    } else if (bmi >= 25 && bmi <= 29.9) {
      bmiFactor = 5000; // Slightly overweight
    } else if (bmi < 18.5) {
      bmiFactor = -5000; // Underweight penalty
    } else {
      bmiFactor = -25000; // Obese penalty
    }

    // Complexion factor (unfortunately still relevant in BD context)
    double complexionFactor =
        (parsedComplexion - 1) * 20000 - 50000; // -50k to +50k range

    // Salary factor (major component)
    // Salary factor (major component)
    double salaryFactor = 0;
    if (parsedSalary >= 100000) {
      salaryFactor = 200000; // Very high income
    } else if (parsedSalary >= 80000) {
      salaryFactor = 150000; // High income
    } else if (parsedSalary >= 60000) {
      salaryFactor = 100000; // Upper middle
    } else if (parsedSalary >= 40000) {
      salaryFactor = 75000; // Middle class
    } else if (parsedSalary >= 25000) {
      salaryFactor = 25000; // Lower middle - minimal positive
    } else if (parsedSalary >= 15000) {
      salaryFactor = 0; // Just breaking even
    } else if (parsedSalary >= 10000) {
      salaryFactor = -30000; // Low income penalty
    } else if (parsedSalary >= 5000) {
      salaryFactor = -50000; // Very low income penalty
    } else {
      salaryFactor = -75000; // Unemployed/extremely low income
    }
    // Wealth factor (family background)
    double wealthFactor = 0;
    if (parsedWealth >= 300000000) {
      wealthFactor = 1000000; // Ultra wealthy family (30+ crore)
    } else if (parsedWealth >= 100000000) {
      wealthFactor = 700000; // Extremely wealthy family (10-30 crore)
    } else if (parsedWealth >= 50000000) {
      wealthFactor = 500000; // Super wealthy family (5-10 crore)
    } else if (parsedWealth >= 10000000) {
      wealthFactor = 400000; // Very wealthy family (1-5 crore)
    } else if (parsedWealth >= 5000000) {
      wealthFactor = 300000; // Wealthy family (50 lakh - 1 crore)
    } else if (parsedWealth >= 3000000) {
      wealthFactor = -50000; // Below wealthy threshold penalty (30-50 lakh)
    } else if (parsedWealth >= 1000000) {
      wealthFactor = -100000; // Upper middle penalty (10-30 lakh)
    } else if (parsedWealth >= 500000) {
      wealthFactor = -150000; // Middle class penalty (5-10 lakh)
    } else if (parsedWealth >= 300000) {
      wealthFactor = -200000; // Lower middle penalty (3-5 lakh)
    } else if (parsedWealth >= 100000) {
      wealthFactor = -250000; // Working class penalty (1-3 lakh)
    } else if (parsedWealth >= 50000) {
      wealthFactor = -300000; // Poor penalty (50k-1 lakh)
    } else {
      wealthFactor = -400000; // Very poor family penalty (<50k)
    }

    // Division factor (economic prospects of different divisions)
    double divisionFactor = parsedDivision * 8000; // -40k to +96k range

    // Hygiene factor (personal grooming)
    double hygieneFactor = parsedSelfHygiene * 3000; // -60k to +30k range

    // Add some randomness for "negotiation" factor
    int random1 = Random().nextInt(50) + 1; // 1-50
    int random2 = Random().nextInt(30) + 1; // 1-30
    double randomFactor = (random1 - random2) * 1000; // -29k to +49k

    // Calculate final dowry
    double dowry =
        baseDowry +
        ageFactor +
        heightFactor +
        bmiFactor +
        complexionFactor +
        salaryFactor +
        wealthFactor +
        divisionFactor +
        hygieneFactor +
        randomFactor;

    // Cap maximum to keep it realistic, but allow negative values for humor
    dowry = dowry.clamp(-500000, 2000000); // -5 lakh to 20 lakh BDT

    return dowry;
  }

  Future<void> captureImage() async {
    // Set state to show loading indicator
    isCapturing = true;

    try {
      // Wait for the next frame to ensure rendering is complete
      await Future.delayed(Duration.zero);
      Uint8List? image = await screenshotController.capture();
      if (image != null) {
        capturedImage = image;
        debugPrint('Image captured successfully');
      } else {
        debugPrint('Failed to capture image');
      }
    } catch (e) {
      debugPrint('Error capturing image: $e');
      capturedImage = null;
    } finally {
      // Ensure the loading state is turned off
      isCapturing = false;
    }
  }

  Future<void> shareImage() async {
    await captureImage(); // Ensure the image is captured before sharing
    if (capturedImage == null) {
      debugPrint('No image to share');
      return;
    }

    try {
      // For web platform specifically
      if (kIsWeb) {
        try {
          // Create a temp file for sharing
          final xFile = XFile.fromData(
            capturedImage!,
            name: 'dowry_poster.png',
            mimeType: 'image/png',
          );

          // Try using Web Share API
          // ignore: deprecated_member_use
          final shareResult = await Share.shareXFiles(
            [xFile],
            text:
                'সংস্কারের লক্ষ্যে গঠিত জাতীয় ঐকমত্য কমিশন এর সুপারিশগুলোর বিষয়ে আপনার অবস্থান কোথায়? 🧐\nএকটা ছোট কুইজ দিচ্ছি, আপনার মতামতকে রাজনৈতিক দলগুলোর প্রস্তাবিত সংস্কারের সঙ্গে মিলিয়ে দেখুন।\nএই ছবিতে আমার রেজাল্ট! 🗳️\nআপনিও দেখে নিন আপনার অবস্থান 👉 https://sohomotvai.despicableapp.com/',
            subject: 'সহমত ভাইয়ের সাথে দেখুন আপনি কোথায় দাঁড়িয়ে।',
          );

          debugPrint('Share result: ${shareResult.status}');
        } catch (webError) {
          debugPrint('Web Share API unavailable: $webError');
          debugPrint('Falling back to download method');
          downloadImage(); // Call your existing download method as fallback
        }
      }
    } catch (e) {
      debugPrint('Error sharing image: $e');

      // Fallback for browsers that don't support Web Share API
      if (kIsWeb) {
        debugPrint('Sharing failed, attempting fallback download.');
        downloadImage();
      }
    }
  }

  Future<void> downloadImage() async {
    // Ensure the image is captured before downloading
    await captureImage(); // Ensure the image is captured before downloading
    // Check if an image has been captured
    if (capturedImage == null) {
      debugPrint('No image to download');
      Get.snackbar(
        'No Image Captured',
        'Please capture an image first!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // Ensure this runs only on the web
    if (kIsWeb) {
      try {
        // 1. Encode image bytes to Base64
        final base64 = base64Encode(capturedImage!);

        // 2. Create a data URL (RFC 2397)
        final dataUrl = 'data:image/png;base64,$base64';

        // 3. Create an invisible HTML anchor element (`<a>`)
        final anchor = html.AnchorElement(href: dataUrl)
          // 4. Set the 'download' attribute with a filename
          ..setAttribute(
            "download",
            // Generate a somewhat unique filename
            "dowry_poster_${DateTime.now().millisecondsSinceEpoch}.png",
          );

        // 5. Programmatically click the anchor to trigger the download
        // Append to body, click, then remove is a common pattern,
        // though sometimes direct click() works.
        html.document.body?.append(anchor);
        anchor.click();
        anchor.remove(); // Clean up the element

        debugPrint('Download initiated.');
      } catch (e) {
        debugPrint('Error initiating download: $e');
        Get.snackbar(
          'Download Error',
          'Could not download image. Error: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } else {
      debugPrint('Download function is intended for web only.');
      // Optionally show a message on non-web platforms
      Get.snackbar(
        'Download Unavailable',
        'This feature is only available on the web version.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
