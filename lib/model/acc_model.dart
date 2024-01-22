import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

class account {
  account({
    required this.provider,
    required this.bank,
    required this.expirydate,
    required this.number,
  }) : id = uuid.v4();

  final String provider;
  final String bank;
  final String id;
  final DateTime expirydate;
  final String number;

  String get formattedDate {
    return formatter.format(expirydate);
  }
}