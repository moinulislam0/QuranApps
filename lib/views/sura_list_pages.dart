import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quran/containts/Containts.dart';
import 'package:quran/views/ayatPage.dart';

class SuraListPages extends StatefulWidget {
  const SuraListPages({super.key});

  @override
  State<SuraListPages> createState() => _SuraListPagesState();
}

class _SuraListPagesState extends State<SuraListPages> {
  List suraList = [];
  List filteredSearch = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSura();
  }

  void loadSura() async {
    final response = await rootBundle.loadString('assets/sura.json');
    final data = jsonDecode(response);
    setState(() {
      suraList = data;
      filteredSearch = data; // Initially show all suras
    });
  }

  void searchQuery(String query) {
    query = query.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredSearch = suraList;
      } else {
        filteredSearch = suraList.where((sura) {
          final suraNameBangla = sura['sura_name'].toString().toLowerCase();
          final suraNameEnglish = sura['eng_name'].toString().toLowerCase();

          return suraNameBangla.contains(query) ||
              suraNameEnglish.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Containts.primaryColor,
      appBar: AppBar(
        backgroundColor: Containts.secondaryColor,
        title: Row(
          children: [
            Expanded(
             
              child: Text("📖 আল-কোরআন", style: TextStyle(color: Colors.white)),
            ),
            Expanded(
              child: SizedBox(
                height: 35,
                child: TextField(
                  controller: searchController,
                  onChanged: searchQuery, // LIVE search
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  style: TextStyle(fontSize: 16, fontFamily: 'NotoSansBengali'),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "বাংলা বা ইংরেজিতে সার্চ করুন",
                    hintStyle: TextStyle(color: Containts.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: filteredSearch.isEmpty
          ? Center(
              child: Text(
                "কোনো সূরা পাওয়া যায়নি",
                style: TextStyle(color: Colors.black),
              ),
            )
          : ListView.builder(
              itemCount: filteredSearch.length,
              itemBuilder: (context, index) {
                final sura = filteredSearch[index];
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => Ayatpage(
                        suras: sura['sura_name'],
                        para: sura['para'],
                        Suranumber: int.parse(sura['sura_no']),
                        totalAytat: sura['total_ayat'],
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("পারা: ${sura['para']}"),
                          SizedBox(height: 5),
                          Text("আয়াত: ${sura['total_ayat']}"),
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
