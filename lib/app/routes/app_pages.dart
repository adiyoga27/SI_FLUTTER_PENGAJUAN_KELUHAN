import 'package:get/get.dart';
import 'package:ppju/app/modules/history/views/detail_history_view.dart';
import 'package:ppju/app/modules/news/views/detail_news_view.dart';
import 'package:ppju/app/modules/profile/views/change_password_view.dart';

import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/initial/bindings/initial_binding.dart';
import '../modules/initial/views/initial_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/maps/bindings/maps_binding.dart';
import '../modules/maps/views/maps_view.dart';
import '../modules/news/bindings/news_binding.dart';
import '../modules/news/views/news_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/submission/bindings/submission_binding.dart';
import '../modules/submission/views/submission_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.NEWS,
      page: () => const NewsView(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: _Paths.SUBMISSION,
      page: () => const SubmissionView(),
      binding: SubmissionBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAPS,
      page: () => const MapsView(),
      binding: MapsBinding(),
    ),
    GetPage(
      name: _Paths.INITIAL,
      page: () => const InitialView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: _Paths.DETAILNEWS,
      page: () => const DetailNewsView(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: _Paths.DETAILHISTORY,
      page: () => const DetailHistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.RESETPASSWORD,
      page: () => const ChangePasswordView(),
      binding: ProfileBinding(),
    ),
  ];
}
