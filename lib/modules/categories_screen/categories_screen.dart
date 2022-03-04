import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCategoriesScreen(
                ShopCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Container(
                    width: double.infinity,
                    height: 1.5,
                    color: Colors.grey[300],
                  ),
                ),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data.data.length);
      },
    );
  }

  Widget buildCategoriesScreen(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              child: Image(
                image: NetworkImage(model.image),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              model.name,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
          ],
        ),
      );
}
