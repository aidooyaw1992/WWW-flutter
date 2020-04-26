import 'package:what_when_where/db_chgk_info/models/question_info.dart';
import 'package:what_when_where/db_chgk_info/models/tour_info.dart';
import 'package:what_when_where/db_chgk_info/models/tournament_info.dart';
import 'package:what_when_where/services/url_launcher.dart';

abstract class IBrowsingService {
  void browseTournament(TournamentInfo info);

  void browseTour(TourInfo info);

  void browseQuestion(QuestionInfo info);
}

class BrowsingService implements IBrowsingService {
  final IUrlLauncher _urlLauncher;

  factory BrowsingService.ioc({IUrlLauncher urlLauncher}) =>
      BrowsingService._(urlLauncher);

  BrowsingService._(this._urlLauncher);

  @override
  void browseTournament(TournamentInfo info) =>
      _urlLauncher.launchURL(info.url);

  @override
  void browseTour(TourInfo info) => _urlLauncher.launchURL(info.url);

  @override
  void browseQuestion(QuestionInfo info) => _urlLauncher.launchURL(info.url);
}
