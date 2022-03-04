import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => buildWidget(ShopCubit.get(context).homeModel!,
                ShopCubit.get(context).categoriesModel!, context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildWidget(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                reverse: false,
                enableInfiniteScroll: true,
                initialPage: 0,
                pauseAutoPlayOnTouch: true,
                viewportFraction: 1.0,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Categories',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 120,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildCategoriesItems(
                          categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 20),
                      itemCount: categoriesModel.data.data.length),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Products',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(10),
                  childAspectRatio: 1 / 1.9,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  children: List.generate(
                      model.data.products.length,
                      (index) => buildProductItem(
                          model.data.products[index], context)),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildCategoriesItems(DataModel model) =>
      Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        Container(
          width: 100,
          height: 100,
          child: Image(
            image: NetworkImage(
              model.image,
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(.7),
          child: Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ]);

  Widget buildProductItem(ProductsModel model, context) => Container(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: AlignmentDirectional.topEnd, children: [
                Container(
                  width: 220,
                  height: 220,
                  child: Image(
                    image: NetworkImage(model.image),
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                if (model.price < model.old_price)
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red,
                    ),
                    child: Text(
                      'Discount',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
              ]),
              const SizedBox(height: 10),
              Text(
                model.name,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(width: 8),
                  if (model.price < model.old_price)
                    Text(
                      '${model.old_price.round()}',
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey),
                    ),
                  Spacer(),
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
            ],
          ),
        ),
      );
}
