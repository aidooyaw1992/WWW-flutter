import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:what_when_where/db_chgk_info/models/tour_info.dart';
import 'package:what_when_where/db_chgk_info/models/tournament_info.dart';
import 'package:what_when_where/redux/redux_action.dart';

part 'actions.freezed.dart';

abstract class DialogAction implements ReduxAction {}

@freezed
abstract class OpenTourInfoDialog
    with _$OpenTourInfoDialog
    implements DialogAction {
  const factory OpenTourInfoDialog({
    @required TourInfo info,
  }) = _OpenTourInfoDialog;
}

@freezed
abstract class OpenTournamentInfoDialog
    with _$OpenTournamentInfoDialog
    implements DialogAction {
  const factory OpenTournamentInfoDialog({
    @required TournamentInfo info,
  }) = _OpenTournamentInfoDialog;
}

@freezed
abstract class OpenRatingDialog
    with _$OpenRatingDialog
    implements DialogAction {
  const factory OpenRatingDialog() = _OpenRatingDialog;
}
