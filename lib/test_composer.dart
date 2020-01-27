import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class TextComposer extends StatefulWidget {

  TextComposer(this.sendMessage);

  final Function({String text, File imageFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController controller = new TextEditingController();
  bool _isComposing = false;

  void reset() {
    setState(() {
      _isComposing = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {
              final File imageFile =
              await ImagePicker.pickImage(source: ImageSource.camera);
              if(imageFile == null) return;
              widget.sendMessage(imageFile: imageFile);
            },
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                controller.clear();
                reset();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: _isComposing ? Colors.orange : Colors.grey),
            onPressed: _isComposing ? () {
              widget.sendMessage(text: controller.text);
              controller.clear();
              reset();
            } : null,
          )
        ],
      ),
    );
  }
}

