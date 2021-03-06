import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:weplayball/models/fixture.dart';
import 'package:weplayball/pages/teamDetails/teamDetails.dart';

import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/fixtureBoard.dart';
import 'package:weplayball/ui/layout.dart';


class FixturesList extends StatelessWidget {

  final List<FixtureModel> fixtureData;
  final String assetBaseUrl;

  const FixturesList(
  this.fixtureData,
  this.assetBaseUrl, { Key key }) : super(key: key);

  _handleTap(BuildContext context,String teamCode){
    print("fetching datat for team: ${teamCode}") ;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamDetailsPage(teamCode, assetBaseUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return createListView(context, fixtureData );
  }

  Widget createListView(BuildContext context, List<FixtureModel> fixtureData) {

    //print(snapshot.hasData);
    //  wrap in container to give background color
    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0,1.0],
        ),
      ),
      child: ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              SizedBox(
                height: 12,
              ),
              Container(
                alignment: Alignment.center,
                padding: new EdgeInsets.all(8.0),
                height: 150.0,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image:  AssetImage("graphics/stat-result-card-bg.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                    boxShadow: [
                      new BoxShadow(color: Color(getColourHexFromString(primaryMediumGrey)),
                          offset: new Offset(2.0, 5.0),
                          blurRadius: 7.0)
                    ]
                ),
                child: FixtureBoard(
                    fixtureData[index],
                    assetBaseUrl,
                    false
                ),
              ),
              //  add some padding
              addSizedBoxPadding(8.0, 0),
            ],
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 1.0,
          color: Color(getColourHexFromString(primaryWhiteGrey)),
        ),
        itemCount: fixtureData.length,
      ),
    );

  }

}