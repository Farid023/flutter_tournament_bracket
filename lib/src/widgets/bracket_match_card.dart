import 'package:flutter/material.dart';
import 'package:flutter_tournament_bracket/src/model/tournament_match.dart';

/// Widget for displaying a match card in a tournament bracket.
class BracketMatchCard extends StatelessWidget {
  /// Constructs a [BracketMatchCard] widget.
  ///
  /// [item] is the tournament match data to display.
  const BracketMatchCard({
    super.key,
    required this.item,
  });

  /// The tournament match data to display.
  final TournamentMatch item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  /// Displays the name of Team A.
                  item.teamA ?? "No Info",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  /// Displays the name of Team B.
                  item.teamB ?? "No Info",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                )
              ],
            ),
          ),
          const VerticalDivider(
            color: Colors.black,
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                /// Displays the score of Team A.
                item.scoreTeamA ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                /// Displays the score of Team B.
                item.scoreTeamB ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
    );
  }
}
