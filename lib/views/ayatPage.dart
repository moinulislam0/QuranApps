import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/containts/Containts.dart';

class Ayatpage extends StatefulWidget {
  final String suras;
  final String para;
  final int suraNumber;
  final String totalAytat;
  const Ayatpage({
    super.key,
    required this.suras,
    required this.para,
    required this.suraNumber,
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

    String suraStr = widget.suraNumber.toString();

    setState(() {
      banglaList = banglaJson.where((e) => e['sura'] == suraStr).toList();
      englishList = englishJson.where((e) => e['sura'] == suraStr).toList();
      arabicList = arabicJson.where((e) => e['sura'] == suraStr).toList();
      isLoading = false;
    });
  }

  String _buildVerseLabel(Map arabic) {
    return "${arabic['sura']}:${arabic['VerseIDAr']}";
  }

  String _buildShareText(Map arabic, Map english, Map bangla) {
    return "${widget.suras} | আয়াত ${_buildVerseLabel(arabic)}\n\n${arabic['ayat']}\n\n${english['text']}\n\n${bangla['text']}";
  }

  void _showMessage(String text, {bool isError = false}) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError ? const Color(0xFF6B251D) : const Color(0xFF39341E),
          margin: const EdgeInsets.all(12),
        ),
      );
  }

  Future<void> _copyVerse(Map arabic, Map english, Map bangla) async {
    final textToCopy = _buildShareText(arabic, english, bangla);
    await Clipboard.setData(ClipboardData(text: textToCopy));
    _showMessage("আয়াতটি clipboard-এ কপি হয়েছে");
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
        backgroundColor: Containts.secondaryColor,
        title: Text(
          "${widget.suras} (পারা: ${widget.para})",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 28),
        itemCount: arabicList.length,
        itemBuilder: (context, index) {
          final bangla = banglaList[index];
          final arabic = arabicList[index];
          final english = englishList[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.55)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1F6D6417),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Containts.secondaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          _buildVerseLabel(arabic),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0x14A38D00),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _showMessage("Audio feature পরে safely add করা হবে");
                          },
                          icon: const Icon(
                            Icons.volume_up_rounded,
                            color: Color(0xFF8D7D00),
                            size: 28,
                          ),
                          tooltip: 'Audio',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '${arabic['ayat']}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${english['text']}",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '${bangla['text']}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FilledButton.tonalIcon(
                        onPressed: () => _copyVerse(arabic, english, bangla),
                        icon: const Icon(Icons.copy_rounded),
                        label: const Text('Copy'),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFF0E57C),
                          foregroundColor: const Color(0xFF534800),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
