part of 'quots_bloc.dart';

@immutable
sealed class QuotsState {}

class QuotsInitialState extends QuotsState {}

final class QuotsLoadingState extends QuotsState {}

final class QuotsLoadedState extends QuotsState {
  QuoteModel quoteData;
  QuotsLoadedState({required this.quoteData});
}

final class QuotsErrorState extends QuotsState {
  String errorMessage;
  QuotsErrorState({required this.errorMessage});
}
