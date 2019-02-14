import 'package:redux/redux.dart';
import 'package:what_when_where/redux/app/state.dart';
import 'package:what_when_where/redux/init/actions.dart';
import 'package:what_when_where/redux/settings/actions.dart';

class InitMiddleware {
  static final List<Middleware<AppState>> middleware = [
    TypedMiddleware<AppState, Init>(_onInit),
  ];

  static void _onInit(Store<AppState> store, Init action, NextDispatcher next) {
    next(action);

    store.dispatch(const ReadSettings());
  }
}
