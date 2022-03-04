import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components.dart';
import '../../shared/local/cache_helper.dart';
import '../registre_screen/register_screen.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              addToast(message: '${state.loginModel.message}');

              CacheHelper.saveDara(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              addToast(message: '${state.loginModel.message}');
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
                          'LOGIN',
                          style: GoogleFonts.poppins(
                              fontSize: 34, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Login to see our hot offers',
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
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
                            controller: passwordController,
                            type: TextInputType.text,
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            label: 'Password',
                            prefix: Icons.lock,
                            suffix: ShopLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validation: (String value) {
                              if (value.isEmpty) {
                                return ('Please enter your email');
                              }
                            },
                            onSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'login',
                              isUpperCase: true,
                              radius: 5),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Do you have an account ?',
                              style: GoogleFonts.poppins(),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text(
                                'REGISTER',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
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
