import 'package:flutter/material.dart';
import 'package:flutter_tournament_bracket/flutter_tournament_bracket.dart';

void main() {
  runApp(const MyApp());
}

// Define tournaments data
final List<Tournament> _tournaments = [
  Tournament(matches: [
    TournamentMatch(
        id: "1",
        teamA: "Real Madrid",
        teamB: "Barcelona",
        scoreTeamA: "3",
        scoreTeamB: "1"),
    TournamentMatch(
        id: "2",
        teamA: "Chelsea",
        teamB: "Liverpool",
        scoreTeamA: "0",
        scoreTeamB: "1"),
    TournamentMatch(
        id: "3",
        teamA: "Juventus",
        teamB: "Paris Saint-Germain",
        scoreTeamA: "0",
        scoreTeamB: "2"),
    TournamentMatch(
        id: "4",
        teamA: "Manchester City",
        teamB: "Inter Milan",
        scoreTeamA: "4",
        scoreTeamB: "2"),
  ]),
  Tournament(matches: [
    TournamentMatch(
        id: "1",
        teamA: "AC Milan",
        teamB: "Atletico Madrid",
        scoreTeamA: "4",
        scoreTeamB: "0"),
    TournamentMatch(
        id: "2",
        teamA: "Borussia Dortmund",
        teamB: "Tottenham Hotspur",
        scoreTeamA: "2",
        scoreTeamB: "1"),
  ]),
  Tournament(matches: [
    TournamentMatch(
        id: "1",
        teamA: "Ajax",
        teamB: "Sevilla",
        scoreTeamA: "4",
        scoreTeamB: "3"),
  ])
];

/// The main application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: TournamentBracket(
            list: _tournaments,
            card: (item) {
              return customMatchCard(item);
            },
            itemsMarginVertical: 20.0,
            cardWidth: 220.0,
            cardHeight: 100,
            lineWidth: 80,
            lineThickness: 5,
            lineBorderRadius: 12,
            lineColor: Colors.green,
          ),
        ),
      ),
    );
  }

  /// Custom widget to display match details.
  Container customMatchCard(TournamentMatch item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(12)),
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
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  item.teamA ?? "No Info",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
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
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                item.scoreTeamA ?? "",
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                item.scoreTeamB ?? "",
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
