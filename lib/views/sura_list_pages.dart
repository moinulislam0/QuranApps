import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:quran/containts/Containts.dart';
import 'package:quran/views/ayatPage.dart';

class SuraListPages extends StatefulWidget {
  const SuraListPages({super.key});

  @override
  State<SuraListPages> createState() => _SuraListPagesState();
}

class _SuraListPagesState extends State<SuraListPages> {
  List suraList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSura();
  }

  void loadSura() async {
    final response = await rootBundle.loadString('assets/sura.json');
    setState(() {
      suraList = jsonDecode(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Containts.primaryColor,
      appBar: AppBar(
        backgroundColor: Containts.secondaryColor,
        title: Center(
          child: Text("📖 আল-কোরআন", style: TextStyle(color: Colors.white)),
        ),
      ),
      body: suraList.isEmpty
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : ListView.builder(
              itemCount: suraList.length,
              itemBuilder: (context, index) {
                final sura = suraList[index];
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => Ayatpage(
                        suras: sura['sura_name'],
                        para: sura['para'],
                        Suranumber: index + 1,
                        totalAytat:sura['total_ayat'],
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 235, 223, 187),
                        ),
                        child: Center(
                          child: Text(
                            "${sura['sura_no']}",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      title: Text("${sura['eng_name']}"),
                      subtitle: Text("${sura['sura_name']}"),
                      trailing: Column(
                        children: [
                          Text("পারা: ${sura['para']}"),
                          SizedBox(height: 10),
                          Text("আয়াত সংখ্যা: ${sura['total_ayat']}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
