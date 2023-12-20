import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double min;
  final double max;
  final int divisions;
  final String label;

  CustomSlider({
    required this.min,
    required this.max,
    required this.divisions,
    required this.label,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
      ),
      child: Slider(
        value: _currentValue,
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        label: _currentValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentValue = value;
          });
        },
        activeColor: Colors.green,
        inactiveColor: Colors.green.withOpacity(0.3),
      ),
    );
  }
}