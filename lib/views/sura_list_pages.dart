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
  final TextEditingController searchController = TextEditingController();

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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Containts.primaryColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD4CA00), Color(0xFFB9AE00)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "আল-কোরআন",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "বাংলা ও ইংরেজিতে সূরা খুঁজুন",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.86),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1C5A5209),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: searchQuery,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF2E290C),
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.search_rounded,
                            color: Color(0xFF7E7440),
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        hintText: "বাংলা বা ইংরেজিতে সূরা খুঁজুন",
                        hintStyle: const TextStyle(
                          color: Color(0xFF8A8158),
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: filteredSearch.isEmpty
                ? const Center(
                    child: Text(
                      "কোনো সূরা পাওয়া যায়নি",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(14, 16, 14, 24),
                    itemCount: filteredSearch.length,
                    itemBuilder: (context, index) {
                      final sura = filteredSearch[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {
                            Get.to(
                              () => Ayatpage(
                                suras: sura['sura_name'],
                                para: sura['para'],
                                suraNumber: int.parse(sura['sura_no']),
                                totalAytat: sura['total_ayat'],
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFCF1),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.75),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x166D6417),
                                  blurRadius: 18,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFF3E87B), Color(0xFFD2BF11)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${sura['sura_no']}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${sura['eng_name']}",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF2A2611),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "${sura['sura_name']}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF7B7350),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "পারা ${sura['para']}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF5D5736),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "আয়াত ${sura['total_ayat']}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF5D5736),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
