import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/containts/Containts.dart';
import 'package:quran/views/BmiCalulator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Bmiresult extends StatefulWidget {
  final double bmi;
  const Bmiresult({super.key, required this.bmi});

  @override
  State<Bmiresult> createState() => _BmiresultState();
}

class _BmiresultState extends State<Bmiresult> {
  String getBmiCategory() {
    if (widget.bmi < 18.5) {
      return "Underweight";
    } else if (widget.bmi < 25) {
      return "Normal";
    } else if (widget.bmi < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  Color getBmiColor() {
    if (widget.bmi < 18) {
      return const Color.fromARGB(255, 230, 167, 163);
    } else if (widget.bmi < 25) {
      return Colors.green;
    } else if (widget.bmi < 30) {
      return Colors.redAccent;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Containts.secondaryColor,
        title: Text(
          "BMI Result",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Text(
            "Your BMI : ${widget.bmi.toStringAsFixed(1)}",
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: Colors.black),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: SfRadialGauge(
              axes: [
                RadialAxis(
                  minimum: 10,
                  maximum: 40,
                  ranges: [
                    GaugeRange(
                      startValue: 10,
                      endValue: 18.5,
                      color: const Color.fromARGB(255, 230, 172, 168),
                    ),
                    GaugeRange(
                      startValue: 18.5,
                      endValue: 25,
                      color: Colors.green,
                    ),
                    GaugeRange(
                      startValue: 25,
                      endValue: 30,
                      color: Colors.yellow,
                    ),
                    GaugeRange(startValue: 30, endValue: 40, color: Colors.red),
                  ],

                  pointers: [NeedlePointer(value: widget.bmi)],
                  annotations: [
                    GaugeAnnotation(
                      widget: Text(
                        widget.bmi.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      angle: 90,
                      positionFactor: .05,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            getBmiCategory(),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: getBmiColor()),
          ),
          const SizedBox(height: 10),
          Text(
            getBmiCategory() == 'Normal'
                ? "Enjoy ,You are fit"
                : "Consider a healthy lifestyle",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Get.to(() => Bmicalulator());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Containts.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
            ),
            child: Text("Re-Calculate", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
