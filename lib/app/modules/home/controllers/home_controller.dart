import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  PageController pageController = PageController();
  var currentTime = DateTime.now().obs;
  var name = ''.obs;
  var email = ''.obs;
  var checkInTime = ''.obs;
  var checkOutTime = ''.obs;
  var isScanEnabled = false.obs;
  var qrResult = ''.obs;
  var isCheckedIn = false.obs;
  var isCheckedOut = false.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex.value);
    updateCurrentTime();
    loadUserData();
    fetchSchedule();
    checkIfCheckedIn();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changePage(int index) {
    currentIndex.value = index;
  }

  void updateCurrentTime() {
    // Panggil fungsi ini setiap detik untuk memperbarui waktu
    Future.delayed(Duration(seconds: 1), () {
      currentTime(DateTime.now());
      updateCurrentTime();
    });
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? '';
    email.value = prefs.getString('email') ?? '';
    checkIfCheckedIn();
  }

  Future<void> fetchSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    var response = await http.get(
      Uri.parse('http://192.168.1.4:8000/api/schedule/absen'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var schedule = data['data']['schedule_absen'].last;
      checkInTime.value = schedule['time_check_in'];
      checkOutTime.value = schedule['time_check_out'];

      updateScanStatus();
      print(checkInTime.value);
      print(checkOutTime.value);
    } else {
      Get.snackbar('Error', 'Failed to fetch schedule.');
    }
  }

  void updateScanStatus() {
    DateTime now = DateTime.now();
    DateTime checkIn = DateTime.parse(
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${checkInTime.value}');
    DateTime checkOut = DateTime.parse(
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${checkOutTime.value}');

    isScanEnabled.value = now.isBefore(checkIn) ||
        (now.isAfter(checkIn) && now.isAfter(checkOut));
  }

  void setQrResult(String? result) {
    qrResult.value = result ?? "";
  }

  // Checkin
  Future<void> postQrResult(String result) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    var response = await http.post(
      Uri.parse('http://192.168.1.4:8000/api/absen/checkin'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      // body: jsonEncode({'unique_id': result}),
      body: {
        'unique_id': result,
        'latitude': "-6.235123676424985",
        'longitude': '106.78903658424991'
      },
    );

    if (response.statusCode == 200) {
      var data2 = jsonDecode(response.body);
      qrResult.value = result;
      isCheckedIn.value = true;
      Get.snackbar('Success', 'Check-in successful.${response.statusCode}');
      print(data2);
      // Save check-in status
      // prefs.setBool('isCheckedIn', true);
      prefs.setBool('isCheckedIn_${email.value}', true);
    } else {
      var dataerr = jsonDecode(response.body);
      Get.snackbar('Error',
          'Failed to check-in.${dataerr["status_code"]}\n${dataerr["message"]}');
    }
  }

  // Check Out
  Future<void> postCheckout(String result) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    var response = await http.post(
      Uri.parse('http://192.168.1.4:8000/api/absen/checkout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      // body: jsonEncode({'unique_id': result}),
      body: {
        'unique_id': result,
        'latitude': "-6.235123676424985",
        'longitude': '106.78903658424991'
      },
    );

    if (response.statusCode == 200) {
      var data2 = jsonDecode(response.body);
      qrResult.value = result;
      isCheckedOut.value = true;
      Get.snackbar('Success', 'Check-Out successful.${response.statusCode}');
      print(data2);
      // Save check-in status
      // prefs.setBool('isCheckedIn', true);
      prefs.setBool('isCheckedOut_${email.value}', true);
    } else {
      var dataerr = jsonDecode(response.body);
      Get.snackbar('Error',
          'Failed to check-in.${dataerr["status_code"]}\n${dataerr["message"]}');
    }
  }

  void handleScanResult(String scanData) {
    final data = jsonDecode(scanData);
    final uniqueId = data['unique_id'];

    DateTime now = DateTime.now();
    DateTime checkIn = DateTime.parse(
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${checkInTime.value}');
    DateTime checkOut = DateTime.parse(
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${checkOutTime.value}');

    if (now.isBefore(checkIn) && !isCheckedIn.value) {
      print("Check in");
      postQrResult(uniqueId);
    } else {
      postCheckout(uniqueId);
      print("Check Out");
    }
  }

  Future<void> checkIfCheckedIn() async {
    // This function should be used to check if the user has already checked in
    // You can implement this by checking local storage or an API call
    final prefs = await SharedPreferences.getInstance();
    // isCheckedIn.value = prefs.getBool('isCheckedIn') ?? false;
    isCheckedIn.value = prefs.getBool('isCheckedIn_${email.value}') ?? false;
    isCheckedOut.value = prefs.getBool('isCheckedOut_${email.value}') ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    // save login state for user
    await prefs.setBool('isCheckedIn_${email.value}', isCheckedIn.value);
    await prefs.setBool('isCheckedOut_${email.value}', isCheckedOut.value);
    await prefs.remove('isLoggedIn');
    Get.offAllNamed(Routes.LOGIN);
  }

  String getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return 'Jumat';
      case 6:
        return 'Sabtu';
      case 7:
        return 'Minggu';
      default:
        return '';
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }
}
