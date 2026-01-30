import 'package:flutter/material.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LiquidGlassView(
          backgroundWidget: SingleChildScrollView(
            child: Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 2, // ارتفاع بیشتر برای اسکرول
            ),
          ),
          children: [
            LiquidGlass(
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Text("data",style: TextStyle(fontSize: 45),)
                ],
              ),
              width: 300,
              height: 100,
              magnification: 1,
              distortion: 0.1,
              distortionWidth: 50,
              position: LiquidGlassAlignPosition(
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}