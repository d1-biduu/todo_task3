import 'package:flutter/material.dart';
import 'package:todo/widgets/button.dart';
import 'package:todo/widgets/customlist.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
   final addTaskController = TextEditingController();
  //list of todo task
  List toDoList=[
  ["Make Tutorial",false, 'done'],
  ["Do Exercise",true, 'pending'],
  ["Coding for 1 hour",false, 'pending'],
  ];
  void checkboxChanged(bool? value, int index){
setState(() {
  toDoList[index][1] = !toDoList[index][1];
});
  }
 
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Center(child: Text("TO DO", style: TextStyle(color: Colors.black),)),
      
         backgroundColor:const Color.fromARGB(255, 255, 255, 255),
      ),
        body: ListView.builder(
itemCount: toDoList.length,
itemBuilder: (context, index) {
  return CustomWidget(
    taskName:toDoList[index][0],
    taskCompleted:toDoList[index][1],
    onChanged:(value) {checkboxChanged(value,index);
      
    },
      taskDescription: toDoList[index][2],
  );
},

        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom:30.0),
          child: FloatingActionButton(onPressed: () {
createNewTask();
          },
          backgroundColor: Colors.white,
          child:const Icon(Icons.add,size: 30,color:Color.fromARGB(255, 21, 103, 171),),),
        ),
    );
  }
  void createNewTask(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),

        content: Container(height:130,
        decoration: BoxDecoration(
      
          borderRadius: BorderRadius.circular(10),),
child: Column(children:  [
   TextField(
    controller: addTaskController,
    decoration: const InputDecoration(border:OutlineInputBorder(
      borderSide: BorderSide(width: 5, color: Colors.white)
    ), 
    hintText: "Add a new task"),
  ),
 const SizedBox(height:20),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    //save button
Button(text: "Save", onPressed: (){

}, color: Colors.green,),
    //cancel button
Button(text: "Cancel", onPressed: (){Navigator.of(context).pop();}, color: Color.fromARGB(255, 174, 173, 173),)
  ],)
]),
        ),);
    },
    );
  }
  
}