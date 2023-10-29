import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Form controller
  final _formKey = GlobalKey<FormState>();

  List<String> hostelBlocks = ['A', 'B', 'C', 'D1', 'D2'];

  // Form fields
  bool obscureText = true;
  String _name = '';
  String _collegeRegistrationNo = '';
  String _phoneNumber = '';
  String _emailId = '';
  String _password = '';
  String roomNo = '';
  String hostelBloc = 'A';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E4F7),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "SIGN UP",
          style: GoogleFonts.inter(
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello !",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Create account to make your hostel life easier",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 60.h,
              ),
              TextFormField(
                style: GoogleFonts.inter(color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    labelText: 'User Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                style: GoogleFonts.inter(color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    labelText: 'College Registration No/ Employee ID',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    _collegeRegistrationNo = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your college registration number or employee ID.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                style: GoogleFonts.inter(color: Colors.black),
                obscureText: obscureText,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                style: GoogleFonts.inter(color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    labelText: 'Phone Number',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                style: GoogleFonts.inter(color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    labelText: 'Email ID',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    _emailId = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email ID.';
                  }
                  if (!RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+$').hasMatch(value)) {
                    return 'Please enter a valid email ID.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                style: GoogleFonts.inter(color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    labelText: 'Room No.',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    roomNo = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Room number.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hostel Block",
                    style:
                        GoogleFonts.inter(color: Colors.black, fontSize: 12.sp),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  DropdownButton<String>(
                    value: hostelBloc,
                    onChanged: (String? newValue) {
                      setState(() {
                        hostelBloc = newValue!;
                      });
                    },
                    items: hostelBlocks.map((String? block) {
                      return DropdownMenuItem<String>(
                        value: block,
                        child: Text(
                          block!,
                          style: GoogleFonts.inter(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF59718F)),
                    minimumSize: MaterialStateProperty.all(Size(300.w, 50.h)),
                  ),
                  onPressed: () {
                    //After validating
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text(
                    "Create Account",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account ?",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF2B3B4E),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: " Login",
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            color: const Color(0xFF2B3B4E),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
