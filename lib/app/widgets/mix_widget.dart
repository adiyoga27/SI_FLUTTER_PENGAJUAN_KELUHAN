// ignore_for_file: overridden_fields

import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mixins/mixins.dart';
import 'package:ppju/app/core/theme/text_theme.dart';
import 'package:ppju/app/core/utils/fn.dart';
import 'package:ppju/app/core/values/colors.dart';

class GetImage extends StatelessWidget {
  final String path;
  final BoxFit? fit;
  final dynamic size;
  final EdgeInsetsGeometry? margin;

  const GetImage(this.path,
      {this.fit = BoxFit.cover, this.size = 100, this.margin});

  @override
  Widget build(BuildContext context) {
    bool isSvg = path.split('.').last.toLowerCase() == 'svg';

    return isSvg
        ? Container(
            margin: margin,
            child: SvgPicture.asset(path,
                width: size is List ? size[0].toDouble() : size.toDouble(),
                height: size is List ? size[1].toDouble() : size.toDouble()))
        : Container(
            width: size is List ? size[0].toDouble() : size.toDouble(),
            height: size is List ? size[1].toDouble() : size.toDouble(),
            margin: margin,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(path), fit: fit),
            ),
          );
  }
}

class Intrinsic extends StatelessWidget {
  @override
  final Key? key;
  final List<Widget> children;
  final Axis axis;

  const Intrinsic(
      {this.key, required this.children, this.axis = Axis.horizontal});

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
      key: key,
      child: axis == Axis.horizontal
          ? Row(crossAxisAlignment: Caa.stretch, children: children)
          : Column(crossAxisAlignment: Caa.stretch, children: children));
}

/// combination betweeen Text and Container
class Textiner extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDecoration;
  final TextOverflow? overflow;
  final bool? softwrap;
  final int? maxLines;
  final EdgeInsetsGeometry? margin, padding;
  final BorderRadiusGeometry? radius;
  final BoxBorder? border;
  final double? width;
  final AlignmentGeometry? alignment;

  const Textiner(this.text,
      {this.style,
      this.margin,
      this.padding,
      this.width,
      this.textAlign,
      this.radius,
      this.textDecoration,
      this.overflow,
      this.softwrap,
      this.maxLines,
      this.alignment,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      margin: margin,
      width: width,
      decoration: BoxDecoration(border: border, borderRadius: radius),
      child: Text(text,
          style: style,
          textAlign: textAlign,
          overflow: overflow,
          softWrap: softwrap,
          maxLines: maxLines),
    );
  }
}

/// combination betweeen Icon and Container
class Icontiner extends StatelessWidget {
  final IconData icon;
  final EdgeInsetsGeometry? margin, padding;
  final BorderRadiusGeometry? radius;
  final BoxBorder? border;
  final double? width;
  final AlignmentGeometry? alignment;
  final Color? color;
  final double? size;

  const Icontiner(this.icon,
      {this.margin,
      this.padding,
      this.width,
      this.radius,
      this.color,
      this.size,
      this.alignment,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      margin: margin,
      width: width,
      decoration: BoxDecoration(border: border, borderRadius: radius),
      child: Icon(icon, color: color, size: size),
    );
  }
}

class Button extends StatelessWidget {
  @override
  final Key? key;
  final Widget? child;
  final Function()? onTap, onLongPress, onDoubleTap;
  final EdgeInsetsGeometry? padding, margin;
  final Color? color, splash, highlightColor;
  final BorderRadius? radius;
  final BoxBorder? border;
  final double elevation;
  final ShapeBorder? shape;
  final bool enableSplash, splashByBaseColor;

