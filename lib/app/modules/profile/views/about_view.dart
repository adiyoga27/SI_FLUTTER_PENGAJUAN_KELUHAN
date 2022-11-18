import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mixins/mixins.dart';
import 'package:ppju/app/core/theme/text_theme.dart';
import 'package:ppju/app/core/values/colors.dart';
import 'package:ppju/app/core/values/value.dart';
import 'package:ppju/app/widgets/mix_widget.dart';
import '../controllers/profile_controller.dart';

class AboutView extends GetView<ProfileController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: CenterDialog(
          child: ZoomIn(
              child: ClipRRect(
            borderRadius: Br.radius(2),
            child: Container(
                decoration: BoxDecoration(color: C.white),
                child: Col(children: [
                  Container(
                      padding: Ei.all(15),
                      child: Row(
                        mainAxisAlignment: Maa.spaceBetween,
                        children: [
                          Col(
                            children: [
                              Text('Tentang Kami', style: Gfont.bold),
                            ],
                          ),
                        ],
                      )),
                  Divider(),
                  Container(
                    constraints: BoxConstraints(maxHeight: Get.height * .6),
                    child: SingleChildScrollView(
                        physics: BounceScroll(),
                        child: Container(
                          padding: Ei.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.whatsapp),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Textiner('085792486889',
                                      style: Gfont.black7,
                                      margin: Ei.only(t: 0)),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Icon(Icons.phone),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Textiner('(0366) 21087',
                                      style: Gfont.black7,
                                      margin: Ei.only(t: 0)),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Icon(Icons.facebook),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Textiner('Dishub Klungkung',
                                      style: Gfont.black7,
                                      margin: Ei.only(t: 0)),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Icon(Icons.web),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Textiner('klunngkungkab.go.id',
                                      style: Gfont.black7,
                                      margin: Ei.only(t: 0)),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Icon(Icons.store),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Textiner('Operasional Kantor',
                                      style: Gfont.black7,
                                      margin: Ei.only(t: 0)),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 35,
                                  ),
                                  Textiner('Senin-Kamis (07.00-15.00)',
                                      style: Gfont.black7,
                                      margin: Ei.only(t: 0)),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 35,
                                  ),
                                  Textiner('Jumat(08.00-12.00)',
                                      style: Gfont.black7,
                                      margin: Ei.only(t: 0)),
                                ],
                              ),
                            ],

                            //     children:
                            //         List.generate(state.starterkits.length, (i) {
                            //   StarterkitModel product = state.starterkits[i];

                            //   String image = product.image ?? '',
                            //       productName = product.starterName ?? '',
                            //       price = '${product.price?.toInt()}'.idr(),
                            //       weight = '${product.weight}';

                            //   int id = product.id!;

                            //   bool isSelected = state.selectedStarterkit.id == id;

                            //   return Button(
                            //       onTap: () => state.setStarterkit(product),
                            //       color: isSelected ? C.black1 : C.white,
                            //       child: Stack(children: [
                            //         Container(
                            //             padding: Ei.all(15),
                            //             decoration: BoxDecoration(
                            //                 border: Br.only([i == 0 ? '' : 't'])),
                            //             child: Col(
                            //               children: [
                            //                 Row(
                            //                   children: [
                            //                     Container(
                            //                         margin: Ei.only(r: 15),
                            //                         width: 75,
                            //                         height: 75,
                            //                         decoration: BoxDecoration(
                            //                             color: C.black1),
                            //                         child: image.isEmpty
                            //                             ? None()
                            //                             : ImageURL(image,
                            //                                 indicator: Skeleton(
                            //                                     size: 75))),
                            //                     Flexible(
                            //                         child: Col(children: [
                            //                       Text(productName),
                            //                       Textiner(price.idr(),
                            //                           margin: Ei.only(t: 5)),
                            //                       Text('Berat : ${weight}Kg',
                            //                           style: Gfont.black5)
                            //                     ])),
                            //                   ],
                            //                 ),
                            //               ],
                            //             )),
                            //         Positioned.fill(
                            //             child: Align(
                            //                 alignment: Alignment.topLeft,
                            //                 child: AnimatedContainer(
                            //                     duration:
                            //                         Duration(milliseconds: 150),
                            //                     height: Get.height,
                            //                     width: isSelected ? 5 : 0,
                            //                     color: primaryColor)))
                            //       ]));
                            // }
                          ),
                        )),
                  ),
                  Button(
                      onTap: () => Get.back(result: true),
                      color: C.white,
                      child: Container(
                          decoration: BoxDecoration(border: Br.only(['t'])),
                          padding: Ei.sym(v: 13, h: 15),
                          width: Get.width,
                          child: Text('Kembali',
                              style: Gfont.bold, textAlign: Ta.center)))
                ])),
          )),
        ));
  }
}
