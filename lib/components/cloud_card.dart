import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'diamond_button.dart';

class CloudCard extends StatelessWidget {
  double size;

  CloudCard({required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomPaint(
        size: Size(size, (size * 0.7949438202247191).toDouble()),
        painter: CloudPainter(Color(0xffdfdddc)),
        child: Container(
          width: double.infinity,
          height: size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 92.0),
                child: Container(
                  width: 256,
                  child: const Text(
                    "Cozinhar com o que tem em casa!",
                    style: TextStyle(
                      color: Color(0xFF6A515E),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DiamondButton(
                  icon: Icon(Icons.arrow_upward_rounded),
                  onClick: () {
                    Navigator.pushNamed(context, "/login");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CloudPainter extends CustomPainter {
  Color color;

  CloudPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9613511, size.height * 0.1670382);
    path_0.cubicTo(size.width * 0.9578034, size.height * 0.1631724, size.width * 0.9666742, size.height * 0.1728371, size.width * 0.9645169,
        size.height * 0.1706700);
    path_0.cubicTo(size.width * 0.9603371, size.height * 0.1664742, size.width * 0.9585787, size.height * 0.1648696, size.width * 0.9541067,
        size.height * 0.1611827);
    path_0.cubicTo(size.width * 0.9517978, size.height * 0.1592781, size.width * 0.9425758, size.height * 0.1523237, size.width * 0.9241376,
        size.height * 0.1384145);
    path_0.cubicTo(size.width * 0.8720506, size.height * 0.09912792, size.width * 0.8132275, size.height * 0.06724770,
        size.width * 0.7497669, size.height * 0.04401661);
    path_0.cubicTo(size.width * 0.6703820, size.height * 0.01495682, size.width * 0.5853006, 0, size.width * 0.4993792, 0);
    path_0.cubicTo(
        size.width * 0.4134551, 0, size.width * 0.3283736, size.height * 0.01495682, size.width * 0.2489899, size.height * 0.04401661);
    path_0.cubicTo(size.width * 0.1876708, size.height * 0.06646360, size.width * 0.1306798, size.height * 0.09698587,
        size.width * 0.07991517, size.height * 0.1344625);
    path_0.cubicTo(size.width * 0.05517388, size.height * 0.1527279, size.width * 0.04280309, size.height * 0.1618604,
        size.width * 0.04052753, size.height * 0.1636954);
    path_0.cubicTo(size.width * 0.03355112, size.height * 0.1693201, size.width * 0.03207022, size.height * 0.1706975,
        size.width * 0.02575171, size.height * 0.1774413);
    path_0.cubicTo(size.width * 0.02369073, size.height * 0.1796410, size.width * 0.03940815, size.height * 0.1614837,
        size.width * 0.03312107, size.height * 0.1687466);
    path_0.cubicTo(size.width * 0.01297455, size.height * 0.1920208, size.width * 0.01069933, size.height * 0.2255809,
        size.width * 0.006148848, size.height * 0.2927011);
    path_0.cubicTo(size.width * -0.003867725, size.height * 0.4404452, size.width * -0.0002528284, size.height * 0.5863216,
        size.width * 0.007087640, size.height * 0.6977385);
    path_0.cubicTo(size.width * 0.01155011, size.height * 0.7654700, size.width * 0.01378135, size.height * 0.7993357,
        size.width * 0.03394129, size.height * 0.8226820);
    path_0.cubicTo(size.width * 0.05410140, size.height * 0.8460283, size.width * 0.08269944, size.height * 0.8460283,
        size.width * 0.1398952, size.height * 0.8460283);
    path_0.lineTo(size.width * 0.3784354, size.height * 0.8460283);
    path_0.cubicTo(size.width * 0.3788624, size.height * 0.8460283, size.width * 0.3792079, size.height * 0.8464664, size.width * 0.3792079,
        size.height * 0.8470035);
    path_0.cubicTo(size.width * 0.3792079, size.height * 0.9303357, size.width * 0.4329101, size.height * 0.9978905, size.width * 0.4991573,
        size.height * 0.9978905);
    path_0.cubicTo(size.width * 0.5654017, size.height * 0.9978905, size.width * 0.6191039, size.height * 0.9303357, size.width * 0.6191039,
        size.height * 0.8470035);
    path_0.cubicTo(size.width * 0.6191039, size.height * 0.8464664, size.width * 0.6194494, size.height * 0.8460283, size.width * 0.6198764,
        size.height * 0.8460283);
    path_0.lineTo(size.width * 0.8489972, size.height * 0.8460283);
    path_0.cubicTo(size.width * 0.9061545, size.height * 0.8460283, size.width * 0.9347331, size.height * 0.8460283, size.width * 0.9546685,
        size.height * 0.8238092);
    path_0.cubicTo(size.width * 0.9746039, size.height * 0.8015866, size.width * 0.9779073, size.height * 0.7673569, size.width * 0.9845084,
        size.height * 0.6988940);
    path_0.cubicTo(size.width * 1.003907, size.height * 0.4977244, size.width * 0.9997051, size.height * 0.3505325, size.width * 0.9888483,
        size.height * 0.2558219);
    path_0.cubicTo(size.width * 0.9837135, size.height * 0.2110099, size.width * 0.9811461, size.height * 0.1886039, size.width * 0.9613511,
        size.height * 0.1670382);
    path_0.close();

    Paint paint_0_fill = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
