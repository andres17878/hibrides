import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'record.dart';
import 'dart:convert';

class Shared {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<List<Record>> getRecords() async {
    final SharedPreferences prefs = await _prefs;
    final List<String> records = prefs.getStringList('records') ?? [];
    return records
        .map((record) => Record.fromJson(jsonDecode(record)))
        .toList();
  }

  static Future<bool> setRecords(List<Record> records) async {
    final SharedPreferences prefs = await _prefs;
    final List<String> recordsString =
        records.map((record) => jsonEncode(record)).toList();
    return prefs.setStringList('records', recordsString);
  }

  static Future<bool> addRecord(Record record) async {
    final List<Record> records = await getRecords();
    records.add(record);
    return setRecords(records);
  }

  static Future<bool> removeRecord(Record record) async {
    final List<Record> records = await getRecords();
    records.remove(record);
    return setRecords(records);
  }

  static Future<bool> clearRecords() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove('records');
  }
}
