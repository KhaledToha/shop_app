import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/home_model.dart';

class FaviortesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
              (ShopCubit.get(context).favoritesModel!.data.data.length == 0),
          builder: (context) => Center(
            child: Text(
              'add items to your Favorites',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          fallback: (context) => ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildFavoritesItem(
                    ShopCubit.get(context)
                        .favoritesModel!
                        .data
                        .data[index]
                        .product,
                    context),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data.data.length),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildFavoritesItem(ProductsModel model, context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image(
                image: NetworkImage(model.image),
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    model.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: GoogleFonts.poppins(
                            color: Colors.deepOrange,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (model.price < model.old_price)
                        Text(
                          model.old_price.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            //Spacer(),
            IconButton(
              onPressed: () {
                ShopCubit.get(context).changeFavorites(model.id);
                print(model.id);
              },
              icon: const Icon(Icons.favorite),
              color: ShopCubit.get(context).favorites[model.id]!
                  ? Colors.deepOrange
                  : Colors.grey[300],
            )
          ],
        ),
      );
}
