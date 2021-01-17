part of 'htmlresponse_bloc.dart';

@immutable
abstract class HtmlResponseEvent {}

class LoadHtmlResponse extends HtmlResponseEvent{

   String htmlResponseFunctionEndPoint;

  LoadHtmlResponse(this.htmlResponseFunctionEndPoint);

}


