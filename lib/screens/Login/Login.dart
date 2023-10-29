import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _emailId = '';
  String _password = '';
  bool obscureText = true;
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "LOGIN",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 25.sp,
              color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
              Text(
                "Hello, Welcome Back",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Happy to see you again, kindly enter your registered user name and password",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 30.h,
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
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password ?",
                      style: GoogleFonts.inter(
                          color: const Color(0xFF006FD5),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    )),
              ),
              SizedBox(
                height: 100.h,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF59718F)),
                    minimumSize: MaterialStateProperty.all(Size(300.w, 50.h)),
                  ),
                  onPressed: () {
                    //After Validating
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account ?",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF2B3B4E),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: " Sign Up",
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
