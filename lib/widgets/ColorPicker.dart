import 'package:flutter/material.dart';
import 'package:living_desire/config/Color.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/models/StringToHexColor.dart';
import 'package:living_desire/widgets/CustomButtonWidget.dart';


import 'MaterialColorPicker.dart';



class ColorPickerWidget extends StatelessWidget {
  final Function(Color,String) onColorSelectedHexCode,onColorSelectedName;

  Color shadeColor;

  ColorPickerWidget({Key key, this.onColorSelectedHexCode, this.onColorSelectedName,this.shadeColor}) : super(key: key);

  ColorSwatch tempMainColor;
  Color tempShadeColor;
  ColorSwatch mainColor = Colors.blue;
  int mainColorIndex;
  String selectedColorName;

  String getColorName(int index) {

    switch(index) {
      case 0: return Strings.white;
      case 1: return Strings.black;
      case 2: return Strings.red;
      case 3: return Strings.pink;
      case 4: return Strings.purple;
      case 4: return Strings.violet;
      case 6: return Strings.blue;
      case 7: return Strings.blue;
      case 8: return Strings.blue;
      case 9: return Strings.blue;
      case 10: return Strings.green;
      case 11: return Strings.green;
      case 12: return Strings.green;
      case 13: return Strings.yellow;
      case 14: return Strings.yellow;
      case 15: return Strings.yellow;
      case 16: return Strings.orange;
      case 17: return Strings.orange;
      case 18: return Strings.brown;
      case 19: return Strings.grey;
      case 20: return Strings.grey;
    }

    return "";

  }


  void _openDialog(String title, Widget content,BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [

            Container(
              height: 45,
              width: 220,
              child: CustomButtonWidget(
                text: Strings.cancel.toUpperCase(),
                textColor: Colors.black,
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),

            Container(
              height: 45,
              width: 220,
              child: CustomButtonWidget(
                text: Strings.submit.toUpperCase(),
                textColor: Colors.white,
                backgroundColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                  mainColor = tempMainColor;
                  shadeColor = tempShadeColor;
                  selectedColorName = getColorName(mainColorIndex);
                  onColorSelectedHexCode(shadeColor,selectedColorName);
                },
              ),
            ),

          ],
        );
      },
    );
  }

  void _openFullMaterialColorPicker(BuildContext context) async {
    _openDialog(
      Strings.selectProductVariantColor,
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: mainColor,
        onColorChange: (color) => tempShadeColor = color,
        onMainColorChange: (color) => tempMainColor = color,
        onSelectedMainColorIndex: (index)=> mainColorIndex = index,
        onBack: () => print("Back button pressed"),
      ),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        elevation: 3.0,
        onPressed: (){_openFullMaterialColorPicker(context);},
        color: shadeColor,
        textColor: Colors.black54);
  }


}

