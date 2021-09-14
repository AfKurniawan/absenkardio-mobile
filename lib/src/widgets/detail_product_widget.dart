
import 'package:absensi_prodi/animation/fade_animation.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:provider/provider.dart';

import 'button_widget.dart';
import 'form_widget.dart';
import 'icon_badge.dart';

class DetailProductWidget extends StatelessWidget {

  TextEditingController quantityController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).orientation == Orientation.portrait){
      return Scaffold(
        body: verticalLayout(context),
      );
    } else {
      return Scaffold(
        body: horizontalLayout(context),
      );
    }

  }

  Widget verticalLayout(BuildContext context){
    var mediaQuery = MediaQuery.of(context);
    // var provider = Provider.of<ScanProvider>(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: mediaQuery.size.height / 1.7,
          child: FadeAnimation(
              1.3,
              Image.network(
               "",
                fit: BoxFit.cover,
              )),
        ),
        Positioned(
          top: 20,
          width: mediaQuery.size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: IconBadge(
                        icon: LineariconsFree.cart,
                        size: 24.0,
                        count: "0",
                      ),
                      color: LightColor.grey,
                      onPressed: () {
                        Navigator.pushNamed(context, "/cart_page");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height / 2.1,
            child: FadeAnimation(
                1.2,
                Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FadeAnimation(
                                1.3,
                                Text(
                                  "provider.variant",
                                  style: TextStyle(
                                      color: Color.fromRGBO(97, 90, 90, .54),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              FadeAnimation(
                                1.3,
                                Text(
                                  "provider.name",
                                  style: TextStyle(
                                      color: Color.fromRGBO(97, 90, 90, 1),
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Divider(),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FadeAnimation(
                                    1.4,
                                    Container(
                                      child: Text(
                                        "Lorem",
                                        style: TextStyle(
                                            color: LightColor.purple,
                                            height: 1.4,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  FadeAnimation(
                                    1.3,
                                    Text(
                                      "Ipsum",
                                      style: TextStyle(
                                          color: Color.fromRGBO(97, 90, 90, .54),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),


                              SizedBox(
                                height: mediaQuery.size.height / 7,
                              ),
                              FadeAnimation(
                                  1.3,
                                  FormWidget(
                                    hint: "Quantity",
                                    textEditingController: quantityController,
                                  )),

                              SizedBox(
                                height: 10,
                              ),
                              FadeAnimation(
                                1.4,
                                ButtonWidget(
                                  btnText: "Add to Cart",
                                  myIcon: null,
                                  btnAction: (){},
                                ),
                              ),

                            ],
                          ),
                        ))))),
      ],
    );
  }

  Widget horizontalLayout(BuildContext context){
   // var provider = Provider.of<ScanProvider>(context);
    var mediaQuery = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: mediaQuery.size.width,
          child: Stack(
            children: <Widget>[
              Container(
                child: Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: mediaQuery.size.height / 1.5,
                  child: FadeAnimation(
                      1.3,
                      Image.network(
                        "",
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              //myHorizontalAppbar(),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: FadeAnimation(
                      1.2,
                      Container(
                          padding: const EdgeInsets.only(left:20.0, right: 20, top: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Container(
                            child: SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          FadeAnimation(
                                            1.3,
                                            Text(
                                              "provider.variant",
                                              style: TextStyle(
                                                color: Color.fromRGBO(97, 90, 90, .54),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          FadeAnimation(
                                            1.3,
                                            Text(
                                              "Lorem Ipsum",
                                              style: TextStyle(
                                                color: Color.fromRGBO(97, 90, 90, .54),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: FadeAnimation(
                                              1.3,
                                              Text(
                                                "Nama Kamu",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(97, 90, 90, 1),
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          FadeAnimation(
                                            1.4,
                                            Padding(
                                              padding: const EdgeInsets.only(top:10.0),
                                              child: Container(
                                                child: Text(
                                                  "Harga",
                                                  style: TextStyle(
                                                      color: LightColor.purple,
                                                      height: 1.4,
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      FadeAnimation(
                                          1.3,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: mediaQuery.size.width /1.5,
                                                child: FormWidget(
                                                  hint: "Quantity",
                                                  textEditingController: quantityController,
                                                ),
                                              ),
                                              Container(
                                                width: mediaQuery.size.width /4,
                                                child: FadeAnimation(
                                                  1.4,
                                                  ButtonWidget(
                                                    btnText: "Add to Cart",
                                                    myIcon: (Icon(LineariconsFree.cart,
                                                      color: Colors.white,
                                                    )),
                                                    btnAction: (){},
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),

                                      SizedBox(
                                        height: 5,
                                      ),

                                    ],
                                  ),
                                )
                            ),
                          )
                      )
                  )
              ),
            ],
          ),
        ),

      ],
    );

  }

}
