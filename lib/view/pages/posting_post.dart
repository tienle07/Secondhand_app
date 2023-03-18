import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:second_hand_app/model/drop_list_model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/multi_images_utils.dart';
import 'package:http/http.dart' as http;

import '../widget/my_dropdown_menu.dart';

class PostingPost extends StatefulWidget {
  const PostingPost({Key? key}) : super(key: key);

  @override
  State<PostingPost> createState() => _PostingPostState();
}

class _PostingPostState extends State<PostingPost> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  HtmlEditorController htmlEditorController = HtmlEditorController();
  List<Object> img = [];

  // final _formKey = GlobalKey<FormState>();
  String _postName = '';
  String _postContent = '';

  DropdownItem? _selectedItem;

  void _onDropdownItemSelected(DropdownItem? selectedItem) {
    setState(() {
      _selectedItem = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Post'),
      ),
      body: Form(
        key: globalKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: FormHelper.inputFieldWidgetWithLabel(
                    context,
                    prefixIcon: const Icon(Icons.web),
                    "name",
                    "Product Name",
                    "",
                    (onValidateVal) {
                      if (onValidateVal.isEmpty) {
                        return 'Post name is required.';
                      }

                      return null;
                    },
                    (onSavedVal) {
                      _postName = onSavedVal;
                    },
                    borderColor: Theme.of(context).primaryColor,
                    borderFocusColor: Theme.of(context).primaryColor,
                    borderRadius: 10,
                    paddingLeft: 0,
                    paddingRight: 0,
                    showPrefixIcon: false,
                    onChange: (val) {},
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: FormHelper.inputFieldWidgetWithLabel(
                        context,
                        prefixIcon: const Icon(Icons.wallet_giftcard),
                        "price",
                        "Price",
                        "",
                        (onValidateVal) {
                          if (onValidateVal.isEmpty) {
                            return 'Price of Product is required.';
                          }

                          return null;
                        },
                        (onSavedVal) {
                          _postContent = onSavedVal;
                        },
                        showPrefixIcon: false,
                        borderColor: Theme.of(context).primaryColor,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderRadius: 10,
                        paddingLeft: 0,
                        paddingRight: 0,
                        suffixIcon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "\$",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        onChange: (val) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    height: 20
                ),


                MyDropdownMenu(onItemSelected: _onDropdownItemSelected),

                const SizedBox(
                  height: 20,
                ),
                HtmlEditor(
                  controller: htmlEditorController,
                  htmlEditorOptions: const HtmlEditorOptions(
                    hint: "Product Description",
                    // initialText:
                  ),
                  htmlToolbarOptions: const HtmlToolbarOptions(
                    toolbarPosition: ToolbarPosition.aboveEditor,
                    toolbarType: ToolbarType.nativeGrid,
                    defaultToolbarButtons: [FontButtons()],
                  ),
                  otherOptions: const OtherOptions(
                    height: 400,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    "Product Image",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MultiImagePicker(
                  totalImages: 9,
                  imageSource: ImagePickSource.gallery,
                  initialValue: [],
                  onImageChanged: (img) {
                    this.img = img;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (validateSave()) {}
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateSave() {
    final form = globalKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
