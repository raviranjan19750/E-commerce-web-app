
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_table/json_table.dart';
import 'package:living_desire/DBHandler/ProductRepository.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/widgets/bullet.dart';

class SizeChartDialog extends StatelessWidget {

  ProductRepository productRepository;
  String networkImageURL = "https://rukminim1.flixcart.com/www/240/240/prod/images/sizechart/t_shirt-half_sleeve-men_s-round_neck-d3fa68ae.jpg?q=90";
  List<String> descriptions = ["statement 1","statement 1", "statement 1", "statement 1","statement 1", "statement 1","statement 1","statement 1",];


  @override
  Widget build(BuildContext context) {

    return Dialog(


      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.all(32),

        child: BlocProvider(create:(context) => ProductDetailBloc(productRepository: RepositoryProvider.of(context))..add(LoadSizeChart("Bean Bag","Arm Chair" )) ,


          child: BlocBuilder<ProductDetailBloc, ProductDetailState>(builder: (context, state) {

            if(state is SizeChartLoading) {
              return Center(
                  child: CircularProgressIndicator());
            }
            else if (state is SizeChartLoadingSuccessful) {

              return SingleChildScrollView(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,

                      children: [

                        Text(
                          Strings.sizeChart,
                          style: TextStyle(
                              color: Palette.secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Row (
                          children: [

                            Expanded(

                              flex:1,
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    SizedBox(height: 16,),

                                    JsonTable(state.response["data"]["chart"]),

                                    SizedBox(height: 50,),

                                    Image.network(networkImageURL),
                                  ],
                                )
                            ),

                            SizedBox(width: 5),

                            Container(
                              alignment: Alignment.topCenter,
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: 0.5,
                              color: Colors.black,

                            ),

                            SizedBox(
                              width: 10,
                            ),

                            Expanded(
                              flex: 1,

                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.5,

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ...descriptions
                                        .map((e) => Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Bullets(),
                                        Container(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            e,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ))
                                        .toList(),

                                      SizedBox(height: 16,)
                                    ],

                                  ),
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  ],

                ),
              );
            }
            else {
              return Container(
                child: Text("oops Something went wrong"),
              );
            }
          }),
        ),
      ),
    );



  }


}
