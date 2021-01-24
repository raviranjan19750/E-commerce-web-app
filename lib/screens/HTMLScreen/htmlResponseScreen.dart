import 'dart:js' as js;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:living_desire/bloc/HTMLResponseBloc/htmlresponse_bloc.dart';

// ignore: must_be_immutable
class HTMLResponseScreen extends StatelessWidget {
  String htmlResponseFunctionEndPoint = "";

  HTMLResponseScreen({Key key, this.htmlResponseFunctionEndPoint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context1) => HtmlResponseBloc(
              footerRepository: RepositoryProvider.of(context1))
            ..add(LoadHtmlResponse(htmlResponseFunctionEndPoint)),
          child: HTMLResponseScreenContent()),
    );
  }
}

// ignore: must_be_immutable
class HTMLResponseScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HtmlResponseBloc, HtmlResponseState>(
      builder: (context, state) {
        if (state is HtmlResponseLoading) {
          return Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: CircularProgressIndicator());
        } else if (state is HtmlResponseLoadingSuccessful) {
          return SingleChildScrollView(
            child: Html(
              data: state.htmlResponse,
              onLinkTap: (url) {
                js.context.callMethod('open', [url]);
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
