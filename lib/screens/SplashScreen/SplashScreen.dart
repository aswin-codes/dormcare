import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<String> imagePaths = [
    "assets/Images/laundryVector.png",
    "assets/Images/complaint_vector.png",
    "assets/Images/cleaning_vector.png",
  ];
  List<String> titles = [
    "Laundry Scheduler",
    "Complaint Box",
    "Room Maintainance",
  ];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < imagePaths.length - 1) {
        setState(() {
          _currentPage++;
        });
      } else {
        setState(() {
          _currentPage = 0;
        });
      }
      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 200), curve: Curves.easeOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E4F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 70.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DormCare",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                "Once place solution for Hostel Issues",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              SizedBox(
                height: 300.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image.asset(
                          imagePaths[index],
                          height: 262.h,
                          width: 262.h,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          titles[index],
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      height: 10.h,
                      width: 10.h,
                      decoration: BoxDecoration(
                          color: _currentPage == 0
                              ? const Color(0xFF252525)
                              : const Color(0xFF929292)),
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  ClipOval(
                    child: Container(
                      height: 10.h,
                      width: 10.h,
                      decoration: BoxDecoration(
                          color: _currentPage == 1
                              ? const Color(0xFF252525)
                              : const Color(0xFF929292)),
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  ClipOval(
                    child: Container(
                      height: 10.h,
                      width: 10.h,
                      decoration: BoxDecoration(
                          color: _currentPage == 2
                              ? const Color(0xFF252525)
                              : const Color(0xFF929292)),
                    ),
                  )
                ],
              ),
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF59718F)),
                        minimumSize:
                            MaterialStateProperty.all(Size(300.w, 50.h))),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
