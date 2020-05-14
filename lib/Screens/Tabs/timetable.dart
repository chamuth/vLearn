import 'package:elearnapp/Components/TimetableItem.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class TimetableTab extends StatefulWidget {
  TimetableTab({Key key}) : super(key: key);

  @override
  TimetableTabState createState() => TimetableTabState();
}

class ViewMode
{
  String modeName;
  IconData modeIcon;

  ViewMode(this.modeName, this.modeIcon);
}

class TimetableTabState extends State<TimetableTab> {

  ViewMode selectedViewMode;
  List<ViewMode> viewModes = [
    ViewMode("Day View", Icons.filter_list),
    ViewMode("Week View", Icons.table_chart),
  ];

  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Satuday", "Sunday"];

  @override
  void initState() { 

    super.initState();
    selectedViewMode = viewModes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        
        // View settings
        Padding(child: 
          Row(children: <Widget>[
            
            RawMaterialButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Row(children: <Widget>[
              Icon(Icons.settings, color: Theme.of(context).primaryColor, size: 17),
              VerticalDivider(color: Colors.transparent, width:8),
              Text("Manage Classes", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor))
            ],),onPressed: () {}, padding: EdgeInsets.fromLTRB(10, 0, 10, 0),),

            Expanded(child: Text(""),),

            Text("View as", style: TextStyle(color: Colors.grey)),
            VerticalDivider(width: 10, color: Colors.transparent),

            DropdownButtonHideUnderline(
              child: DropdownButton<ViewMode>(items: viewModes.map((f){
                return DropdownMenuItem(child: 
                  Row(children: <Widget>[                
                    Icon(f.modeIcon, size: 18),
                    VerticalDivider(width: 8, color: Colors.transparent),
                    Text(f.modeName)
                  ],),
                value: f,);
              }).toList(), value: selectedViewMode, onChanged: (f) {
                setState(() {
                  selectedViewMode = f;
                });
              }, isDense: true,)
            ),

          ],),
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        ),

        // Timetable view
        Expanded(child: 
          AnimatedCrossFade
          (
            crossFadeState: (selectedViewMode == viewModes[0]) ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
            firstChild: ListView.builder(itemBuilder: (context, index) 
            {
              return SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(20 , 10, 20, 10), child: Container(color: Colors.transparent, 
                  child: Column(children: <Widget>[
                    
                    Row(children: <Widget>[
                      Text(days[index], style : TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold)),
                      VerticalDivider(color: Colors.transparent, width: 10,),
                      Expanded(child: Divider(thickness: 1.5,))
                    ],),

                    Divider(color: Colors.transparent, height:15),

                    Expanded(
                      child: ListView.builder(itemBuilder: (ctx, i) {

                        DateTime dt = new DateTime(2020, 1, 1, 0, 0);
                        dt = dt.add(Duration(minutes: 30 * i));

                        var selected = random.boolean();

                        return TimetableItem(themeColor: Colors.blue, eventAvailable: selected, timeframe: dt,);

                      }, itemCount: 24)
                    )
                    
                  ],),
                )), width: MediaQuery.of(context).size.width
              );
            }, scrollDirection: Axis.horizontal,),
            secondChild: Container(),
            duration: Duration(milliseconds: 250)
          )
        )

      ],)
    );
  }
}