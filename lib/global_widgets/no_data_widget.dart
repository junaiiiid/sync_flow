import 'package:flutter/material.dart';

import '../styles_and_themes/app_text_styles.dart';

class NoDataWidget extends StatelessWidget {
  final String content;
  const NoDataWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/3),
      child: Center(child: Text(content,style:AppTextStyles.labelMedium)),
    );
  }
}
