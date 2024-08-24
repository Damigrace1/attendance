import 'package:flutter/material.dart';
import 'package:qr_attendance_system/core/theme/app_decoration.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';

class BaseScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final Color? appBarColor;
  final Color? bodyColor;
  final Color curvedContainerColor;
  final Widget appBarchild;
  final Widget? bodychild;
  final EdgeInsetsGeometry? padding;
  const BaseScaffold(
      {super.key,
      this.backgroundColor,
      this.appBarColor,
      this.bodyColor,
      this.curvedContainerColor = AppPallete.backgroundColor,
      this.appBarchild = const SizedBox.shrink(),
      this.bodychild,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: AppDecoration.containerBottomDecor
                  .copyWith(color: appBarColor),
              child: Stack(
                children: [
                  Positioned.fill(child: appBarchild),
                  Positioned(
                    top: -20,
                    left: -40,
                    child: CustomPaint(
                      painter: CurvedContainer(curvedContainerColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: AppDecoration.containerTopDecor.copyWith(
                color: bodyColor,
              ),
              padding: padding ?? const EdgeInsets.all(15.0),
              child: bodychild,
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedContainer extends CustomPainter {
  final Color backgroundColor;
  CurvedContainer(this.backgroundColor);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
// TODO: refactor to draw path and remove stack widget
    // var path = Path()
    //   ..moveTo(0, 0)
    //   ..lineTo(0, 25)
    //   ..quadraticBezierTo(25, 50, 50, 25)
    //   ..quadraticBezierTo(100, 25, 50, 0)
    //   // ..lineTo(50, 25)
    //   // ..lineTo(50, 0)
    //   ..close();
    // canvas.drawPath(path, paint);
    const rect = Rect.fromLTRB(0, 0, 108, 52);
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
