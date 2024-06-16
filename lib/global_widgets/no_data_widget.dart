import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/provider_service.dart';
import '../styles_and_themes/app_text_styles.dart';

class NoDataWidget extends ConsumerWidget {
  final String content;
  const NoDataWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeEngine = ref.watch(ProviderService.themeEngineProvider);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/3),
      child: Center(child: Text(content,style:AppTextStyles.labelMedium?.copyWith(color: themeEngine.textColor))),
    );
  }
}
