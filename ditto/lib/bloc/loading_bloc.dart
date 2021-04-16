import 'dart:async';

import 'package:ditto/helper/load_events.dart';
import 'package:ditto/service_locator.dart';
import 'package:event_bus/event_bus.dart';
import 'package:rxdart/rxdart.dart';

class LoadingBloc {

  StreamSubscription _eventSub;
  BehaviorSubject<bool> _controller = BehaviorSubject();

  LoadingBloc(){
    _eventSub = locator<EventBus>().on<LoadEvent>().listen((event) {
      _controller.add(event.isLoading);
    });
  }

  void dispose() {
    _controller.close();
    _eventSub.cancel();
  }

  Stream<bool> get isLoading => _controller.stream;

}