  const Button(
      {this.key,
      this.child,
      this.elevation = 0,
      this.onTap,
      this.onLongPress,
      this.onDoubleTap,
      this.padding,
      this.color,
      this.splash,
      this.highlightColor,
      this.radius,
      this.margin,
      this.shape,
      this.enableSplash = true,
      this.splashByBaseColor = false,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      child: Material(
        key: key,
        elevation: elevation,
        color: color ?? Colors.transparent,
        borderRadius: radius,
        shape: shape,
        child: InkWell(
            onDoubleTap: onDoubleTap,
            onLongPress: onLongPress,
            splashColor: !enableSplash
                ? Colors.transparent
                : splash ??
                    (color == null || !splashByBaseColor
                        ? Color.fromRGBO(0, 0, 0, .03)
                        : color?.withOpacity(.08)),
            highlightColor: !enableSplash
                ? Colors.transparent
                : highlightColor ??
                    (color == null || !splashByBaseColor
                        ? Color.fromRGBO(0, 0, 0, .03)
                        : color?.withOpacity(.1)),
            onTap: onTap,
            borderRadius: radius,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  border: border,
                ),
                padding: padding ?? EdgeInsets.all(0),
                child: child)),
      ),
    );
  }
}

/// Shortcut of `SizedBox.shrink()`
class None extends StatelessWidget {
  @override
  final Key? key;
  const None({this.key});

  @override
  Widget build(BuildContext context) => SizedBox.shrink(key: key);
}

///
/// ``` dart
/// PreventScrollGlow( // PreventScrollGlow is used for remove glow effect on ListView
///   child: ListView()
/// )
/// ```
class PreventScrollGlow extends StatelessWidget {
  final Widget child;
  const PreventScrollGlow({required this.child});

  @override
  Widget build(BuildContext context) =>
      ScrollConfiguration(behavior: ScrollConfig(), child: child);
}

class ScrollConfig extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
          BuildContext context, Widget child, AxisDirection axisDirection) =>
      child;
}

///
/// ``` dart
/// UnFocus( // UnFocus is used for remove all focus from TextField when screen touched
///   child: Scaffold()
/// )
/// ```
class UnFocus extends StatelessWidget {
  final Widget child;
  const UnFocus({required this.child});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Fn.unfocus(),
        child: child,
      );
}

/// ``` dart
/// FlipH( // flip horizontal to any widget
///   child: Icon()
/// )
/// ```
class FlipH extends StatelessWidget {
  final Widget icon;
  const FlipH(this.icon);

  @override
  Widget build(BuildContext context) => Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(pi),
      child: icon);
}

