
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';


class MaterialColorPicker extends StatefulWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorChange;
  final ValueChanged<ColorSwatch> onMainColorChange;
  final ValueChanged<int> onSelectedMainColorIndex;
  final List<ColorSwatch> colors;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final bool allowShades;
  final bool onlyShadeSelection;
  final double circleSize;
  final double spacing;
  final IconData iconSelected;
  final VoidCallback onBack;
  final double elevation;
  final int selectedColorIndex;

  const MaterialColorPicker({
    Key key,
    this.selectedColor,
    this.onColorChange,
    this.onMainColorChange,
    this.onSelectedMainColorIndex,
    this.colors,
    this.shrinkWrap = false,
    this.physics,
    this.allowShades = true,
    this.onlyShadeSelection = false,
    this.iconSelected = Icons.check,
    this.circleSize = 45.0,
    this.spacing = 9.0,
    this.onBack,
    this.elevation,
    this.selectedColorIndex = 0,
  }) : super(key: key);

  @override
  _MaterialColorPickerState createState() => _MaterialColorPickerState();
}

class _MaterialColorPickerState extends State<MaterialColorPicker> {
  final _defaultValue = materialColors[0];

  List<ColorSwatch> _colors = materialColors;

  ColorSwatch _mainColor;
  Color _shadeColor;
  bool _isMainSelection;

  @override
  void initState() {
    super.initState();
    _initSelectedValue();
  }

  @protected
  void didUpdateWidget(covariant MaterialColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initSelectedValue();
  }

  void _initSelectedValue() {
    if (widget.colors != null) _colors = widget.colors;

    Color shadeColor = widget.selectedColor ?? _defaultValue;
    ColorSwatch mainColor = _findMainColor(shadeColor);

    if (mainColor == null) {
      mainColor = _colors[0];
      shadeColor = mainColor[500] ?? mainColor[400];
    }

    setState(() {
      _mainColor = mainColor;
      _shadeColor = shadeColor;
      _isMainSelection = true;
    });
  }

  ColorSwatch _findMainColor(Color shadeColor) {
    for (final mainColor in _colors)
      if (_isShadeOfMain(mainColor, shadeColor)) return mainColor;

    return (shadeColor is ColorSwatch && _colors.contains(shadeColor))
        ? shadeColor
        : null;
  }

  bool _isShadeOfMain(ColorSwatch mainColor, Color shadeColor) {
    for (final shade in _getMaterialColorShades(mainColor)) {
      if (shade == shadeColor) return true;
    }
    return false;
  }

  void _onMainColorSelected(ColorSwatch color, int index) {
    var isShadeOfMain = _isShadeOfMain(color, _shadeColor);
    final shadeColor = isShadeOfMain ? _shadeColor : (color[500] ?? color[400]);

    setState(() {
      _mainColor = color;
      _shadeColor = shadeColor;
      _isMainSelection = false;
    });
    if (widget.onMainColorChange != null) widget.onMainColorChange(color); widget.onSelectedMainColorIndex(index);
    if (widget.onlyShadeSelection && !_isMainSelection) {
      return;
    }
    if (widget.allowShades && widget.onColorChange != null)
      widget.onColorChange(shadeColor);
  }

  void _onShadeColorSelected(Color color) {
    setState(() => _shadeColor = color);
    if (widget.onColorChange != null) widget.onColorChange(color);
  }

  void _onBack() {
    setState(() => _isMainSelection = true);
    if (widget.onBack != null) widget.onBack();
  }

  List<Widget> _buildListMainColor(List<ColorSwatch> colors) {
    return [
      for (int i = 0; i<colors.length; i++)

        CircleColor(
          color: colors[i],
          circleSize: widget.circleSize,
          onColorChoose: () => _onMainColorSelected(colors[i], i),
          isSelected: _mainColor == colors[i],
          iconSelected: widget.iconSelected,
          elevation: widget.elevation,
        )
    ];
  }

  List<Color> _getMaterialColorShades(ColorSwatch color) {
    return <Color>[
      if (color[100] != null) color[100],
      if (color[200] != null) color[200],
      if (color[300] != null) color[300],
      if (color[400] != null) color[400],
      if (color[500] != null) color[500],
      if (color[600] != null) color[600],
      if (color[700] != null) color[700],
      if (color[800] != null) color[800],
      if (color[900] != null) color[900],
    ];
  }

  List<Widget> _buildListShadesColor(ColorSwatch color) {
    return [
      IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _onBack,
        padding: const EdgeInsets.only(right: 2.0),
      ),
      for (final color in _getMaterialColorShades(color))
        CircleColor(
          color: color,
          circleSize: widget.circleSize,
          onColorChoose: () => _onShadeColorSelected(color),
          isSelected: _shadeColor == color,
          iconSelected: widget.iconSelected,
          elevation: widget.elevation,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final listChildren = _isMainSelection || !widget.allowShades
        ? _buildListMainColor(_colors)
        : _buildListShadesColor(_mainColor);

    // Size of dialog
    final double width = MediaQuery.of(context).size.width * .40;
    final double height = MediaQuery.of(context).size.height * .40;
    // Number of circle per line, depend on width and circleSize
    final int nbrCircleLine = width ~/ (widget.circleSize + widget.spacing);

    return Container(
      width: width,
      height: height,
      child: GridView.count(
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics,
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: widget.spacing,
        mainAxisSpacing: widget.spacing,
        crossAxisCount: nbrCircleLine,
        children: listChildren,
      ),
    );
  }
}
