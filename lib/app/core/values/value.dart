library value;

import 'package:ppju/app/core/app_config.dart';

String version = '${AppConfig.version} ${AppConfig.buildDate}';

const double space = 20.0;
const double radius = 2.0;

class MixShared {
  /// ``` dart
  /// print(MixShared.bulan); // [Januari, ...]
  /// print(MixShared.bulan.map((e) => e.substring(0, 3)).toList()); // [Jan, Feb, ...]
  /// ```
  static const List<String> bulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  static const List<String> hari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];
}
