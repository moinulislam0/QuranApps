import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/containts/Containts.dart';

class Ayatpage extends StatefulWidget {
  final String suras;
  final String para;
  final int Suranumber;
  final String totalAytat;
  const Ayatpage({
    super.key,
    required this.suras,
    required this.para,
    required this.Suranumber,
    required this.totalAytat,
  });

  @override
  State<Ayatpage> createState() => _AyatpageState();
}

class _AyatpageState extends State<Ayatpage> {
  List banglaList = [];
  List arabicList = [];
  List englishList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  Future<void> loadAllData() async {
    final arData = await rootBundle.loadString('assets/ayats_ar.json');
    final bnData = await rootBundle.loadString('assets/ayats_bn.json');
    final enData = await rootBundle.loadString('assets/ayats_en.json');

    List banglaJson = jsonDecode(bnData);
    List arabicJson = jsonDecode(arData);
    List englishJson = jsonDecode(enData);

    String suraStr = widget.Suranumber.toString();

    setState(() {
      banglaList = banglaJson.where((e) => e['sura'] == suraStr).toList();
      englishList = englishJson.where((e) => e['sura'] == suraStr).toList();
      arabicList = arabicJson.where((e) => e['sura'] == suraStr).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Containts.primaryColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Containts.primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Containts.secondaryColor,
        title: Center(
          child: Text(
            "${widget.suras} (পারা :${widget.para})",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: arabicList.length,
        itemBuilder: (context, index) {
          final bangla = banglaList[index];
          final arabic = arabicList[index];
          final english = englishList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 8),
                Text(
                  "${arabic['sura']}:${arabic['VerseIDAr']}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    textAlign: TextAlign.right,
                    '${arabic['ayat']}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    "${english['text']}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                SizedBox(height: 14),
                Center(
                  child: Text(
                    '${bangla['text']}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Divider(thickness: 1, color: Colors.black),
              ],
            ),
          );
        },
      ),
    );
  }
}
