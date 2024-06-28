import 'package:attendance_app/app/modules/home/components/customschedule.dart';
import 'package:attendance_app/app/modules/home/views/history_page.dart';
import 'package:attendance_app/app/modules/home/views/user_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.changePage(index);
        },
        children: [
          HomePage(),
          HistoryPage(),
          UserPage(),
        ],
      ),
      bottomNavigationBar: Obx(() => Container(
            height: 80,
            child: BottomNavigationBar(
              elevation: 10,
              currentIndex: controller.currentIndex.value,
              onTap: (index) {
                controller.changePage(index);
                controller.pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'User',
                ),
              ],
              iconSize: 28,
            ),
          )),
    );
  }
}

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            17.0,
            MediaQuery.of(context).padding.top + 20.0,
            17.0,
            12.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Name
              Text(
                'Calvin Widi Pratama',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              // Role / Job
              Text(
                'UI / UX Designer',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              // Clock and Date
              Obx(
                () => Text(
                  '${controller.currentTime.value.hour.toString().padLeft(2, '0')}:${controller.currentTime.value.minute.toString().padLeft(2, '0')}:${controller.currentTime.value.second.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
              Obx(() => Text(
                    '${controller.getDayName(controller.currentTime.value.weekday)}, ${controller.currentTime.value.day} ${controller.getMonthName(controller.currentTime.value.month)} ${controller.currentTime.value.year}',
                    style: TextStyle(fontSize: 20.0),
                  )),
              SizedBox(
                height: 20,
              ),
              //Scan
              InkWell(
                child: Container(
                  height: 240,
                  width: 230,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/checkin.png',
                        scale: 3.8,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Check-in",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Keterangan
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 238, 188),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Kamu Belum Check-in Hari ini !',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber[700],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // jadwal
              Container(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Start
                    CustomSchedule(
                      icon: Icons.access_time,
                      time: '08.30 - 09.30',
                      info: 'Check-In',
                    ),
                    Image.asset('assets/Line.png'),
                    // End
                    CustomSchedule(
                      icon: Icons.access_time,
                      time: '20.30 - 21.30',
                      info: 'Check-out',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
