import 'package:fic4_flutter_auth/data/shared/theme.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  InfoPage({Key? key}) : super(key: key);

  final List<String> bulletList = [
    'Flutter BloC State Mangagement',
    'Google Fonts',
    'HTTP',
    'Shared Preferences',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffB7E3C8),

      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 1,
      //   centerTitle: true,
      //   backgroundColor: const Color(0xffffb703),
      //   title: Text('Info', style: blackTextStyle.copyWith(fontSize: 24)),
      // ),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'Tentang Aplikasi',
                  style:
                      blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
                'Aplikasi ini dibuat menggunakan Platzi Fake Store API. Based on project FIC by Saiful Bahri.',
                style: blackTextStyle.copyWith(fontSize: 14)),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Dependensi yang Digunakan',
                    style: blackTextStyle.copyWith(fontWeight: bold)),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bulletList.length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      child: const Text(
                        '-',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        bulletList[index],
                        style: blackTextStyle,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
