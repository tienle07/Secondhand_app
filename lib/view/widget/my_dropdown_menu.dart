import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:second_hand_app/model/drop_list_model.dart';
import 'dart:convert';


class MyDropdownMenu extends StatefulWidget {

  final Function(DropdownItem?) onItemSelected;

  const MyDropdownMenu({super.key, required this.onItemSelected});

  @override
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {

  List<DropdownItem>? _dropdownItems;
  DropdownItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    _getDropdownItems(); // Call the API to get the dropdown items
  }

  Future<void> _getDropdownItems() async {
    final url = Uri.parse(
        'https://secondhandvinhome.herokuapp.com/api/category');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body)['response'] as List;
      _dropdownItems =
          jsonList.map((json) => DropdownItem.fromJson(json)).toList();
      setState(() {
        _selectedItem = _dropdownItems?.first; // Set the initial selected item
      });
    } else {
      throw Exception('Failed to load dropdown items');
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<DropdownItem>(
//       value: _selectedItem,
//       onChanged: (value) {
//         setState(() {
//           _selectedItem = value;
//         });
//         widget.onItemSelected(_selectedItem);
//       },
//       items: _dropdownItems
//           ?.map((item) => DropdownMenuItem<DropdownItem>(
//         value: item,
//         child: Text(item.categoryName!),
//       ))
//           .toList(),
//     );
//   }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200, // Fixed height of the dropdown
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        child: DropdownButtonFormField<DropdownItem>(
          value: _selectedItem,
          decoration: const InputDecoration(
            hintText: 'Select Category',
            border: OutlineInputBorder(),
          ),
          items: _dropdownItems
              ?.map((item) =>
              DropdownMenuItem<DropdownItem>(
                value: item,
                child: Text(item.categoryName!),
              ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedItem = value;
            });
            widget.onItemSelected(_selectedItem);
          },
        ), // Required when using a scrollbar
      ),
    );
  }
}
