import 'package:flutter/material.dart';
import 'package:weplayball/service/authenticationStatus.dart';
import 'package:weplayball/service/request/apiRequest.dart';
import 'package:weplayball/models/resultCollection.dart';
import 'package:weplayball/pages/tabs/defaultTabController.dart';
import 'package:weplayball/service/response/parsedResponse.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/resultsList.dart';


class ResultsTab extends StatefulWidget {

  final AuthStatus _authStatus;
  final String _assetBaseUrl;
  const ResultsTab(this._authStatus, this._assetBaseUrl,{ Key key }) : super(key: key);
  @override
  _ResultsTabState createState() => _ResultsTabState();
}

class _ResultsTabState extends State<ResultsTab> with SingleTickerProviderStateMixin{

  TabController _tabController;
  var _apiRequest = new ApiRequest();
  static ParsedResponse<ResultCollection> resultData;
  List<Widget> _screens;

  Future updateAndGetData() async {
    var data = await _apiRequest.getResults();
    return data;
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3/* for some reason I'm having to hard code*/);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  updateDataState()
  {
    var tab1 =
    (resultData.body.firstDivision.length == 0)?
    Center(child:
    Text(
        'No recent matches found',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(getColourHexFromString(primaryBlack)),
        )
    ),
    ) :
    new ResultsList(resultData: resultData.body.firstDivision, assetBaseUrl: widget._assetBaseUrl);

    var tab2 =
    (resultData.body.secondDivision.length == 0)?
    Center(child:
    Text(
        'No recent matches found',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(getColourHexFromString(primaryBlack)),
        )
    ),
    ) :
    new ResultsList(resultData: resultData.body.secondDivision, assetBaseUrl: widget._assetBaseUrl);

    var tab3 =
    (resultData.body.thirdDivision.length == 0)?
    Center(child:
    Text(
        'No recent matches found',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(getColourHexFromString(primaryBlack)),
        )
    )
    ) :
    new ResultsList(resultData: resultData.body.thirdDivision, assetBaseUrl: widget._assetBaseUrl);
    _screens = [
      tab1,
      tab2,
      tab3
    ];
  }

  @override
  Widget build(BuildContext context) {

    _screens = [
      Center(child: new CircularProgressIndicator()),
      Center(child: new CircularProgressIndicator()),
      Center(child: new CircularProgressIndicator())
      //  screen will eventually take an instance
      //  of ParsedResponse<FixtureCollection> fixtureData
    ];

    return new Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: FutureBuilder(
        future: updateAndGetData(),
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Input a URL to start');
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator());
            case ConnectionState.active:
              return new Text('Hello');
            case ConnectionState.done:
              if (snapshot.hasError) {
                return new Text(
                  '${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                resultData = snapshot.data;
                return buildTabsView(context, snapshot);
              }
          }
        },
      ),
    );


  }

  Widget buildTabsView(BuildContext context, AsyncSnapshot snapshot) {
    //print("buildTabsView() called");
    updateDataState();

    var tabs = [
      new Tab(text: "DIV 1"),
      new Tab(text: "DIV 2"),
      new Tab(text: "DIV 3")
    ];

    return SharedTabController(tabs,_tabController, _screens);

  }
}