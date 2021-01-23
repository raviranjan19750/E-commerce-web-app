import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/service/analytics_repo.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final AnalyticsRepository analyticsRepository;

  AnalyticsBloc({this.analyticsRepository})
      : assert(analyticsRepository != null),
        super(AnalyticsInitial());

  @override
  Stream<AnalyticsState> mapEventToState(
    AnalyticsEvent event,
  ) async* {
    if (event is TestAllAnalyticsEvent) {
      await analyticsRepository.testAllEventTypes();
    }
  }
}
