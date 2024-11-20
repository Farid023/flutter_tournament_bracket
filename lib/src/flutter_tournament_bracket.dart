import 'package:flutter/material.dart';
import 'package:flutter_tournament_bracket/src/model/tournament_match.dart';
import 'package:flutter_tournament_bracket/src/model/tournament_model.dart';
import 'package:flutter_tournament_bracket/src/utils/calculate_separator_height.dart';

import 'widgets/bracket_match_card.dart';

/// A widget that displays a tournament bracket.
///
/// The [TournamentBracket] widget arranges a list of matches in a tournament format,
/// with lines connecting the matches to indicate progression.
///
/// The widget supports zooming and panning for better visibility.
class TournamentBracket extends StatelessWidget {
  /// Creates a [TournamentBracket] widget.
  ///
  /// The [list] parameter must not be null.
  const TournamentBracket({
    super.key,
    this.itemsMarginVertical = 20.0,
    this.cardHeight = 100.0,
    this.cardWidth = 220.0,
    this.card,
    required this.list,
    this.lineColor = Colors.green,
    this.lineBorderRadius = 10.0,
    this.lineWidth = 60.0,
    this.lineThickness = 5.0,
  }) : assert(lineThickness <= cardHeight / 2,
            "The line thickness must not exceed half the card height. Ensure that 'lineThickness' ($lineThickness) is <= 'cardHeight / 2' (${cardHeight / 2}).");

  /// The vertical margin between items in the bracket.
  final double itemsMarginVertical;

  /// The height of each match card.
  final double cardHeight;

  /// The width of the lines connecting the matches.
  final double cardWidth;

  /// A custom widget builder for the match card. If not provided, a default card will be used.
  ///
  /// The custom card widget should accept a `TournamentMatch` object as a parameter.
  ///
  /// Example usage:
  /// ```dart
  /// TournamentBracket(
  ///   card: (match) {
  ///     return CustomMatchCard(match); // Replace with your custom card widget.
  ///   },
  ///   // other parameters
  /// )
  /// ```
  ///
  /// In the example above, `CustomMatchCard` is a custom widget used to display details of
  /// each `TournamentMatch`. You can customize the appearance and behavior of match cards
  /// by implementing this builder function.
  final Widget Function(TournamentMatch match)? card;

  /// The color of the lines connecting the matches in the tournament bracket.
  final Color lineColor;

  /// The border radius of the lines connecting the matches.
  /// This determines how rounded the corners of the lines appear.
  final double lineBorderRadius;

  /// The width of the lines connecting the matches.
  /// This defines the horizontal span of the connecting lines.
  final double lineWidth;

  /// The thickness of the lines connecting the matches.
  ///
  /// Controls the thickness of the connector lines, affecting
  /// how bold the lines appear. The value must not exceed half of
  /// the [cardHeight] to maintain proper alignment and visual balance.
  final double lineThickness;

  /// A list representing the matches in the tournament.
  /// Each element in the list should have a `matches` property indicating the number of matches in that round.
  /// The number of matches should follow a structure where each round contains a number of matches that is a power of 2 (e.g., 16, 8, 4, 2, 1),
  /// reflecting the standard tournament elimination format where the number of matches halves each round.
  ///
  /// Example:
  ///
  /// ```dart
  /// final List<Tournament> tournaments = [
  ///   Tournament(matches: [
  ///     TournamentMatch(id: "1", teamA: "Real Madrid", teamB: "Barcelona", scoreTeamA: "3", scoreTeamB: "1"),
  ///     TournamentMatch(id: "2", teamA: "Chelsea", teamB: "Liverpool", scoreTeamA: "0", scoreTeamB: "1"),
  ///     TournamentMatch(id: "3", teamA: "Juventus", teamB: "Paris Saint-Germain", scoreTeamA: "0", scoreTeamB: "2"),
  ///     TournamentMatch(id: "4", teamA: "Manchester City", teamB: "Inter Milan", scoreTeamA: "4", scoreTeamB: "2"),
  ///   ]),
  ///   Tournament(matches: [
  ///     TournamentMatch(id: "1", teamA: "AC Milan", teamB: "Atletico Madrid", scoreTeamA: "4", scoreTeamB: "0"),
  ///     TournamentMatch(id: "2", teamA: "Borussia Dortmund", teamB: "Tottenham Hotspur", scoreTeamA: "2", scoreTeamB: "1"),
  ///   ]),
  ///   Tournament(matches: [
  ///     TournamentMatch(id: "1", teamA: "Ajax", teamB: "Sevilla", scoreTeamA: "4", scoreTeamB: "3"),
  ///   ]),
  /// ];
  ///
  final List<Tournament> list;

