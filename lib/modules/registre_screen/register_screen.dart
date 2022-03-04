import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components.dart';
import '../../shared/local/cache_helper.dart';
import '../products_screen/products_screen.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status) {
              addToast(message: '${state.registerModel.message}');

              CacheHelper.saveDara(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                navigateAndFinish(context, ProductsScreen());
              });
            } else {
              addToast(message: '${state.registerModel.message}');
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: GoogleFonts.poppins(
                              fontSize: 34, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'REGISTER to see our hot offers',
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            isPassword: false,
                            label: 'User Name',
                            prefix: Icons.person,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return ('Please enter your name');
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.text,
                            isPassword: false,
                            label: 'Email-Address',
                            prefix: Icons.email,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return ('Please enter your email');
                              }
                            }),
                        const SizedBox(height: 15),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            isPassword: false,
                            label: 'Phone-Number',
                            prefix: Icons.phone,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return ('Please enter your email');
                              }
                            }),
                        const SizedBox(height: 15),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.text,
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validation: (String value) {
                            if (value.isEmpty) {
                              return ('Please enter your email');
                            }
                          },
                          // onSubmitted: (value) {
                          //   if (formKey.currentState!.validate()) {
                          //     ShopRegisterCubit.get(context).userLogin(
                          //       email: emailController.text,
                          //       password: passwordController.text,
                          //     );
                          //   }
                          // }
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'Continue',
                              isUpperCase: true,
                              radius: 5),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
