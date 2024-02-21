import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'record.dart';
import 'dart:convert';

class Shared {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  Future getRecords() async {
    final SharedPreferences prefs = await _prefs;
    final List<String> recordsString = prefs.getStringList('records') ?? [];
    final List<Record> records = recordsString
        .map((record) => Record.fromJson(jsonDecode(record)))
        .toList();
    return records;
  }

  Future setRecords(List<Record> records) async {
    final SharedPreferences prefs = await _prefs;
    final List<String> recordsString =
        records.map((record) => jsonEncode(record)).toList();
    return prefs.setStringList('records', recordsString);
  }

  Future<void> addRecord(Record record) async {
    final List<Record> records = await getRecords();
    records.add(record);
    return setRecords(records);
  }

  static Future<void> removeRecord(Record record) async {
    final SharedPreferences prefs = await _prefs;
    List<String> records = prefs.getStringList('records') ?? [];
    records.removeWhere((item) =>
        jsonDecode(item)['titol'] == record.titol &&
        jsonDecode(item)['descripcio'] == record.descripcio);
    await prefs.setStringList('records', records);
  }
}