  @override
  Widget build(BuildContext context) {
    double separatorH = itemsMarginVertical;
    return InteractiveViewer(
      minScale: 0.1,
      maxScale: 3.0,
      boundaryMargin: const EdgeInsets.all(200.0),
      constrained: false,
      child: SizedBox(
        height: ((list.first.matches.length * cardHeight) +
            ((list.first.matches.length - 1) * separatorH) +
            100),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (_, index) {
            final Tournament item = list[index];
            separatorH = calculateSeparatorHeight(
                groupsSize: index,
                itemsMarginVertical: itemsMarginVertical,
                cardHeight: cardHeight);
            return _MatchesList(
              cardWidth: cardWidth,
              cardHeight: cardHeight,
              card: card,
              matchCount: item.matches.length,
              separatorHeight: separatorH,
              matches: item.matches,
            );
          },
          separatorBuilder: (_, index) {
            final Tournament item = list[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SizedBox(
                    width: lineWidth,
                    child: ListView.separated(
                      itemCount: item.matches.length ~/ 2,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: (separatorH + cardHeight),
                                // width: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                        right:
                                            Radius.circular(lineBorderRadius)),
                                    border: Border(
                                        top: BorderSide(
                                            color: lineColor,
                                            width: lineThickness,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter),
                                        right: BorderSide(
                                            color: lineColor,
                                            width: lineThickness,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter),
                                        bottom: BorderSide(
                                            color: lineColor,
                                            width: lineThickness,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter))),
                              ),
                            ),
                            Expanded(
                                child: Divider(
                              thickness: lineThickness,
                              height: lineThickness,
                              color: lineColor,
                            )),
                          ],
                        );
                      },
                      separatorBuilder: (_, index) {
                        return SizedBox(
                          height: (cardHeight + separatorH),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// A widget that displays a list of matches.
///
/// The [_MatchesList] widget arranges match cards in a vertical list with separators between them.
class _MatchesList extends StatelessWidget {
  /// Creates a [_MatchesList] widget.
  const _MatchesList({
    required this.matchCount,
    required this.separatorHeight,
    this.cardHeight = 100.0,
    this.cardWidth = 220.0,
    this.card,
    required this.matches,
  });

  /// The number of matches to be displayed.
  final int matchCount;

  /// The height of the separator between match cards.
  final double separatorHeight;

  /// The height of each match card.
  final double? cardHeight;

  /// The width of the lines connecting the matches.
  final double? cardWidth;

  /// A custom widget for the match card. If not provided, a default card is used.
  /// To apply data to custom card use:
  /// ```dart
  /// card: (item) {
  //   ///   return YourCustomWidget(item);
  //   /// }
  /// ```
  /// card: (item) {
  ///   return YourCustomWidget(item);
  /// }
  final Widget Function(TournamentMatch match)? card;

  final List<TournamentMatch> matches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth ?? 220.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: ListView.separated(
              itemCount: matches.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final TournamentMatch item = matches[index];

                return SizedBox(
                    height: cardHeight ?? 100.0,
                    child: card != null
                        ? card!(item)
                        : BracketMatchCard(
                            item: item,
                          ));
              },
              separatorBuilder: (_, int index) {
                return Container(
                  height: separatorHeight,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
