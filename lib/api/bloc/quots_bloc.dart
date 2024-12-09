import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/App_Exception/app_exception.dart';
import 'package:project/api/api_helper.dart';
import 'package:project/api/quote_model.dart';
import 'package:project/api/urls.dart';

part 'quots_event.dart';

part 'quots_state.dart';

class QuotsBloc extends Bloc<QuotsEvent, QuotsState> {
  ApiHelper apiHelper;

  QuotsBloc({required this.apiHelper}) : super(QuotsInitialState()) {
    on<GetQuotesEvents>((event, emit) async {
      emit(QuotsLoadingState());
      try {
        var responseJson = await apiHelper.getAPI(url: Urls.getQuotes);
        print(responseJson);
        if (responseJson != null) {
          var mResData = QuoteModel.fromJson(responseJson);
          emit(QuotsLoadedState(quoteData: mResData));
        } else {
          emit(QuotsErrorState(errorMessage: "errorMessage"));
        }
      } catch (e) {
        emit(QuotsErrorState(errorMessage: (e as AppExceptions).toErrormsg()));
      }
    });
  }
}
