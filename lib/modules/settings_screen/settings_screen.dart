import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          nameController.text = ShopCubit.get(context).profileModel!.data!.name;
          emailController.text =
              ShopCubit.get(context).profileModel!.data!.email;
          phoneController.text =
              ShopCubit.get(context).profileModel!.data!.phone;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        ShopCubit.get(context).profileModel!.data!.image),
                    radius: 120,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: InputBorder.none),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: InputBorder.none),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  defaultButton(
                      function: () {
                        ShopCubit.get(context).updateData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      },
                      text: 'Update'),
                  if (state is ShopLoadingUpdateProfileState)
                    LinearProgressIndicator(),
                  SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      signOut(context);
                    },
                    color: Colors.grey[700],
                    height: 44,
                    minWidth: double.infinity,
                    child: Text(
                      'LOG OUT',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
