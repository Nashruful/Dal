import 'package:components/component/custom_text_field/custom_text_form_field.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/screens/edit_profile_screen/cubit/edit_profile_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<EditProfileCubit>();
        final formKey = GlobalKey<FormState>();
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: const Color(0xffA51361),
            foregroundColor: const Color(0xffF7F7F7),
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text('Edit Profile',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          body: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        cubit.pickAdsImage();
                      },
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          height: 100,
                          width: 100,
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                                blurStyle: BlurStyle.outer,
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                                color:
                                    const Color(0xff000000).withOpacity(0.25))
                          ]),
                          child: (state is AdsImageState && state.image != null)
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
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text('First Name',
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      fillColor: const Color(0xffEAEAEA),
                      hintText: '',
                      hintStyle: const TextStyle(color: Color(0xff848484)),
                      controller: cubit.firstNameController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text('Last Name',
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      fillColor: const Color(0xffEAEAEA),
                      hintText: '',
                      hintStyle: const TextStyle(color: Color(0xff848484)),
                      controller: cubit.lastNameController,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    CustomElevatedButton(
                      backgroundColor: const Color(0xffA51361),
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {}
                      },
                      child: Text('Save',
                          style: Theme.of(context).textTheme.bodyMedium),
                    )
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
