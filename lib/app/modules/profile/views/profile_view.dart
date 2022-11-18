import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mixins/mixins.dart';
import 'package:ppju/app/core/theme/text_theme.dart';
import 'package:ppju/app/core/values/colors.dart';
import 'package:ppju/app/core/values/value.dart';
import 'package:ppju/app/modules/login/controllers/login_controller.dart';
import 'package:ppju/app/modules/profile/views/about_view.dart';
import 'package:ppju/app/routes/app_pages.dart';
import 'package:ppju/app/widgets/mix_widget.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> options = [
      {
        'options': <Map<String, dynamic>>[
          {'title': 'Tentang Kami', 'icon': La.info_circle},
          {'title': 'Ganti Password', 'icon': La.lock},
          {'title': 'Logout', 'icon': La.arrow_left},
        ]
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: C.primaryColor,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
          padding: const EdgeInsets.only(top: 0, bottom: 100),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Container(
              child: Column(
                children: [
                  // Container(
                  //   decoration: const BoxDecoration(color: Colors.white),
                  //   padding: EdgeInsets.all(8.0),
                  //   child: GetBuilder<ProfileController>(
                  //       id: 'profile',
                  //       builder: (state) => FutureBuilder(
                  //           future: Auth.user(),
                  //           builder:
                  //               (context, AsyncSnapshot<UserModel> snap) {
                  //             return GestureDetector(
                  //               onTap: () async {
                  //                 // String app = await Storage.read('app_config');
                  //                 // Map<String, dynamic> appConfig = json.decode(app);

                  //                 // bool isActive = appConfig['active'] ?? false;
                  //                 // String chatId = appConfig['chatId'] ?? '-1001485163741';
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   Container(
                  //                       margin: Ei.only(r: 17),
                  //                       width: 90,
                  //                       height: 90,
                  //                       decoration: BoxDecoration(
                  //                           shape: BoxShape.circle,
                  //                           color: C.black1),
                  //                       child: ClipRRect(
                  //                           borderRadius: Br.circle,
                  //                           child: snap.data?.image == null
                  //                               ? None()
                  //                               : ImageURL(
                  //                                   '${snap.data?.image}',
                  //                                   indicator:
                  //                                       Skeleton(size: 70)))),
                  //                   Flexible(
                  //                     child: Col(
                  //                       children: [
                  //                         Text('${snap.data?.nama}',
                  //                             overflow: Tof.ellipsis,
                  //                             style: Gfont.bold
                  //                                 .copyWith(fontSize: 17)),
                  //                         Text('${snap.data?.username}'),
                  //                         '${snap.data?.jenjang}' == '-'
                  //                             ? None()
                  //                             : Container(
                  //                                 margin: Ei.only(t: 5),
                  //                                 padding:
                  //                                     Ei.sym(v: 2, h: 10),
                  //                                 decoration: BoxDecoration(
                  //                                     borderRadius:
                  //                                         Br.radius(2),
                  //                                     color: C.hex(
                  //                                         snap.data?.warna ??
                  //                                             'ffffff')),
                  //                                 child: Text(
                  //                                     '${snap.data?.jenjang}',
                  //                                     style: Gfont.white
                  //                                         .copyWith(
                  //                                             fontSize: 14))),
                  //                       ],
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             );
                  //           })),
                  // ),
                  Column(
                    children: List.generate(options.length, (i) {
                      String title = options[i]['title'] ?? '';
                      List childs = options[i]['options'];

                      bool noTitle = title.isEmpty;

                      return Container(
                          margin: const EdgeInsets.only(top: 0),
                          decoration: BoxDecoration(
                              border: Br.only(['', 'b']), color: Colors.white),
                          child: Column(
                            children: [
                              noTitle
                                  ? Container()
                                  : Textiner(title,
                                      style: Gfont.bold.copyWith(fontSize: 20),
                                      padding: Ei.all(space)),
                              Col(
                                  children: List.generate(childs.length, (j) {
                                IconData icon = childs[j]['icon'];
                                String label = childs[j]['title'];

                                return WidAccOption(
                                  label: label,
                                  icon: icon,
                                  onTap: () => action(label),
                                  isFirst: j == 0,
                                );
                              })),
                            ],
                          ));
                    }),
                  ),
                  // Container(
                  //   padding: Ei.all(space),
                  //   child: Col(children: [
                  //     GestureDetector(
                  //       onTap: () => testCtrl.increment(),
                  //       child: Row(
                  //         mainAxisAlignment: Maa.spaceBetween,
                  //         children: [
                  //           Textiner(
                  //               'v${AppConfig.version} ${AppConfig.buildDate}',
                  //               style: Gfont.black5),
                  //           Textiner('#sehatkayabahagia', style: Gfont.black5)
                  //         ],
                  //       ),
                  //     ),
                  //   ]),
                  // ),
                ],
              ),
            )
          ]),
    );
  }

  void action(String label) async {
    try {
      switch (label.toLowerCase()) {

        // TENTANG
        case 'tentang kami':
          // Get.to(() => UiAbout());
          Modal.open(AboutView());

          break;

        case 'kebijakan privasi':
          // Get.to(() => UiPrivacy());
          break;

        // AKUN
        case 'ganti password':
          Get.toNamed(Routes.RESETPASSWORD);
          break;

        case 'logout':
          Modal.open(
              ConfirmWidget(
                title: 'Keluar Akun (Logout)',
                message: 'Apakah kamu yakin ingin keluar dari akun ini?',
              ), then: (value) {
            if (value == 1) {
              final _authCtrl = Get.put(LoginController());
              // final _authCtrl = Get.put(AuthController());
              _authCtrl.logout();
            }
          });

          break;

        default:
          break;
      }
    } catch (e, s) {
      // Errors.check(e, s);
    }
  }
}

class WidAccOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() onTap;
  final bool isFirst;

  const WidAccOption(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onTap,
      this.isFirst = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      onTap: onTap,
      child: Container(
        padding: Ei.sym(v: 15, h: space),
        decoration: BoxDecoration(border: Br.only([isFirst ? '' : 't'])),
        width: Get.width,
        child: Row(
          mainAxisAlignment: Maa.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                Textiner(label, margin: Ei.only(l: 15)),
              ],
            ),
            Icon(Icons.chevron_right, color: C.black3),
          ],
        ),
      ),
    );
  }
}