// custom widget or component
class Component {
  static appBar(context,
      {Color? color,
      Color? titleNIconColor,
      title,
      bool center = false,
      canBack = true,
      double elevation = .5,
      double spacing = 0,
      Function? onBack,
      List<Widget> actions = const [],
      PreferredSizeWidget? bottom,
      Widget? leading}) {
    return AppBar(
      backgroundColor: color ??= Colors.white,
      title: title is String
          ? Text(title,
              style: Gfont.black7
                  .copyWith(fontSize: 20, color: titleNIconColor ?? C.black7))
          : title,
      titleSpacing: spacing != 0
          ? spacing
          : !canBack
              ? NavigationToolbar.kMiddleSpacing
              : spacing,
      elevation: elevation,
      centerTitle: center,
      automaticallyImplyLeading: leading != null,
      leading: !canBack
          ? null
          : leading ??= IconButton(
              onPressed: () {
                if (onBack != null) {
                  onBack();
                } else {
                  Navigator.pop(context);
                }
              },
              icon: Icon(La.arrow_left, color: titleNIconColor ?? C.black7)),
      actions: actions,
      bottom: bottom,
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final dynamic title;
  final double maxHeight;
  final bool scrollable;
  final Widget? footer;
  final ScrollController? scrollController;

  const CustomBottomSheet(
      {required this.child,
      this.footer,
      this.title,
      this.maxHeight = 0,
      this.scrollable = true,
      this.scrollController});

  @override
  Widget build(BuildContext context) {
    double defaultMaxheight =
        (Get.height - (MediaQueryData.fromWindow(window).padding.top + 1));

    return ClipRRect(
      //borderRadius: BorderRadius() Br.radOnly({'tl': 5, 'tr': 5}),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3), topRight: Radius.circular(3)),
      child: Container(
          decoration: BoxDecoration(
              color: C.white, borderRadius: Br.radiusOnly({'tl': 3, 'tr': 3})),
          child: Column(
            mainAxisSize: Mas.min,
            children: [
              Material(
                color: C.none,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: Mas.min,
                      children: [
                        Container(
                          margin: Ei.sym(v: 10),
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                              color: C.black3, borderRadius: Br.circle),
                        ),
                        title == null
                            ? None()
                            : title is Widget
                                ? title
                                : Text('$title', style: Gfont.bold),
                        Container(
                          margin: Ei.only(t: title == null ? 0 : 10),
                          constraints: BoxConstraints(
                              maxHeight: maxHeight == 0
                                  ? defaultMaxheight
                                  : maxHeight >= defaultMaxheight
                                      ? defaultMaxheight
                                      : maxHeight),
                          child: SingleChildScrollView(
                              controller: scrollController,
                              physics: scrollable
                                  ? BouncingScrollPhysics()
                                  : NeverScrollableScrollPhysics(),
                              child: child),
                        )
                      ],
                    ),
                    Positioned.fill(child: footer ?? Container())
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class Optionz extends StatelessWidget {
  final List<String> options, descriptions;
  final List<int> danger, disabled, hide;
  final List<IconData> icons;
  final int active;
  const Optionz(this.options,
      {this.danger = const [],
      this.disabled = const [],
      this.hide = const [],
      this.active = -1,
      this.descriptions = const [],
      this.icons = const []});

  @override
  Widget build(BuildContext context) {
    hide.forEach((index) {
      options.removeAt(index);
      descriptions.removeAt(index);
      icons.removeAt(index);
    });

    return CustomBottomSheet(
      child: Container(
        padding: Ei.only(b: 50),
        child: Column(
          crossAxisAlignment: descriptions.isEmpty ? Caa.center : Caa.start,
          children: List.generate(options.length, (i) {
            Widget titleDesc = Flexible(
                child: Column(
              crossAxisAlignment: Caa.start,
              children: [
                Text(options[i],
                    style: gfont.copyWith(
                        color: danger.contains(i) ? C.red : C.black7)),
                descriptions.isEmpty
                    ? None()
                    : descriptions[i].isEmpty
                        ? None()
                        : Textiner(descriptions[i],
                            margin: Ei.only(t: 5),
                            style: gfont.copyWith(
                                color: danger.contains(i)
                                    ? C.red.withOpacity(.8)
                                    : C.black5)),
              ],
            ));

            return Button(
              onTap: disabled.contains(i) ? null : () => Get.back(result: i),
              color: i == active ? C.black1 : C.white,
              child: Container(
                  padding: Ei.all(15),
                  width: Get.width,
                  decoration: BoxDecoration(
                      border: Border(top: Br.side(i == 0 ? C.none : C.black1))),
                  child: Opacity(
                      opacity: disabled.contains(i) ? .5 : 1,
                      child: descriptions.isEmpty
                          ? Text(options[i],
                              textAlign: Ta.center,
                              style:
                                  danger.contains(i) ? Gfont.red : Gfont.black7)
                          : icons.isEmpty
                              ? Row(children: [titleDesc])
                              : Row(
                                  crossAxisAlignment: Caa.start,
                                  children: [
                                    Container(
                                      margin: Ei.only(r: 15, t: 1),
                                      child: Icon(icons[i],
                                          size: 25,
                                          color: danger.contains(i)
                                              ? C.red
                                              : C.black6),
                                    ),
                                    titleDesc
                                  ],
                                ))),
            );
          }),
        ),
      ),
    );
  }
}

class Modal {
  /// Easy and quick way to use `showDialog()`
  ///
  /// ``` dart
  /// Modal.open(CustomWidget());
  /// ```
  ///
  static Future open(Widget widget,
      {Function? onInit, bool dismiss = true, Function(dynamic)? then}) async {
    if (onInit != null) onInit();

    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: dismiss,
        builder: (_) => widget).then((_) => then == null ? () {} : then(_));
  }

  /// Shortcut dari fungsi `showModalBottomSheet()`
  ///
  /// ``` dart
  /// Modal.bottomSheet(CustomWidget(), onInit: () => );
  /// ```
  ///
  static Future bottomSheet(Widget widget,
      {Function? onInit, Function(dynamic)? then}) async {
    if (onInit != null) onInit();

    Fn.unfocus();

    showModalBottomSheet<dynamic>(
            isScrollControlled: true,
            context: Get.overlayContext!,
            backgroundColor: Colors.transparent,
            builder: (BuildContext _) => widget)
        .then((_) => then == null ? () {} : then(_));
  }
}

/// `CenterDialog` akan memberikan widget untuk `ShowDialog` pada posisi tengah, sehingga kita hanya fokus pada isi dari dialog tersebut
///
/// ``` dart
/// CenterDialog(
///   child: /// your widget
/// )
/// ```
// class CenterDialog extends StatelessWidget {
//   final Widget child;
//   final double margin;

//   const CenterDialog({required this.child, this.margin = 15});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: Ei.only(b: MediaQuery.of(context).viewInsets.bottom),
//       child: Center(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [Material(color: Colors.transparent, child: Container(margin: EdgeInsets.all(margin), child: child))])),
//     );
//   }
// }

class Indicator {
  /// ``` dart
  /// Indicator.overlay();
  /// ```
  static overlay(
      {String? message,
      bool dismiss = false,
      Function? then,
      double size = 50,
      TextStyle? messageStyle}) async {
    Get.dialog(
            CenterDialog(
              child: ZoomIn(
                child: Column(
                  children: [
                    SizedBox(
                      height: size,
                      width: size,
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          strokeWidth: 2),
                    ),
                    message == null
                        ? SizedBox.shrink()
                        : Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(message,
                                style:
                                    messageStyle ?? TextStyle(color: C.white)))
                  ],
                ),
              ),
            ),
            barrierDismissible: dismiss)
        .then((value) {
      if (then != null) then(value);
    });
  }

  /// ``` dart
  /// Indicator.spiner();
  /// ```
  static spiner(
      {Key? key,
      double size = 17,
      Color color = Colors.white,
      EdgeInsetsGeometry? margin}) {
    return Container(
      margin: margin,
      child: SizedBox(
        key: key,
        height: size,
        width: size,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(color), strokeWidth: 2),
      ),
    );
  }
}

class NoData extends StatelessWidget {
  final dynamic icon;
  final String title, message, onTapLabel;
  final Function()? onTap;
  final double size;

  const NoData(
      {this.title = '',
      this.message = '',
      this.onTap,
      this.onTapLabel = 'Muat ulang',
      required this.icon,
      this.size = 70});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ZoomIn(
        child: Column(
          mainAxisAlignment: Maa.center,
          children: [
            icon is String
                ? icon.split('.').last.toLowerCase() == 'svg'
                    ? SvgPicture.asset('assets/images/$icon',
                        height: size, width: size)
                    : Container(
                        margin: Ei.sym(v: 15),
                        height: size,
                        width: size,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/$icon'))),
                      )
                : icon,
            GestureDetector(
              onTap: onTap == null ? null : () => onTap!(),
              child: Container(
                padding: Ei.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent)),
                child: Column(
                  children: [
                    title.isEmpty
                        ? None()
                        : Textiner(title,
                            style: Gfont.bold, margin: Ei.only(b: 5)),
                    Container(
                      alignment: Alignment.center,
                      child: Text(message,
                          style: gfont.copyWith(color: C.black5),
                          textAlign: Ta.center),
                    ),
                    onTap == null
                        ? None()
                        : Container(
                            padding: Ei.all(10),
                            child: Text(onTapLabel,
                                style: gfont.copyWith(
                                    color: C.blue,
                                    fontWeight: FontWeight.bold)),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Refreshtor extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const Refreshtor({required this.onRefresh, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
        onRefresh: onRefresh,
        builder: (
          BuildContext context,
          Widget child,
          IndicatorController controller,
        ) {
          return Stack(children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext? context, Widget? _) {
                return controller.isLoading || controller.value <= 0.1
                    ? None()
                    : SlideDown(
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: controller.value >= 1
                              ? 1
                              : controller.value <= 0
                                  ? 0
                                  : controller.value,
                          child: Container(
                              alignment: Alignment.center,
                              height: 110 * controller.value,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedContainer(
                                      duration: Duration(milliseconds: 100),
                                      height: 2,
                                      width: 50 * controller.value,
                                      decoration: BoxDecoration(
                                          color: controller.isArmed
                                              ? C.blue
                                              : C.black5,
                                          borderRadius: Br.radius(50))),
                                  Textiner(
                                      controller.isArmed
                                          ? 'Release to refresh'
                                          : 'Pull down to refresh',
                                      style: gfont.copyWith(
                                          fontSize: 13,
                                          color: controller.isArmed
                                              ? C.blue
                                              : C.black5),
                                      margin: Ei.only(t: 20))
                                ],
                              )),
                        ),
                      );
              },
            ),
            child
          ]);
        },
        child: child);
  }
}

class ConfirmWidget extends StatelessWidget {
  final String? title, message;
  final String cancelLabel;
  const ConfirmWidget({this.title, this.message, this.cancelLabel = 'Batal'});

  @override
  Widget build(BuildContext context) {
    return CenterDialog(
      child: SlideUp(
        child: ClipRRect(
          borderRadius: Br.radius(2),
          child: Container(
            decoration: BoxDecoration(color: C.white),
            child: Column(
              children: [
                Container(
                  margin: Ei.sym(v: 15),
                  padding: Ei.all(15),
                  child: Column(
                    children: [
                      Textiner('$title',
                          style: Gfont.bold
                              .copyWith(color: C.black6, fontSize: 17),
                          margin: Ei.only(b: 7)),
                      Textiner('$message',
                          style: Gfont.black5, textAlign: Ta.center),
                    ],
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border(top: Br.side(C.black1))),
                  child: Intrinsic(
                      children: List.generate(2, (i) {
                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                left: Br.side(i == 0 ? C.none : C.black1))),
                        child: Button(
                            onTap: () => Get.back(result: i == 0 ? null : i),
                            padding: Ei.all(15),
                            color: i == 0 ? C.black1 : C.white,
                            child: Text(i == 0 ? cancelLabel : 'Ya',
                                textAlign: Ta.center)),
                      ),
                    );
                  })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageURL extends StatelessWidget {
  final String? url;
  final BoxFit? fit;
  final Widget? indicator;

  const ImageURL(this.url, {this.fit = BoxFit.cover, this.indicator});

  @override
  Widget build(BuildContext context) {
    return url == null
        ? None()
        : CachedNetworkImage(
            fit: fit,
            imageUrl: url!,
            memCacheHeight: null,
            memCacheWidth: 375,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                indicator ??
                Container(
                  decoration: BoxDecoration(
                    color: C.black1,
                  ),
                  padding: Ei.all(10),
                  child: Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress, strokeWidth: 2)),
                ),
            errorWidget: (context, url, error) => Center(
              child: Icon(La.exclamation),
            ),
          );
  }
}

class Skeleton extends StatelessWidget {
  final Color baseColor, highlightColor, color;
  final double radius;
  final EdgeInsets? margin;

  /// [width, height]
  final dynamic size;

  const Skeleton(
      {this.baseColor = Colors.black26,
      this.highlightColor = Colors.black12,
      this.color = Colors.black54,
      this.margin,
      this.size = const [50, 15],
      this.radius = 0});

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            width: size is List ? size[0].toDouble() : size.toDouble(),
            height: size is List
                ? size.length == 1
                    ? 15.0
                    : size[1].toDouble()
                : size.toDouble(),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(radius)),
          ),
        ),
      );
}

// class TextHtml extends StatelessWidget {
//   final String data;
//   final double fontSize;

//   const TextHtml(this.data, {this.fontSize = 15});

//   @override
//   Widget build(BuildContext context) {
//     return Html(
//       data: data,
//       style: {
//         "body": Style(
//           fontSize: FontSize(fontSize),
//         ),
//       },
//     );
//   }
// }

class IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? margin;

  const IconLabel(this.icon, this.label,
      {this.color = C.black7, this.textStyle, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          Flexible(
              child: Textiner(label, style: textStyle, margin: Ei.only(l: 10)))
        ],
      ),
    );
  }
}
