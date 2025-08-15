import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:quran/containts/Containts.dart';
import 'package:quran/views/bmiResult.dart';

class Bmicalulator extends StatefulWidget {
  const Bmicalulator({super.key});

  @override
  State<Bmicalulator> createState() => _BmicalulatorState();
}

class _BmicalulatorState extends State<Bmicalulator> {
  bool isMale = true;
  double height = 150;
  double weight = 30;
  int age = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Containts.secondaryColor,
        title: Text("BMI CALCULATOR", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isMale ? Colors.blue : Colors.grey,
                    ),
                    height: 100,
                    child: Column(
                      children: [
                        Icon(Icons.male),
                        SizedBox(height: 8),
                        Text(
                          "Male",
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: !isMale ? Colors.pink : Colors.grey,
                    ),
                    height: 100,
                    child: Column(
                      children: [
                        Icon(Icons.female),
                        SizedBox(height: 8),
                        Text(
                          "Female",
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Containts.primaryColor,
              ),

              child: Column(
                children: [
                  SizedBox(height: 10),
                  Icon(Icons.height_rounded),
                  SizedBox(height: 10),
                  Text(
                    "Height",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${height.toInt()}cm",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    activeColor: isMale ? Colors.blue : Colors.pink,
                    value: height,
                    min: 30,
                    max: 220,
                    onChanged: (value) {
                      setState(() {
                        height = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isMale ? Colors.blue : Colors.pink,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Age",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${age} ",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    ++age;
                                  });
                                },
                                icon: Icon(Icons.add, color: Colors.white),
                              ),
                              SizedBox(height: 8),

                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (age > 1) {
                                      --age;
                                    }
                                    ;
                                  });
                                },
                                icon: Icon(Icons.remove, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isMale ? Colors.blue : Colors.pink,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Weight",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${weight} ",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    ++weight;
                                  });
                                },
                                icon: Icon(Icons.add, color: Colors.white),
                              ),
                              SizedBox(height: 8),

                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (weight > 30) {
                                      --weight;
                                    }
                                    ;
                                  });
                                },
                                icon: Icon(Icons.remove, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 40,

              child: ElevatedButton(
                onPressed: () {
                  double bmi = weight / ((height / 100) * (height / 100));
                  Get.to(() => Bmiresult(bmi: bmi));
                  print(bmi);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isMale ? Colors.blue : Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                child: Text(
                  "BMI Calculate",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
