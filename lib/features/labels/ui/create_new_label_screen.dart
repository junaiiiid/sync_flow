import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flow_sync/constants/extensions.dart';
import '../../../architecture/app_parent_widget.dart';
import '../../../global_widgets/app_buttons.dart';
import '../../../global_widgets/app_drop_downs.dart';
import '../../../global_widgets/app_text_fields.dart';
import '../../../services/language_service.dart';
import '../../../services/provider_service.dart';
import '../../../styles_and_themes/app_colors.dart';
import '../../../styles_and_themes/app_text_styles.dart';
import '../../home/ui/widgets/custom_app_bar.dart';

class CreateNewLabelScreen extends ConsumerWidget {
  static const String id = "/create_new_label";
  const CreateNewLabelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(ProviderService.createNewLabelProvider);
    return AppParentWidget(
        viewModel: viewModel,
        buildMethod: (context, ref) {
          return Container(
            color: AppColors.darkGrey,
            child: SafeArea(
              child: Scaffold(
                appBar: CustomAppBar.appBarWithBackButton(title: LanguageService.getString.newLabel),
                body: Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Form(
                    key: viewModel.formKey,
                    child: ListView(
                      children: [
                        AppTextFields.basicTextField(
                          title: LanguageService.getString.enterLabelName,
                          hintText: LanguageService.getString.egTodo,
                          maxLength: 30,
                          controller: viewModel.labelNameController,
                        ),
                        AppDropDowns.customDropDown<String>(
                            title: LanguageService.getString.selectLabelColor,
                            items: viewModel.colorNames,
                            onChanged: (value) {
                              viewModel.selectedColor = value;
                            },
                            hint: LanguageService.getString.egRed,
                            itemBuilder: (value) {
                              return Row(
                                children: [
                                  Container(
                                    height: 20.h,
                                    width: 20.w,
                                    color: value?.toColor(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 25.w),
                                    child: Text(
                                      value?.toColorName() ?? "",
                                      style: AppTextStyles.displaySmall?.copyWith(
                                        color: AppColors.darkGrey,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                        AppButtons.customButton(title: LanguageService.getString.create, onTap: ()async{
                          await viewModel.createNewLabel();
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
