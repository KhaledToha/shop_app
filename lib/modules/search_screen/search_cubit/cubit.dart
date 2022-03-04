import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/modules/search_screen/search_cubit/states.dart';

import '../../../models/search_model.dart';
import '../../../shared/end_points.dart';
import '../../../shared/local/cache_helper.dart';
import '../../../shared/network/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: Search,
      token: CacheHelper.getData(key: 'token'),
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
