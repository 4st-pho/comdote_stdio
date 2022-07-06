import 'package:flutter/cupertino.dart';
import 'package:stdio_week_6/constants/assets_image.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AssetsImage.bgLogo1,
          height: 127,
          width: 186,
        ),
        Positioned(
          left: 186 / 2 - 50,
          bottom: 0,
          child: Image.asset(
            AssetsImage.logo1,
            height: 100,
          ),
        ),
      ],
    );
  }
}
