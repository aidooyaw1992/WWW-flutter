import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:what_when_where/redux/app/state.dart';
import 'package:what_when_where/redux/sharing/actions.dart';
import 'package:what_when_where/services/sharing.dart';

@injectable
class ShareMiddleware {
  final ISharingService _sharingService;

  List<Middleware<AppState>> _middleware;
  Iterable<Middleware<AppState>> get middleware => _middleware;

  ShareMiddleware({
    ISharingService sharingService,
  }) : _sharingService = sharingService {
    _middleware = _createMiddleware();
  }

  List<Middleware<AppState>> _createMiddleware() => [
        TypedMiddleware<AppState, ShareQuestion>(_shareQuestion),
        TypedMiddleware<AppState, ShareTour>(_shareTour),
        TypedMiddleware<AppState, ShareTournament>(_shareTournament),
      ];

  void _shareTournament(
      Store<AppState> store, ShareTournament action, NextDispatcher next) {
    next(action);

    _sharingService.shareTournament(action.info);
  }

  void _shareTour(
      Store<AppState> store, ShareTour action, NextDispatcher next) {
    next(action);

    _sharingService.shareTour(action.info);
  }

  void _shareQuestion(
      Store<AppState> store, ShareQuestion action, NextDispatcher next) {
    next(action);

    _sharingService.shareQuestion(action.info, action.questionText);
  }
}
