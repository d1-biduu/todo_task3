import 'package:flutter/material.dart';
import 'package:todo/database/todoDB.dart';
import 'package:todo/widgets/button.dart';
import 'package:todo/widgets/customlist.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> toDoList = [];

  final _formKey = GlobalKey<FormState>();

  retrieveItemsFromDatabase() async {
    final data = await SQLHelper.getItems();
    setState(() {
      toDoList = data;
    });
  }

  final addTaskController = TextEditingController();
  @override
  void initState() {
    super.initState();
    retrieveItemsFromDatabase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Center(
            child: Text(
          "TO DO",
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return CustomWidget(
            taskName: toDoList[index]['title'],
            id: toDoList[index]['id'], onClicked: ()async { 
              await createNewTask(toDoList[index]['id']);
             },
            
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
          onPressed: () {
            createNewTask(null);
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            size: 30,
            color: Color.fromARGB(255, 21, 103, 171),
          ),
        ),
      ),
    );
  }

  // update an item on the list
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(id, addTaskController.text);
    retrieveItemsFromDatabase();
  }
  //delete an item from the list

  Future<void> _deleteItem(int id) async {
    await SQLHelper.deleteItem(
      id,
    );
    retrieveItemsFromDatabase();
  }
  

  //add an item to the list
  Future<void> _addItem() async {
    await SQLHelper.createItem(addTaskController.text);
    retrieveItemsFromDatabase();
  }


   createNewTask(int? id) async {
     
      if(id != null)
      
      {
        final existingList =
      toDoList.firstWhere((element) => element['id'] == id);
      addTaskController.text = existingList['title'];
      }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.19,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your task';
                        }
                      },
                      controller: addTaskController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white)),
                          hintText: "Add a new task"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //save button
                        Button(
                          text: (id==null) ? "Save" : "Update" ,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if(id==null){
await _addItem();

                              }
                              if( id != null){
                                await _updateItem(id);
                              }
                              
                              addTaskController.text = '';


                              Navigator.of(context).pop();
                            }
                            ;
                          },
                          color: Colors.blue,
                        ),

                        //cancel button
                        Button(
                          text:  "Cancel",
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: const Color.fromARGB(255, 163, 160, 160),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
