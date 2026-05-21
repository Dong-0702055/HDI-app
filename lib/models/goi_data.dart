import 'package:flutter/material.dart';

class QuyenLoiRow {
  final String label;
  final String value;
  final bool isGreen;

  const QuyenLoiRow({
    required this.label,
    required this.value,
    required this.isGreen,
  });
}

class GoiData {
  final String id;       
  final String ten;
  final String moTa;
  final String gia;
  final String iconPath;
  final String bgPath;
  final Color bgColor1;
  final Color bgColor2;
  final List<QuyenLoiRow> quyenLoi;
  final bool lienQuan;

  const GoiData({
    required this.id,     
    required this.ten,
    required this.moTa,
    required this.gia,
    required this.iconPath,
    required this.bgPath,
    required this.bgColor1,
    required this.bgColor2,
    required this.quyenLoi,
    required this.lienQuan,
  });
}