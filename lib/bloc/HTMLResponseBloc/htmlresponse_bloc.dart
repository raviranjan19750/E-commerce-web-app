import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:living_desire/DBHandler/footerRepository.dart';
import 'package:meta/meta.dart';

part 'htmlresponse_event.dart';

part 'htmlresponse_state.dart';

class HtmlResponseBloc extends Bloc<HtmlResponseEvent, HtmlResponseState> {
  FooterRepository footerRepository;

  HtmlResponseBloc({this.footerRepository})
      : assert(footerRepository != null),
        super(HtmlResponseInitial());

  @override
  Stream<HtmlResponseState> mapEventToState(
    HtmlResponseEvent event,
  ) async* {
    if (event is LoadHtmlResponse) {
      yield* loadHtmlResponseEvent(event);
    }
  }

  Stream<HtmlResponseState> loadHtmlResponseEvent(
      LoadHtmlResponse event) async* {
    yield HtmlResponseLoading();

    try {
      var result = await footerRepository.getAboutUs(event.htmlResponseFunctionEndPoint);
      yield HtmlResponseLoadingSuccessful(result);

    } catch (e) {
      print(e.toString());
      yield HtmlResponseLoadingFailure();
    }
  }
}
