import 'package:flow_sync/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(AppAssets.loaderAnimation),
    );
  }
}
