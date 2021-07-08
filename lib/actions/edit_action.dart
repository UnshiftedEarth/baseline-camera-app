/*
  Created By: Nathan Millwater
  Description: The edit action dialog box that allows the user
               to add or modify existing action in the catalog
 */


import 'package:camera_app/models/catalog_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// Stateful widget used to hold the dialog box because
/// it must be updated
class EditAction extends StatefulWidget {
  Item action;

  EditAction({this.action});

  @override
  EditActionState createState() => EditActionState(editingAction: action);
}

/// The state of the widget
class EditActionState extends State<EditAction> {
  final _formKey = GlobalKey<FormState>();
  Color pickerColor = Colors.black;
  // use text editing controllers to get the text of the
  // form fields
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  Item editingAction;
  String buttonText;
  String title;

  /// constructor that checks if an item was passed in to modify
  EditActionState({this.editingAction}) {
    if (editingAction != null) {
      nameController.text = editingAction.name;
      descriptionController.text = editingAction.description;
      pickerColor = editingAction.color;
      buttonText = "Done";
      title = "Editing an Action";
    } else {
      buttonText = "Add";
      title = "Add an Action";
    }
  }

  /// standard build method
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
              // Name form field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  icon: Icon(Icons.pending_actions),
                ),
                controller: nameController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text("Description",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              // Description form field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  icon: Icon(Icons.message),
                ),
                controller: descriptionController,
                minLines: 1,
                maxLines: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text("Color",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              // The color of the action
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: pickerColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))))),
                  ElevatedButton(
                      onPressed: openColorPicker,
                      child: Text("Change Color")
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      // button to confirm
      actions: [
        ElevatedButton(
            child: Text(buttonText),
            onPressed: () {
              // create the new action
              final item = Item(
                  name: nameController.text,
                  color: pickerColor,
                  description: descriptionController.text
              );
              // copy over values
              if (editingAction != null) {
                editingAction.color = pickerColor;
                editingAction.description = descriptionController.text;
                editingAction.name = nameController.text;
              }
              // return the new item from the popup
              Navigator.pop(context, item);
            })
      ],
    );
  }

  /// Function to open another dialog box for the user to choose
  /// a color for their action
  void openColorPicker() {
    showDialog(
        context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select a Color"),
            // third party color chooser widget
            content: MaterialPicker(
              onColorChanged: changeColor,
              pickerColor: pickerColor,
            ),
            actions: [
              ElevatedButton(onPressed: () {Navigator.pop(context);},
                  child: Text("Done"))
            ],
          );
    });
  }

  /// update the state of the chosen color so the widget tree
  /// knows to rebuild
  /// Parameters: The color to update the variable with
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
}
