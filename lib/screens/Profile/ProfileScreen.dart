import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String id = '22BCE1621';
  String name = "Aswin Raaj P S";
  String emailId = "aswinraaj.ps2022@vitstudent.ac.in";
  String phoneNumber = "9566875400";
  String roomNo = '219';
  String hostelBlock = 'D1';
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
              onTap: () {
                Navigator.pushNamed(context, '/room');
              },
              child: Image.asset("assets/Icons/cleaning_outline.png"),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset("assets/Icons/profile_filled.png"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF2B3B4E),
        title: Text(
          "Profile",
          style: GoogleFonts.inter(
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 30.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/Icons/id.png',
                      height: 23.h,
                      width: 23.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ID",
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.65),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        id,
                        style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Divider(
                        color: const Color(0xFF2B3B4E).withOpacity(0.45),
                        height: 1,
                        thickness: 1,
                      )
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/Icons/user.png',
                      height: 23.h,
                      width: 23.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.65),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        name,
                        style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Divider(
                        color: const Color(0xFF2B3B4E).withOpacity(0.45),
                        height: 1,
                        thickness: 1,
                      )
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/Icons/email.png',
                      height: 23.h,
                      width: 23.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Id",
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.65),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        emailId,
                        style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Divider(
                        color: const Color(0xFF2B3B4E).withOpacity(0.45),
                        height: 1,
                        thickness: 1,
                      )
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/Icons/phone.png',
                      height: 23.h,
                      width: 23.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number",
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.65),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        phoneNumber,
                        style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Divider(
                        color: const Color(0xFF2B3B4E).withOpacity(0.45),
                        height: 1,
                        thickness: 1,
                      )
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/Icons/room.png',
                      height: 23.h,
                      width: 23.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Room Number",
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.65),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        roomNo,
                        style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Divider(
                        color: const Color(0xFF2B3B4E).withOpacity(0.45),
                        height: 1,
                        thickness: 1,
                      )
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/Icons/hostel.png',
                      height: 23.h,
                      width: 23.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hostel Block",
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.65),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        hostelBlock,
                        style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Divider(
                        color: const Color(0xFF2B3B4E).withOpacity(0.45),
                        height: 1,
                        thickness: 1,
                      )
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    side: MaterialStateProperty.all(
                        BorderSide(color: Color(0xFF59718F), width: 2)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    minimumSize: MaterialStateProperty.all(Size(300.w, 50.h)),
                  ),
                  onPressed: () {
                    //After validating
                  },
                  child: Text(
                    "Change Password",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      color: const Color(0xFF59718F),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    side: MaterialStateProperty.all(
                        BorderSide(color: Color(0xFF59718F), width: 2)),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF59718F)),
                    minimumSize: MaterialStateProperty.all(Size(300.w, 50.h)),
                  ),
                  onPressed: () {
                    //Logging Out
                  },
                  child: Text(
                    "Log Out",
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
        ),
      )),
    );
  }
}
