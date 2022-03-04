import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/modules/search_screen/search_cubit/cubit.dart';
import 'package:myapp/modules/search_screen/search_cubit/states.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../models/search_model.dart';
import '../../shared/components.dart';

class ShopSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validation: (String value) {
                          if (value.isEmpty) {
                            return 'enter text to search';
                          }

                          return null;
                        },
                        onSubmitted: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        isPassword: false,
                        suffix: Icons.arrow_forward,
                        suffixPressed: () {
                          SearchCubit.get(context)
                              .search(searchController.text);
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildSearchItem(
                            SearchCubit.get(context).model!.data!.data[index],
                            context,
                          ),
                          separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 10,
                          ),
                          itemCount:
                              SearchCubit.get(context).model!.data!.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(Product model, context) => Padding(
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
