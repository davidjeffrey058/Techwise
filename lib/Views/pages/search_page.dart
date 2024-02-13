import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

late FocusNode focusNode;
late TextEditingController textController;

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    textController = TextEditingController();
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
            ),
            SearchBar(
              elevation: MaterialStatePropertyAll(0),
              focusNode: focusNode,
              controller: textController,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
              ),
              trailing: [Icon(Icons.search)],
              padding: MaterialStatePropertyAll(EdgeInsets.only(right: 10)),
            ),
            Expanded(child: Center(child: Text('Search for an item')))
          ],
        ),
      ),
    );
  }
}
