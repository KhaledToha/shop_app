import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/modules/registre_screen/cubit/register_states.dart';

import '../../../models/register_model.dart';
import '../../../shared/end_points.dart';
import '../../../shared/network/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopRegisterModel? registerModel;
  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;

    emit(ShopRegisterShowPasswordState());
  }

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    emit(ShopRegisterLoadingState());

    await DioHelper.postData(url: Register, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      registerModel = ShopRegisterModel.fromjson(value.data);
      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
