import 'dart:convert';

import 'package:dormcare/screens/HomeScreen/Clothes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String greetText = '';
  //Get from Shared Preferences
  String userName = "";
  String RegNo = '';
  String roomNo = '';
  //States for laundry Backend
  bool isClothesGiven = false;
  bool isSlot = false;
  String status = 'NOT GIVEN';
  bool isClothesAdding = false;
  String nextSlot = '22 Dec 2023';

  List<Clothes> clothesList = [];

  Future<void> initialFetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = await prefs.getString('username');
    String? regno = await prefs.getString('registration_number');
    String? roomno = await prefs.getString('room_number');

    final response = await http
        .get(Uri.parse("http://10.0.2.2:3000/laundry/status/${regno}"));

    final lstatus = jsonDecode(response.body)['status'];
    print(lstatus);

    if (lstatus == 'NOT GIVEN') {
      setState(() {
        userName = username!;
        RegNo = regno!;
        roomNo = roomno!;
        status = lstatus;
      });
    } else {
      print("ji");
      final response = await http
          .get(Uri.parse("http://10.0.2.2:3000/laundry/details/$regno"));
      final respBody = jsonDecode(response.body);
      final lstatus = respBody['status'];
      final Map<String, dynamic> clothesMap = respBody['clothes'];
      final List<Clothes> newclothesList = clothesMap.entries
          .map((entry) => Clothes(count: entry.value as int, type: entry.key))
          .toList();
      setState(() {
        isClothesGiven = true;
        userName = username!;
        RegNo = regno!;
        roomNo = roomno!;
        status = lstatus;
        clothesList = newclothesList;
      });
    }
  }

  Future<void> showClothesDialog() async {
    String clothType = '';
    int clothCount = 0;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2B3B4E), // Set the background color
          title: Text(
            'Add Cloth',
            style: GoogleFonts.inter(
              color: Colors.white, // Set text color
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  clothType = value;
                },
                decoration: InputDecoration(
                  labelText: 'Cloth Type',
                  labelStyle: GoogleFonts.inter(
                    color: Colors.white, // Set label text color
                  ),
                ),
              ),
              TextField(
                onChanged: (value) {
                  clothCount = int.tryParse(value) ?? 0;
                },
                decoration: InputDecoration(
                  labelText: 'Count',
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
                if (clothType.isNotEmpty && clothCount > 0) {
                  setState(() {
                    clothesList
                        .add(Clothes(count: clothCount, type: clothType));
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

  void setGreeting() {
    int hour = DateTime.now().hour;
    if (hour >= 6 && hour <= 12) {
      setState(() {
        greetText = "Good morning";
      });
    } else if (hour <= 16) {
      setState(() {
        greetText = "Good afternoon";
      });
    } else if (hour <= 20) {
      setState(() {
        greetText = "Good evening";
      });
    } else {
      setState(() {
        greetText = "Good night";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setGreeting();
    initialFetch();
    super.initState();
  }

  Color returnStatus() {
    if (status == 'NOT GIVEN' || status == 'GIVEN') {
      return Color(0xFFA19D9D).withOpacity(0.350);
    } else if (status == 'PROCESS') {
      return Color(0xFFCBDA8D).withOpacity(0.35);
    } else {
      return Color(0xFF38E635).withOpacity(0.35);
    }
  }

  Future<void> addLaundry() async {
    final laundryData = LaundryData(
        regNo: RegNo,
        roomNo: roomNo,
        status: 'GIVEN',
        clothesList: clothesList);
    final jsonData = jsonEncode(laundryData);
    final response = await http.post(Uri.parse("http://10.0.2.2:3000/laundry/"),
        headers: {'Content-Type': 'application/json'}, body: jsonData);
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
              onTap: () {},
              child: Image.asset("assets/Icons/laundry_filled.png"),
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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greetText + ',',
              style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.black),
            ),
            Text(
              userName,
              style: GoogleFonts.inter(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/announcements');
              },
              child: Image.asset(
                'assets/Icons/Announcement.png',
                height: 35.h,
                width: 35.h,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
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
              !isClothesAdding && !isClothesGiven
                  ? Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF81A0C5),
                          borderRadius: BorderRadius.all(Radius.circular(7.r))),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "You can give your clothes now",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xFF4B5765),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Next",
                      style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      nextSlot,
                      style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF2B3B4E),
                    borderRadius: BorderRadius.circular(10.r)),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          RegNo,
                          style: GoogleFonts.inter(
                              color: const Color(0xFF949494).withOpacity(0.76),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          roomNo,
                          style: GoogleFonts.inter(
                              color: const Color(0xFF949494).withOpacity(0.76),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/Images/washingMachine.png',
                          height: 100.h,
                          width: 100.h,
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        Expanded(
                            child: Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                              color: returnStatus(),
                              borderRadius: BorderRadius.circular(7.r)),
                          padding: EdgeInsets.all(10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status",
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    status,
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: clothesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color(0xFF707070),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  clothesList[index].type,
                                  style: GoogleFonts.inter(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                Text(
                                  clothesList[index].count.toString(),
                                  style: GoogleFonts.inter(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    isClothesGiven
                        ? SizedBox()
                        : isClothesAdding
                            ? Center(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(300.w, 60.h))),
                                    onPressed: () {
                                      setState(() {
                                        isClothesAdding = false;
                                        clothesList = [];
                                      });
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                              )
                            : Center(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xFF11941E)),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(300.w, 60.h))),
                                    onPressed: () {
                                      setState(() {
                                        isClothesAdding = true;
                                      });
                                    },
                                    child: Text(
                                      "Give Clothes",
                                      style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              isClothesAdding
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF516F94)),
                                minimumSize: MaterialStateProperty.all(
                                    Size(150.w, 50.h))),
                            onPressed: () {
                              showClothesDialog();
                              setState(() {
                                isClothesAdding = true;
                              });
                            },
                            child: Text(
                              "Add",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600),
                            )),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF11941E)),
                                minimumSize: MaterialStateProperty.all(
                                    Size(150.w, 50.h))),
                            onPressed: () {
                              addLaundry();
                              setState(() {
                                isClothesAdding = false;
                                isClothesGiven = true;
                                status = "GIVEN";
                              });
                            },
                            child: Text(
                              "Submit",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600),
                            )),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      )),
    );
  }
}
