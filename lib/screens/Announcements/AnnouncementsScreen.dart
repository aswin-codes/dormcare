import 'dart:convert';

import 'package:dormcare/screens/Announcements/AnnouncementsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  List<Announcement> announcementList = [];

  Future<void> initialFetch() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/announcements"));
    final List<dynamic> respBody = jsonDecode(response.body);
    List<Announcement> newAnnouncement = respBody.map((element) {
      return Announcement(announcement: element['announcement']);
    }).toList();

    setState(() {
      announcementList = newAnnouncement;
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B3B4E),
        elevation: 0,
        title: Text(
          "Announcements",
          style: GoogleFonts.inter(
              fontSize: 25.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: announcementList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                        color: const Color(0xFF2B3B4E),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.announcement,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: Text(
                            announcementList[index].announcement,
                            style: GoogleFonts.inter(
                                fontSize: 18.sp, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
