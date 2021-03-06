import 'package:flutter/material.dart';
import 'package:weplayball/models/teamDetails.dart';
import 'package:weplayball/models/teamStat.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';
import 'package:weplayball/ui/statSummary.dart';

//  Scrollable widget
class TeamStats extends StatelessWidget{

  TeamStats(this.teamData, { Key key }) : super(key: key);

  TeamDetailsModel teamData;
  List<TeamStatModel> statCards;

  Widget _buildCards(BuildContext context, int index) {
    var teamStatCard = statCards[index];

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: StatSummary(teamStatCard),
    );
  }

  @override
  Widget build(BuildContext context) {

    _buildTeamStatData();

    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          addSizedBoxPadding(12.0, 0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child:  Text(
              "Team Stats",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Poppins',
                color: Color(getColourHexFromString(primaryBlack)),
                fontSize: fontSizeH4,
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),

          Container(
            height: 219.0,
            child: ListView(
              scrollDirection: Axis.horizontal, children: statCards.map((item) => new StatSummary(item)).toList(),
            ),
          )
        ],
      ),
    );

  }




  void _buildTeamStatData()
  {
    statCards = new List();

    var winPercent = _buildTeamWinPercent();
    statCards.add(winPercent);

    var lossPercent = _buildTeamLossPercent();
    statCards.add(lossPercent);

    var bpg = _buildTeamBPG();
    statCards.add(bpg);

    var winLossPercent = _buildTeamWLPercentage();
    statCards.add(winLossPercent);

    var winsOver500 = _buildTeamWinsOver500();
    statCards.add(winsOver500);

    var wypth = _buildTeamWPyth();
    statCards.add(wypth);

    var bf = _buildTeamBF();
    statCards.add(bf);

    var ba = _buildTeamBA();
    statCards.add(ba);

    var gl = _buildTeamGamesLost();
    statCards.add(gl);

    var gw = _buildTeamGamesWon();
    statCards.add(gw);

    var gp = _buildTeamGamesPlayed();
    statCards.add(gp);
  }

  //  W%
  TeamStatModel _buildTeamWinPercent()
  {
    var teamStatModel = new TeamStatModel(
        statName: "Win Percentage",
        statDescription: "W% - The fraction of games a team has won.",
        statIcon: "graphics/icon-WPercent.png",
        statValue: teamData.winPercentage
    );
    return teamStatModel;
  }

  TeamStatModel _buildTeamLossPercent()
  {
    var teamStatModel = new TeamStatModel(
        statName: "Loss Percentage",
        statDescription: "L% - The fraction of games a team has lost.",
        statIcon: "graphics/icon-LPercent.png",
        statValue: teamData.lossPercentage
    );
    return teamStatModel;
  }

  TeamStatModel _buildTeamBPG()
  {
    var teamStatModel = new TeamStatModel(
        statName: "Baskes Per Game",
        statDescription: "BPG - A measure of the average number of basket's per game.",
        statIcon: "graphics/icon-bpg.png",
        statValue: teamData.basketsPerGame
    );
    return teamStatModel;
  }

  TeamStatModel _buildTeamWLPercentage()
  {
    var teamStatModel = new TeamStatModel(
        statName: "Win - Loss Percentage",
        statDescription: "W-L% - Ratio of a teams total number of wins vs the number of losses",
        statIcon: "graphics/icon-winloss.png",
        statValue: teamData.winLossPercent
    );
    return teamStatModel;
  }

  TeamStatModel _buildTeamWinsOver500()
  {
    var teamStatModel = new TeamStatModel(
        statName: "Wins Over .500",
        statDescription: ".500 - A measure of how many games a team would need to lose (if above) or win (if below) to reach the .500 mark.",
        statIcon: "graphics/icon-500.png",
        statValue: teamData.winsOver500
    );
    return teamStatModel;
  }

  TeamStatModel _buildTeamWPyth()
  {
    var teamStatModel = new TeamStatModel(
        statName: "Pythagorean Wins",
        statDescription: "W Pyth - an estimation of where a team’s win percentage “should” be based on their points for and against.",
        statIcon: "graphics/icon-wpyth.png",
        statValue: teamData.wPyth
    );
    return teamStatModel;
  }

  TeamStatModel _buildTeamBF()
  {
    var teamStatModel = new TeamStatModel(
        statName: "Baskets For",
        statDescription: "BF - Cumulative baskets scored by this tesm",
        statIcon: "graphics/icon-bf.png",
        statValue: teamData.basketsFor.toString()
    );
    return teamStatModel;
  }

  TeamStatModel _buildTeamBA()
  {
    var teamStatModel = new TeamStatModel(
        statName: "Baskets Against",
        statDescription: "BA - Number of bakets against this team.",
        statIcon: "graphics/icon-ba.png",
        statValue: teamData.basketsAgainst.toString()
    );
    return teamStatModel;
  }

  TeamStatModel _buildTeamGamesWon()
  {
    var teamStatModel = new TeamStatModel(
        statName: "Games Won",
        statDescription: "GW - Total number of games won by this team.",
        statIcon: "graphics/icon-gw.png",
        statValue: teamData.gamesWon.toString()
    );
    return teamStatModel;
  }

  TeamStatModel _buildTeamGamesLost()
  {
    var teamStatModel = new TeamStatModel(
        statName: "Games Lost",
        statDescription: "GL - Total number of games lost by this team.",
        statIcon: "graphics/icon-gl.png",
        statValue: teamData.gamesLost.toString()
    );
    return teamStatModel;
  }

  TeamStatModel _buildTeamGamesPlayed()
  {
    var teamStatModel = new TeamStatModel(
        statName: "Games Played",
        statDescription: "GP - Total number of games played by this team.",
        statIcon: "graphics/icon-gp.png",
        statValue: teamData.gamesPlayed.toString()
    );
    return teamStatModel;
  }




}