part of 'htmlresponse_bloc.dart';

@immutable
abstract class HtmlResponseState {}

class HtmlResponseInitial extends HtmlResponseState {}

class HtmlResponseLoading extends HtmlResponseState {}


// ignore: must_be_immutable
class HtmlResponseLoadingSuccessful extends HtmlResponseState {

  var htmlResponse;

  HtmlResponseLoadingSuccessful(this.htmlResponse);

}

class HtmlResponseLoadingFailure extends HtmlResponseState {}




