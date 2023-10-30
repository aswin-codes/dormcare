import 'dart:convert';

import 'package:dormcare/screens/Complaint/ComplaintModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  List<Complaint> complaintList = [];

  Future<void> initialFetch() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:8000/complain/"));
      if (response.statusCode == 200) {
        final List<dynamic> respBody = jsonDecode(response.body);

        final List<Complaint> newComplaintList = respBody.map((element) {
          print(element['id']);
          return Complaint(
            id: element['id'],
            date: element['date'],
            time: element['time'],
            complaint: element['complaints'],
            likes: element['likes'],
            status: element['status'],
          );
        }).toList();
        print(newComplaintList);
        setState(() {
          complaintList.clear();
          complaintList.addAll(newComplaintList);
        });
      } else {
        // Handle the response status code or errors here
      }
    } catch (error) {
      // Handle exceptions, e.g., network issues
      print("Error: $error");
    }
  }

  Color returnStatus(String status) {
    if (status == "Posted") {
      return const Color(0xFFBCBCBC);
    } else if (status == "Under Process") {
      return const Color(0xFFBDA76E);
    } else {
      return const Color(0xFF239035);
    }
  }

  Future<void> makeRequest(Complaint complaint) async {
    Map<String, dynamic> body = {
      'date': complaint.date,
      'time': complaint.time,
      'complaints': complaint.complaint,
      'likes': complaint.likes,
      'status': complaint.status
    };
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/complain/"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body));
    initialFetch();
  }

  Future<void> _showAddComplaintDialog() async {
    String newComplaint = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2B3B4E), // Set the background color
          title: Text(
            'Add Complaint',
            style: GoogleFonts.inter(
              color: Colors.white, // Set text color
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  newComplaint = value;
                },
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Complaint',
                  labelStyle: GoogleFonts.inter(
                    color: Colors.white, // Set label text color
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: Colors.white, // Set text color
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (newComplaint.isNotEmpty) {
                  // Get the current date and time
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('dd MMM yyyy').format(now);
                  String formattedTime = DateFormat('HH:mm').format(now);

                  // Create a new complaint
                  Complaint newComplaintItem = Complaint(
                    id: 0,
                    date: formattedDate,
                    time: formattedTime,
                    complaint: newComplaint,
                    likes: 0,
                    status: 'Posted',
                  );
                  makeRequest(newComplaintItem);

                  // Add the new complaint to the list
                  setState(() {
                    complaintList.add(newComplaintItem);
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text(
                'Add',
                style: GoogleFonts.inter(
                  color: Colors.white, // Set text color
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> incrementLike(int id) async {
    print(id);
    final response =
        await http.post(Uri.parse("http://10.0.2.2:8000/complain/${id}"));
  }

  @override
  void initState() {
    // TODO: implement initState
    initialFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFD4E4F7),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: const Color(0xFF7C8DA0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Image.asset("assets/Icons/laundry_outline.png"),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset("assets/Icons/complaint_filled.png"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/room');
                },
                child: Image.asset("assets/Icons/cleaning_outline.png"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: Image.asset("assets/Icons/profile_outline.png"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: const Color(0xFF2B3B4E),
          title: Text(
            "Complaints",
            style: GoogleFonts.inter(
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF7C8DA0),
          onPressed: () {
            _showAddComplaintDialog();
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: complaintList
                              .where((element) =>
                                  element.status == "Under Process")
                              .toList()
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            List<Complaint> underProcess = complaintList
                                .where((element) =>
                                    element.status == "Under Process")
                                .toList();
                            return Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF2B3B4E),
                                  borderRadius: BorderRadius.circular(12.r)),
                              padding: EdgeInsets.all(15.h),
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        underProcess[index].date,
                                        style: GoogleFonts.inter(
                                            fontSize: 9.sp,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        underProcess[index].time,
                                        style: GoogleFonts.inter(
                                            fontSize: 9.sp,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    underProcess[index].complaint,
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFE3E3E3)
                                                .withOpacity(0.43),
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                incrementLike(
                                                    underProcess[index].id);
                                                setState(() {
                                                  underProcess[index].likes++;
                                                });
                                              },
                                              child: Icon(
                                                Icons.thumb_up_alt_rounded,
                                                size: 20.h,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.h,
                                            ),
                                            Text(
                                              underProcess[index]
                                                  .likes
                                                  .toString(),
                                              style: GoogleFonts.inter(
                                                  fontSize: 16.sp,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: returnStatus(
                                              underProcess[index].status),
                                          borderRadius:
                                              BorderRadius.circular(3.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        child: Text(
                                          underProcess[index].status,
                                          style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: complaintList
                              .where((element) => element.status == "Posted")
                              .toList()
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            List<Complaint> underProcess = complaintList
                                .where((element) => element.status == "Posted")
                                .toList();
                            return Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF2B3B4E),
                                  borderRadius: BorderRadius.circular(12.r)),
                              padding: EdgeInsets.all(15.h),
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        underProcess[index].date,
                                        style: GoogleFonts.inter(
                                            fontSize: 9.sp,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        underProcess[index].time,
                                        style: GoogleFonts.inter(
                                            fontSize: 9.sp,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    underProcess[index].complaint,
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFE3E3E3)
                                                .withOpacity(0.43),
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                incrementLike(
                                                    underProcess[index].id);
                                                setState(() {
                                                  underProcess[index].likes++;
                                                });
                                              },
                                              child: Icon(
                                                Icons.thumb_up_alt_rounded,
                                                size: 20.h,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.h,
                                            ),
                                            Text(
                                              underProcess[index]
                                                  .likes
                                                  .toString(),
                                              style: GoogleFonts.inter(
                                                  fontSize: 16.sp,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: returnStatus(
                                              underProcess[index].status),
                                          borderRadius:
                                              BorderRadius.circular(3.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        child: Text(
                                          underProcess[index].status,
                                          style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: complaintList
                              .where((element) => element.status == "Completed")
                              .toList()
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            List<Complaint> underProcess = complaintList
                                .where(
                                    (element) => element.status == "Completed")
                                .toList();
                            return Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF2B3B4E),
                                  borderRadius: BorderRadius.circular(12.r)),
                              padding: EdgeInsets.all(15.h),
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        underProcess[index].date,
                                        style: GoogleFonts.inter(
                                            fontSize: 9.sp,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        underProcess[index].time,
                                        style: GoogleFonts.inter(
                                            fontSize: 9.sp,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    underProcess[index].complaint,
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFE3E3E3)
                                                .withOpacity(0.43),
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                incrementLike(
                                                    underProcess[index].id);
                                                setState(() {
                                                  underProcess[index].likes++;
                                                });
                                              },
                                              child: Icon(
                                                Icons.thumb_up_alt_rounded,
                                                size: 20.h,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.h,
                                            ),
                                            Text(
                                              underProcess[index]
                                                  .likes
                                                  .toString(),
                                              style: GoogleFonts.inter(
                                                  fontSize: 16.sp,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: returnStatus(
                                              underProcess[index].status),
                                          borderRadius:
                                              BorderRadius.circular(3.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        child: Text(
                                          underProcess[index].status,
                                          style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        height: 50.h,
                      ),
                    ],
                  ),
                ))));
  }
}
