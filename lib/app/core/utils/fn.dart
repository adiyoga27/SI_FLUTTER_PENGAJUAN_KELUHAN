// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../values/value.dart';

_mapDateTimeFormat(DateTime dateTime, List months, List days) => {
      'd': '${dateTime.day}'.padLeft(2, '0'),
      'm': '${dateTime.month}'.padLeft(2, '0'),
      'Y': '${dateTime.year}',
      'y': '${dateTime.year}'.substring(2),
      'h': '${dateTime.hour}'.padLeft(2, '0'),
      'i': '${dateTime.minute}'.padLeft(2, '0'),
      's': '${dateTime.second}'.padLeft(2, '0'),
      'F': '${months[dateTime.month - 1]}',
      'M': '${months[dateTime.month - 1]}'.substring(0, 3),
      'D': '${days[dateTime.weekday - 1]}',
    };

class Fn {
  /// ``` dart
  /// Fn.now(format: 'D, d F Y h:i:s'); // Kamis, 28 Januari 2021 10:29:59
  /// ```
  static String now({String format = 'd-m-Y'}) {
    DateTime now = DateTime.now();

    try {
      String result = '';

      List months = MixShared.bulan, days = MixShared.hari;

      Map<String, dynamic> map = _mapDateTimeFormat(now, months, days);

      format
          .split('')
          .forEach((e) => map.containsKey(e) ? result += map[e] : result += e);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// ``` dart
  /// Fn.dateFormat(DateTime.parse('2021-03-20'), format: 'D, d F Y h:i:s'); // Sabtu, 20 Maret 2021`
  /// ```
  static String dateFormat(DateTime dateTime, {String format = 'd-m-Y'}) {
    try {
      String result = '';
      List months = MixShared.bulan, days = MixShared.hari;

      Map<String, dynamic> map = _mapDateTimeFormat(dateTime, months, days);

      format
          .split('')
          .forEach((e) => map.containsKey(e) ? result += map[e] : result += e);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// ``` dart
  /// Fn.strToDate('01-01-2021'); // date string to DateTime, this function will return Y-m-d format
  /// // inFormat = current format in your initial date string
  /// ```
  static DateTime strToDate(String dateString, {String inFormat = 'Y-m-d'}) {
    try {
      String _dateStr = dateString.replaceAll('/', '-');

      Map<String, dynamic> roles = {'Y': 0, 'm': 1, 'd': 2};
      List<String> d = _dateStr.split('-'), f = inFormat.split('-');

      List<String> newDate = ['', '', ''];

      f.forEach((e) {
        int io = f.indexOf(e);
        int index = roles[e];
        newDate[index] = d[io];
      });

      return DateTime.parse(newDate.join('-'));
    } catch (e) {
      rethrow;
    }
  }

  /// ``` dart
  /// Fn.msToDateTime(1625386377499, format: 'D, d F Y h:i:s'); // Sabtu, 20 Maret 2021`
  /// ```
  static String msToDateTime(int ms, {String format = 'd-m-Y'}) =>
      Fn.dateFormat(DateTime.fromMillisecondsSinceEpoch(ms), format: format);

  /// ``` dart
  /// Fn.focus(emailNode); // Set focus to textfield
  /// ```
  static focus(FocusNode nodeName, {BuildContext? context}) =>
      FocusScope.of(context ?? Get.overlayContext!).requestFocus(nodeName);

  /// ``` dart
  /// Fn.unfocus(); // Unfocus to all textfield
  /// ```
  static unfocus() =>
      FocusScope.of(Get.overlayContext!).requestFocus(FocusNode());

  /// ``` dart
  /// Fn.doubleInRange(10, 100); // generate random double value between 10 - 100
  /// ```
  static double doubleInRange(num start, num end) =>
      Random().nextDouble() * (end - start) + start;

  /// ``` dart
  /// Fn.intInRange(100); // generate random int value with max 100
  /// ```
  static int intInRange(int max) => Random().nextInt(max);

  static int randNum([int length = 12]) =>
      int.parse(List.generate(length, (i) => '${intInRange(9)}').join(''));

  /// ``` dart
  /// Fn.statusBar(Colors.transparent); // change status bar background color
  /// ```
  // static statusBar([Color color = C.none, bool darkText = true]) async {
  //   await FlutterStatusbarcolor.setStatusBarColor(color);
  //   FlutterStatusbarcolor.setStatusBarWhiteForeground(!darkText);
  // }

  /// ``` dart
  /// Fn.goto('tel: 0810...')
  /// Fn.goto('mailto: lipsum@gmail.com')
  /// Fn.goto('https://google.com')
  /// ```
  static goto(String url) async =>
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  /// ``` dart
  /// Fn.openMap(-8.667138922071201, 115.21679636919626); // Denpasar City
  /// ```
  static openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    await goto(googleUrl);
  }

  /// ```dart
  /// Timer timer = Fn.timer((){
  ///   // do something...
  /// }, 100);
  /// ```
  static timer(void Function() then, [int ms = 50]) =>
      Timer(Duration(milliseconds: ms), then);

  /// ```dart
  /// Fn.toast('Lorem ipsum dolor sit.');
  /// ```
  static toast(dynamic text,
      {String position = 'bottom',
      double fontSize = 14.0,
      int time = 1,
      Color textColor = Colors.white,
      Color background = const Color.fromRGBO(0, 0, 0, .7)}) {
    Map _mapPos = {
      'top': ToastGravity.TOP,
      'topLeft': ToastGravity.TOP_LEFT,
      'topRight': ToastGravity.TOP_RIGHT,
      'bottom': ToastGravity.BOTTOM,
      'bottomLeft': ToastGravity.BOTTOM_LEFT,
      'bottomRight': ToastGravity.BOTTOM_RIGHT,
      'center': ToastGravity.CENTER,
      'centerLeft': ToastGravity.CENTER_LEFT,
      'centerRight': ToastGravity.CENTER_RIGHT,
      'sbackbar': ToastGravity.SNACKBAR,
    };

    return Fluttertoast.showToast(
        msg: '$text',
        timeInSecForIosWeb: time,
        toastLength: Toast.LENGTH_SHORT,
        gravity: _mapPos[position] ?? ToastGravity.BOTTOM,
        backgroundColor: background,
        textColor: textColor,
        fontSize: fontSize);
  }

  /// ```dart
  /// var name = TextEditingController();
  /// Fn.setCursorToLastPosition(name);
  /// ```
  static setCursorToLastPosition(TextEditingController controller,
      [int time = 0]) {
    Timer(
        Duration(milliseconds: time),
        () => controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length)));
  }

  /// ```dart
  /// String timeElapsed = Fn.timeElapsed('2021-02-24 11:12:30');
  /// ```
  static String timeElapsed(String dateString, {bool returnAsDate = false}) {
    try {
      Duration compare(DateTime x, DateTime y) => Duration(
          microseconds:
              (x.microsecondsSinceEpoch - y.microsecondsSinceEpoch).abs());

      DateTime date = DateTime.parse(dateString);

      DateTime x = DateTime.now();
      DateTime y = DateTime(
          date.year, date.month, date.day, date.hour, date.minute, date.second);

      Duration diff = compare(x, y);
      String h = '${date.hour}'.padLeft(2, '0'),
          m = '${date.minute}'.padLeft(2, '0'),
          s = '${date.second}'.padLeft(2, '0');

      String _dateTime =
          '${date.year}-${'${date.month}'.padLeft(2, '0')}-${'${date.day}'.padLeft(2, '0')} $h:$m:$s';

      // jika waktu yang diset (dateString) lebih dari waktu saat ini
      if (y.millisecondsSinceEpoch > x.millisecondsSinceEpoch) {
        return '-';
      }

      if (diff.inSeconds >= 60) {
        if (diff.inMinutes >= 60) {
          if (diff.inHours >= 24) {
            return diff.inDays > 31
                ? _dateTime
                : returnAsDate
                    ? _dateTime
                    : '${diff.inDays} hari yang lalu';
          } else {
            return returnAsDate ? _dateTime : '${diff.inHours} jam yang lalu';
          }
        } else {
          return returnAsDate ? _dateTime : '${diff.inMinutes} menit yang lalu';
        }
      } else {
        return 'baru saja';
      }
    } catch (e) {
      rethrow;
    }
  }

  /// ```dart
  /// String text = Fn.lipsum(5);
  /// ```
  // static String lipsum([int numWords = 5]) => createWord(numWords: numWords);

  /// ```dart
  /// ScrollController _scrollCtrl = ScrollController();
  /// Fn.scrollTo(_scrollCtrl);
  /// ```
  static scrollTo(ScrollController _scrollController,
      {int duration = 300, int delay = 50, to = 'down'}) {
    Timer? timer;

    try {
      if (_scrollController.hasClients) {
        timer = Timer(Duration(milliseconds: delay), () {
          _scrollController.animateTo(
            to == 'down' ? _scrollController.position.maxScrollExtent : 0,
            curve: Curves.easeOut,
            duration: Duration(milliseconds: duration),
          );

          timer?.cancel();
        });
      }
    } catch (e) {
      print('-- error on Fn.scrollTo, $e');
    }
  }

  /// ```dart
  /// Fn.copy('Lorem ipsum.');
  /// ```
  static copy(String text,
      {String message = '', String toastPosition = 'bottom'}) {
    Clipboard.setData(ClipboardData(text: text));

    if (message.trim().isNotEmpty) Fn.toast(message, position: toastPosition);
  }
}
