import 'package:flutter/material.dart';
import '../../data/item_data.dart';

class ItemChatPage extends StatefulWidget {
  const ItemChatPage({ Key? key, required this.item, this.onEditFinish}) : super(key: key);

  final Item item;
  final onEditFinish;

  @override
  ItemChatPageState createState() => ItemChatPageState();
}

class ItemChatPageState extends State<ItemChatPage>  {
  TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Item newItem = widget.item;
    return Column(
      children: [
        const Text("Chat With Customers",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30,
          )
        ),
        
        const Padding(padding: EdgeInsets.only(top: 10)),
        const Text("Top Reviews from Canada",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 6, 189, 143),
            fontSize: 20,
          )
        ),
        
        const Padding(padding: EdgeInsets.only(top: 20)),
        
        Column(
          children: buildChatList(),
        ),
        
        Padding(padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: TextField(
          controller: chatController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Add Message',
            ),
          ),
        ),
        
        Padding(padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
          width: 500,
          height: 40,
          child: Padding(padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
            child: Material(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5),
              elevation: 6,
              child: MaterialButton(
                child: const Text(
                  'Create Your Chat',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {addComment(newItem);},
              ),
            ),
          )
        ),
        ),
      ]
    );
  }
  
  void addComment(Item newItem) {
    newItem.chat.add(Chat(name: "Current User", comment: chatController.text, date: DateTime.now().toString().substring(0, 10)));
    widget.onEditFinish(newItem);
    setState(() {
      // the blank setState is only to fresh the current page in order to mock
      // the update request from backend
    });
  }

  List<ListTile> buildChatList() {
    return widget.item.chat.map((chatState) => 
      ListTile(
        leading: const Icon(Icons.person),
        title: Text(chatState.name + " posted on " + chatState.date,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(chatState.comment,
          style: const TextStyle(fontSize: 14, color: Colors.black)
        )
      ),
    ).toList();
  }
}
