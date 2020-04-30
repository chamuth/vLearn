import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

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
            firstChild: ListView.builder(itemBuilder: (context, i) 
            {
              return SizedBox(
                child: Padding(padding: EdgeInsets.fromLTRB(20 , 10, 20, 10), child: Container(color: Colors.transparent, 
                  child: Column(children: <Widget>[
                    
                    Row(children: <Widget>[
                      Text("Monday", style : TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold)),
                      VerticalDivider(color: Colors.transparent, width: 10,),
                      Expanded(child: Divider(thickness: 1.5,))
                    ],),

                    Divider(color: Colors.transparent, height:15),

                    Expanded(
                      child: ListView.builder(itemBuilder: (ctx, i) {

                        DateTime dt = new DateTime(2020, 1, 1, 0, 0);
                        dt = dt.add(Duration(minutes: 30 * i));

                        var selected = random.boolean();

                        return SizedBox(height: (selected ? 60 : 40), child: Row(children: <Widget>[
                          
                          SizedBox(
                            width:60,  
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[ 
                              Expanded(child: Align(child: Text(" " + (dt.hour).toString().padLeft(2, "0") + ":" + dt.minute.toString().padLeft(2, "0"), 
                                textAlign: TextAlign.start,
                                style: TextStyle(color: (selected) ? Colors.blue : Colors.grey, fontWeight : FontWeight.bold)
                              ), alignment: Alignment.centerLeft,),),
                            ]),
                          ),

                          if (!selected)
                            Expanded(child: Container(color: Colors.grey[900])),
                          if (selected)
                            Expanded(child: Padding(child: Container(
                              child: Row(children: <Widget>[
                                
                                SizedBox(width: 8, child: Container(color: Colors.blue)),

                                Expanded(child: Container(child: Padding(child: Column(children: <Widget>[
                                  
                                  Text("")

                                ],), padding: EdgeInsets.fromLTRB(10, 10, 10, 10),),),),      
                                
                              ]
                            ,)), padding: EdgeInsets.fromLTRB(0, 0, 0, 2),),)

                        ],));

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