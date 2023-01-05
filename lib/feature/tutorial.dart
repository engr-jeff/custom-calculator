import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

bool tutorialModeOn = false;

class MyTutorialCoachMarkScreen extends StatefulWidget {
  @override
  _MyTutorialCoachMarkScreenState createState() => _MyTutorialCoachMarkScreenState();
}

class _MyTutorialCoachMarkScreenState extends State<MyTutorialCoachMarkScreen> {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> listTargets = [];

  List<SoccerPlayerInfo> listSoccerPlayersInfo = [
    SoccerPlayerInfo("Cristiano Ronaldo", "Forward", "Manchester United", "Portugal"),
  ];

  final globalKey1 = GlobalKey();
  final globalKey2 = GlobalKey();
  final globalKey3 = GlobalKey();
  final globalKey4 = GlobalKey();

  @override
  void initState() {
    super.initState();
    initTargets();
    Future.delayed(
      const Duration(seconds: 1),
      () => showAppTutorial(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Tutorial Coach Mark Sample"),
          actions: <Widget>[
            IconButton(
              key: globalKey1,
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(15),
            child: ListView.builder(
                itemCount: listSoccerPlayersInfo.length,
                itemBuilder: (context, position) {
                  SoccerPlayerInfo getSoccerPlayerInfo = listSoccerPlayersInfo[position];
                  String soccerPlayerName = getSoccerPlayerInfo.playerName;
                  String soccerPlayingPosition = getSoccerPlayerInfo.playingPosition;
                  String soccerPlayerClubName = getSoccerPlayerInfo.clubName;
                  String soccerPlayerCountryName = getSoccerPlayerInfo.countryName;
                  return Card(
                      key: globalKey2,
                      elevation: 8,
                      child: Container(
                          height: 80,
                          padding: const EdgeInsets.all(15),
                          child: Stack(children: <Widget>[
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(soccerPlayerName, style: const TextStyle(fontSize: 18))),
                            Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    margin: const EdgeInsets.only(right: 50),
                                    child: IconButton(
                                        key: globalKey3,
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          tutorialModeOn = true;
                                        }))),
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(key: globalKey4, icon: const Icon(Icons.delete), onPressed: () {})),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Text("$soccerPlayingPosition | $soccerPlayerClubName | $soccerPlayerCountryName",
                                    style: const TextStyle(fontSize: 17)))
                          ])));
                })),
        backgroundColor: Colors.grey[200]);
  }

  void initTargets() {
    listTargets.add(
      TargetFocus(
        color: Colors.orangeAccent,
        identify: "Target 1",
        keyTarget: globalKey1,
        contents: [
          // TargetContent(
          //     align: ContentAlign.bottom,
          //     child: Container(
          //       margin: EdgeInsets.only(top: 100),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: <Widget>[
          //           Text(
          //             "Add New Soccer Player",
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 22,
          //               color: Colors.white,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ))
        ],
        shape: ShapeLightFocus.Circle,
      ),
    );
    listTargets.add(
      TargetFocus(
        color: Colors.deepOrangeAccent,
        identify: "Target 2",
        keyTarget: globalKey2,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Soccer Player Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 7,
      ),
    );

    listTargets.add(TargetFocus(
      color: Colors.pinkAccent,
      identify: "Target 3",
      keyTarget: globalKey3,
      contents: [
        TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text(
                    "Edit Soccer Player",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )),
      ],
      shape: ShapeLightFocus.Circle,
    ));

    listTargets.add(TargetFocus(
      color: Colors.tealAccent,
      identify: "Target 4",
      keyTarget: globalKey4,
      contents: [
        TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text(
                    "Delete Soccer Player",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )),
      ],
      shape: ShapeLightFocus.Circle,
    ));
  }

  void showAppTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: listTargets,
      colorShadow: Colors.grey,
      textSkip: "SKIP TUTORIAL",
      textStyleSkip: const TextStyle(fontSize: 20),
      paddingFocus: 8,
      opacityShadow: 0.9,
      onFinish: () {},
      onClickTarget: (target) {},
      onSkip: () {},
      onClickOverlay: (target) {},
    )..show(context: context);
  }
}

class SoccerPlayerInfo {
  String playerName;
  String playingPosition;
  String clubName;
  String countryName;

  SoccerPlayerInfo(
    this.playerName,
    this.playingPosition,
    this.clubName,
    this.countryName,
  );
}
