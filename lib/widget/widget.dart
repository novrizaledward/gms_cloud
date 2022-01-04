// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GmsTextField extends StatelessWidget {
  final String? hintText;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? typekeyboard;
  final double? width;
  const GmsTextField({
    Key? key,
    this.hintText,
    this.suffixIcon,
    this.controller,
    this.width,
    this.typekeyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      width: width,
      child: TextFormField(
        keyboardType: typekeyboard,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0xffC4C4C4)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            suffixIcon: Icon(
              suffixIcon,
              color: Color(0xffC4C4C4),
            )),
      ),
    );
  }
}

class GSMCardList extends StatelessWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  const GSMCardList({
    Key? key,
    this.text1,
    this.text2,
    this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1!,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                text2!,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    text3!,
                    style: TextStyle(color: Color(0xffC0BFBF)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GMScardDetail extends StatelessWidget {
  const GMScardDetail({
    Key? key,
    required this.nomorSuratJalan,
    required this.relasiNama,
    required this.tanggal,
    required this.jam,
  }) : super(key: key);

  final String? nomorSuratJalan;
  final String? relasiNama;
  final String? tanggal;
  final String? jam;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Surat Jalan",
                style: TextStyle(color: Color(0xffC0BFBF)),
              ),
              Text(
                nomorSuratJalan!,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                relasiNama!,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tanggal!,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    jam!,
                    style: TextStyle(color: Color(0xffC0BFBF)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
