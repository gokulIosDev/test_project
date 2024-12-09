part of 'quots_bloc.dart';

@immutable
sealed class QuotsEvent {}
class GetQuotesEvents extends QuotsEvent{}