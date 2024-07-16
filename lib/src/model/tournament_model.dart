import 'package:flutter_tournament_bracket/src/model/tournament_match.dart';

/// A class representing a tournament.
///
/// The [Tournament] class contains a list of matches that are part of the tournament.
class Tournament {
  /// Creates a [Tournament] instance.
  ///
  /// The [matches] parameter must not be null.
  Tournament({
    required this.matches,
  });

  /// A list of matches in the tournament.
  final List<TournamentMatch> matches;
}
