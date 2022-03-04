import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/notification_model.dart';
import '../modules/search_screen/search_screen.dart';
import '../shared/components.dart';
import 'cubit/shop_cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              'PROUD',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, ShopSearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    // showModalSideSheet(
                    //     width: double.infinity,
                    //     context: context,
                    //     withCloseControll: true,
                    //     body: Scaffold(
                    //       appBar: AppBar(
                    //         title: Text(
                    //           'NOTIFICATIONS',
                    //           style: GoogleFonts.poppins(
                    //               fontSize: 18, fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //       body: Padding(
                    //         padding: const EdgeInsets.all(20.0),
                    //         child: Expanded(
                    //           child: ListView.separated(
                    //               itemBuilder: (context, index) =>
                    //                   buildNotification(ShopCubit.get(context)
                    //                       .notificationModel!
                    //                       .data!
                    //                       .data[index]),
                    //               separatorBuilder: (context, index) =>
                    //                   Container(
                    //                     width: double.infinity,
                    //                     height: 5,
                    //                   ),
                    //               itemCount: ShopCubit.get(context)
                    //                   .notificationModel!
                    //                   .data!
                    //                   .data
                    //                   .length),
                    //         ),
                    //       ),
                    //     ));
                  },
                  icon: Icon(Icons.notifications))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              cubit.changeNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }

  Widget buildNotification(Data model) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber[100],
                  child: Icon(
                    Icons.notifications,
                    color: Colors.amber[700],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${model.message}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
