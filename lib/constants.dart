import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'e.g Alaa Abdelkarim',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  filled: true,
  fillColor: Color(0xff282828),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF15B86C), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF15B86C), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  ),
);

const kTextStyle = TextStyle(
  color: Color(0xffffffff),
  fontSize: 16,
  fontWeight: FontWeight.w400,
);
