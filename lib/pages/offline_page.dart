import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/assets_image.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/services/network/network_service.dart';
import 'package:stdio_week_6/widgets/custom_button.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final netWorkService = context.read<NetWorkService>();
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.asset(
              AssetsImage.noInternet,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                 ConstString.noConection,
                  style: MyFont.blueHeading,
                ),
                const SizedBox(height: 36),
                const Text(
                  ConstString.noInternetTryAgain,
                  style: MyFont.blackTitle,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                          text: ConstString.retry,
                          onPressed: () async =>
                              await netWorkService.checkNetwork()),
                    ),
                    const Spacer(),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
