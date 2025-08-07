// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'dart:math' show Random, max, pow;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' hide Image;
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;

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
    {"division": "Dhaka", "value": 12},
    {"division": "Khulna", "value": 9},
    {"division": "Mymensingh", "value": 6},
    {"division": "Noakhali", "value": -3},
    {"division": "Rajshahi", "value": 8},
    {"division": "Rangpur", "value": 7},
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

    double bmi = parsedWeight / pow((parsedHeight / 100), 2);

    int random1 = Random().nextInt(100) + 1;
    int random2 = Random().nextInt(100) + 1;
    int random3 = Random().nextInt(100) + 1;

    double dowry =
        20000 +
        (parsedAge * -200) +
        ((parsedHeight - 152.4) * (parsedHeight - 152.4) * 50) -
        ((21 - bmi).abs() * 7526) +
        (pow(2, parsedComplexion) * 5000) +
        (pow(parsedSalary, 1.5) * 0.01) +
        (pow(parsedWealth, 1.5) * 0.01) +
        (parsedDivision * 5000) +
        (parsedSelfHygiene * 5000) +
        (((random1 % random2) + random3) % 7 * 2024);

    dowry = max(5000, dowry);
    return dowry;
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

    if (parsedWealth >= 300000) {
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
        content: SizedBox(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await saveImage(imageBytes);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            result != null
                                ? 'Poster saved to $result'
                                : 'Failed to save poster',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.download),
                    label: const Text("Download"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await saveImage(imageBytes);
                      if (result != null) {
                        final params = ShareParams(
                          text: 'Check out my dowry poster 😎',
                          files: [XFile(result)],
                        );
                        final shareResult = await SharePlus.instance.share(
                          params,
                        );
                        if (shareResult.status == ShareResultStatus.success) {
                          debugPrint('Successfully shared the poster!');
                        }
                      }
                    },
                    icon: const Icon(Icons.share),
                    label: const Text("Share"),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> saveImage(Uint8List imageBytes) async {
    try {
      // Create a blob from the Uint8List
      final blob = html.Blob([imageBytes], 'image/png');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Create a temporary anchor element to trigger download
      final _ = html.AnchorElement(href: url)
        ..setAttribute(
          'download',
          'dowry_poster_${DateTime.now().millisecondsSinceEpoch}.png',
        )
        ..click();

      // Clean up
      html.Url.revokeObjectUrl(url);
      debugPrint("Image download triggered");
      return url; // Return the URL for potential sharing
    } catch (e) {
      debugPrint("Error saving image: $e");
      return null;
    }
  }

  void trigger(BuildContext context) async {
    Uint8List? image = await captureArtboard(artboardKey);
    if (image != null) {
      showPoster(context, image, dowryInt.value.toStringAsFixed(0));
    }
  }
}
