import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_text_field/custom_text_form_field.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/screens/edit_profile_screen/cubit/edit_profile_cubit.dart';
import 'package:user_app/setup/setup.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
//
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<EditProfileCubit>();
        final formKey = GlobalKey<FormState>();
        return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: CustomAppBar(
                title: 'Edit Profile'.tr(), automaticallyImplyLeading: true),
            body: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<EditProfileCubit, EditProfileState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () async {
                            cubit.pickAdsImage();
                          },
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        blurStyle: BlurStyle.outer,
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                        color: const Color(0xff000000)
                                            .withOpacity(0.25))
                                  ]),
                              child: (state is AdsImageState &&
                                      state.image != null)
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(
                                        state.image!,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Center(
                                      child: Text('Edit',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text('First Name'.tr(),
                            style: Theme.of(context).textTheme.bodyLarge)
                        .tr(),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      fillColor: const Color(0xffEAEAEA),
                      maxLines: 1,
                      hintStyle: const TextStyle(color: Color(0xff848484)),
                      controller: cubit.firstNameController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text('Last Name'.tr(),
                            style: Theme.of(context).textTheme.bodyLarge)
                        .tr(),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      fillColor: const Color(0xffEAEAEA),
                      hintStyle: const TextStyle(color: Color(0xff848484)),
                      maxLines: 1,
                      controller: cubit.lastNameController,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    CustomElevatedButton(
                      backgroundColor: const Color(0xffA51361),
                      onPressed: () async {
                        if (formKey.currentState?.validate() == true) {
                          await cubit.changeName(cubit.firstNameController.text,
                              cubit.lastNameController.text);
                              
                          Navigator.pop(context, true);
                          
                        }
                      },
                      child: Text('Save'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium),
                    )
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
