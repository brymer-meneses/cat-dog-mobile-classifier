import 'package:flutter/material.dart';

import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Body extends StatelessWidget {
  final _image;
  final _showButton;
  final _selectHandler;
  final Category category;

  Body(this._image, this._showButton, this._selectHandler, this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          (LimitedBox(
            child: (_image == null
                ? Container()
                : Container(
                    child: Image.file(_image, alignment: Alignment.center),
                    margin: const EdgeInsets.all(50.0))),
            maxHeight: 300,
            maxWidth: 300,
          )),
          _showButton
              ? Container(
                  child: FloatingActionButton.extended(
                    label: Text("Classify Image"),
                    onPressed: () => _selectHandler(_image),
                    backgroundColor: Colors.blue[400],
                  ),
                )
              : category == null
                  ? Container()
                  : Column(
                      children: <Widget>[
                        Text(
                          category.label,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Confidence: ${category.score.toStringAsFixed(3)}',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
        ],
      ),
      alignment: Alignment.center,
    );
  }
}
