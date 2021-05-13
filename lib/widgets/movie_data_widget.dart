import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilmListItem extends StatelessWidget {
  FilmListItem(
      {this.title, this.date, this.runtime, this.overview, this.thumbnail});

  final String title;
  final String date;
  final String runtime;
  final Widget thumbnail;
  final String overview;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
       // color: Colors.white,
       // margin: EdgeInsets.all(8.0),
        height: 200.0,
        child: Row(
           mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.red,
                child: thumbnail,
              ),
              flex: 2,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          child: Text(
                            title ?? "title",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                            //  color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        //padding: EdgeInsets.only(top: 20),
                        
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            overview,
                            style:
                                TextStyle(fontSize: 18,
                                 //   color: Colors.black87
                                ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            " Durée: $runtime min",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontStyle: FontStyle.italic,),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
