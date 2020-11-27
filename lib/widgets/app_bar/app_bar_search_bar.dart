import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/bloc/bloc.dart';

class AppBarSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, right: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            onChanged: (val) {
              context.read<SearchBloc>().add(SearchTermChanged(val));
            },
            cursorColor: Palette.secondaryColor,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: Strings.searchBar,
                focusColor: Palette.secondaryColor,
                border: InputBorder.none),
          ),
        ),
        Container(),
        BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          if (state.status == SearchStatus.success) {
            return Positioned(
              bottom: -500,
              child: Container(
                width: 800,
                // height: 200,
                // color: Colors.pinkAccent,
                child: _SearchSuccess(suggestions: state.suggestions,),
              ),
            );
          }
          return Container();
        }),
      ],
    );
  }
}

class _SearchSuccess extends StatelessWidget {

  const _SearchSuccess({Key key, @required this.suggestions}) : super(key: key);

  final List<String> suggestions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestions[index]),
        onTap: () => () => {},
      ),
    );
  }
}
