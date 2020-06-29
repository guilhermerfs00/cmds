import 'package:cmds/charts/linechart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              //
            }),
        title: Text("CMD"),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.chartLine),
              onPressed: () {
                //
              }),
        ],
      ),
      body: Container(
        color: Color(0xffE5E5E5),
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LineChart()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: lineChart("Grafico de Linha"),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: pieChart("Pizza"),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: infoChart("TV", "80Kw/h"),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: infoChart("Ar Condicionado", "80Kw/h"),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: infoChart("Geladeira", "80Kw/h"),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: infoChart("Computador", "80Kw/h"),
            ),
          ],
          staggeredTiles: [
            StaggeredTile.extent(4, 250.0),
            StaggeredTile.extent(4, 250.0),
            StaggeredTile.extent(2, 250.0),
            StaggeredTile.extent(2, 250.0),
            StaggeredTile.extent(2, 250.0),
            StaggeredTile.extent(2, 250.0),
          ],
        ),
      ),
    );
  }

  Material lineChart(String title) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Container(
                        width: 300,
                        height: 150,
                        child: Image.asset('assets/images/linechart.png'),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material pieChart(String title) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Container(
                        width: 150,
                        height: 100,
                        child: Image.asset('assets/images/piechart.png'),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material infoChart(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
