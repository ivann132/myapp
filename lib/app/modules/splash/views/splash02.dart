import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class Splash02 extends StatelessWidget {
  const Splash02({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;
    var width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SizedBox(
              height: height * 1.5,
              width: width * 1.5,
              child: Image.asset(
                "assets/images/splash2.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: height * 0.35,
                width: width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Welcome!",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const Text(
                        "Please login or sign up to continue",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      // Spacer(),
                      InkWell(
                        onTap: () {
                          Get.offAllNamed(Routes.LOGIN);
                        },
                        child: Container(
                            height: height * 0.055,
                            width: width * 0.75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xFFDC5F00)),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: height * 0.001,
                      ),

                      InkWell(
                        onTap: () {
                          Get.offAllNamed(Routes.SIGNUP);
                        },
                        child: Container(
                            height: height * 0.055,
                            width: width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: const Color(
                                    0xFFDC5F00), // Set the color of the border
                                width: 2.0, // Set the width of the border
                              ),
                              color: Colors.transparent,
                            ),
                            child: const Center(
                              child: Text(
                                "Create an account",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFDC5F00)),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ]),
              ),
            )
          ],
        ));
  }
}
