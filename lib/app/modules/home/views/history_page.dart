import 'package:attendance_app/app/modules/home/controllers/home_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HistoryPage extends StatelessWidget {
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                17.0,
                MediaQuery.of(context).padding.top + 20.0,
                17.0,
                5.0,
              ),
              child: Column(
                children: [
                  Text(
                    'Attendance History',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Colors.black,
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Peforma Kehadiran',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Percent Progress
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          double percentage =
                              controller.attendancePercentage.value;
                          return CircularPercentIndicator(
                            radius: 70.0,
                            lineWidth: 15.0,
                            percent: percentage / 100,
                            center: Text(
                              "${percentage.toStringAsFixed(1)}%",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.blue,
                          );
                        }),
                        SizedBox(
                          width: 20,
                        ),
                        // User Detail
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.name.value,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              // Role / Job
                              Text(
                                controller.email.value,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Obx(() => AttendanceDetail(
                                    info: 'Attendance',
                                    score: controller.attendanceHistory.length
                                        .toString(),
                                    warna: Colors.black,
                                  )),
                              Obx(() => AttendanceDetail(
                                    info: 'Presents',
                                    score: controller.attendancepresent.value
                                        .toString(),
                                    warna: Colors.green,
                                  )),
                              Obx(() => AttendanceDetail(
                                    info: 'Absence',
                                    score: controller.attendanceabsent.value
                                        .toString(),
                                    warna: Colors.red,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Colors.black,
                    height: 15,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'History',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.sort,
                      color: Colors.blue,
                      weight: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Table
            Obx(() {
              if (controller.attendanceHistory.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(
                          0.5,
                          0.5,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Column(
                    children: [
                      // TimeLine
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              weight: 12,
                            ),
                          ),
                          Text(
                            'Recap',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              weight: 12,
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(() {
                          if (controller.attendanceHistory.isEmpty) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return DataTable(
                            columnSpacing:
                                MediaQuery.of(context).size.width * 0.08,
                            // horizontalMargin: 12,
                            headingRowColor: MaterialStatePropertyAll(
                                const Color.fromARGB(255, 218, 238, 255)),
                            columns: [
                              DataColumn(
                                label: Text('Date'),
                              ),
                              DataColumn(
                                label: Text('Check In'),
                              ),
                              DataColumn(
                                label: Text('Check Out'),
                              ),
                              DataColumn(
                                label: Text('Working Hr\'s'),
                              ),
                            ],
                            dataRowMinHeight: 40,
                            dataRowMaxHeight: 80,

                            // horizontalMargin: 12,
                            // dataRowHeight: 60,
                            rows: controller.attendanceHistory.map((history) {
                              return DataRow(cells: [
                                DataCell(DayTable(
                                    dateTimeString: history['created_at'])),
                                DataCell(CheckAttandanceTable(
                                    time: history['check_in'] ?? 'N/A',
                                    isCheckin: true)),
                                DataCell(CheckAttandanceTable(
                                    time: history['check_out'] ?? 'N/A',
                                    isCheckin: false)),
                                DataCell(WorksHourTable(
                                    workingHours:
                                        history['total_time'] ?? 'N/A')),
                              ]);
                            }).toList(),
                          );
                        }),
                      )
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class WorksHourTable extends StatelessWidget {
  final String workingHours;
  const WorksHourTable({
    super.key,
    required this.workingHours,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        workingHours,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white60,
        ),
      ),
    );
  }
}

class CheckAttandanceTable extends StatelessWidget {
  final String time;
  final bool isCheckin;
  const CheckAttandanceTable({
    super.key,
    required this.time,
    required this.isCheckin,
  });

  String _formatTime(String time) {
    try {
      DateTime dateTime = DateTime.parse(time);
      return DateFormat('HH:mm').format(dateTime);
    } catch (e) {
      return '--:--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isCheckin
              ? Icons.arrow_outward
              : Icons.subdirectory_arrow_right_sharp,
          color: isCheckin ? Colors.green : Colors.red,
          weight: 20,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          _formatTime(time),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class DayTable extends StatelessWidget {
  final String dateTimeString;
  const DayTable({
    super.key,
    required this.dateTimeString,
  });

  String _formatDate(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('dd').format(dateTime);
    } catch (e) {
      return '--';
    }
  }

  String _formatDay(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('EEE').format(dateTime);
    } catch (e) {
      return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                _formatDate(dateTimeString),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(_formatDay(dateTimeString)),
            ],
          )),
    );
  }
}

class AttendanceDetail extends StatelessWidget {
  final String info;
  final String score;
  final Color warna;
  const AttendanceDetail({
    super.key,
    required this.info,
    required this.score,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            info,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: warna,
            ),
          ),
          // SizedBox(
          //   width: 12,
          // ),
          Text(
            score,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: warna,
            ),
          ),
        ],
      ),
    );
  }
}
