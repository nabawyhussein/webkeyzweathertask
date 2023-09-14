import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension Formatting on DateTime {


  String get yMd => DateFormat(DateFormat.YEAR_MONTH_DAY).format(this);


}