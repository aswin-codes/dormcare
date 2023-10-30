import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomMaintenance extends StatefulWidget {
  const RoomMaintenance({super.key});

  @override
  State<RoomMaintenance> createState() => _RoomMaintenanceState();
}

class _RoomMaintenanceState extends State<RoomMaintenance> {
  //Get from Shared Preferences
  String hostelBlock = "";
  String roomNo = "";

  //State variables for room maintenance (Node JS)
  bool isDone = false;

  Future<void> initialFetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? hostelblock = await prefs.getString('hostel_block');
    String? roomno = await prefs.getString('room_number');
    setState(() {
      hostelBlock = hostelblock!;
      roomNo = roomno!;
    });
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
              onTap: () {
                Navigator.pushNamed(context, '/complaint');
              },
              child: Image.asset("assets/Icons/complaint_outline.png"),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset("assets/Icons/cleaning_filled.png"),
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
          "Room Maintenance",
          style: GoogleFonts.inter(
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2B3B4E),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hostelBlock + " Block",
                          style: GoogleFonts.inter(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                        Text(
                          roomNo,
                          style: GoogleFonts.inter(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.5)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/Images/sweeping_vector.png",
                          height: 100.h,
                          width: 100.h,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: isDone
                                ? const Color(0xFF38E635).withOpacity(0.51)
                                : Color(0xFFA19D9D).withOpacity(0.35),
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          height: 100.h,
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    isDone ? "DONE" : "NOT DONE",
                                    style: GoogleFonts.inter(
                                        fontSize: 25.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(
                      color: const Color(0xFFCBCBCB).withOpacity(0.31),
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF11941E)),
                          minimumSize:
                              MaterialStateProperty.all(Size(300.w, 50.h)),
                        ),
                        onPressed: () {
                          //After Validating
                          setState(() {
                            isDone = true;
                          });
                        },
                        child: Text(
                          "Mark As Done",
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFBE1B1B)),
                          minimumSize:
                              MaterialStateProperty.all(Size(300.w, 50.h)),
                        ),
                        onPressed: () {
                          //After Validating
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text(
                          "Raise Complaint",
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
