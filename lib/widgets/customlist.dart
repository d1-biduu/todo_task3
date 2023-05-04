import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/Screen/todo.dart';
import 'package:todo/database/todoDB.dart';

class CustomWidget extends StatefulWidget {
  final String taskName;
  final String? description;
  final int id;
  final Function() onClicked;

  

  const CustomWidget({
    Key? key,
    required this.taskName,
    required this.id,
    required this.onClicked,
     this.description,
  }) : super(key: key);

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
   List<Map<String, dynamic>> toDoList = [];
  
   bool? taskCompleted = false;

  final TextDecoration textDecoration = TextDecoration.lineThrough;
   final addTaskController = TextEditingController();
   

   Future<void> _deleteItem(int id) async {
  await SQLHelper.deleteItem(id);
  final data = await SQLHelper.getItems();
  setState(() {
    toDoList = data;
  });
}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
        child: Slidable(
          endActionPane: ActionPane(
            motion:const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                 _deleteItem(widget.id);
                  Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const Homepage()),
  (route) => false,
);
                },
               
                icon: Icons.delete, 
                backgroundColor:const Color.fromARGB(255, 255, 0, 0),
              ),
            ],
          ),
          child: Material(
            elevation: 5.0,
  shadowColor:const Color.fromARGB(255, 3, 94, 139),
            child: ListTile(
                   tileColor: Colors.white,
              leading: Checkbox(
                  activeColor: Colors.black,
                  value: taskCompleted,
                  onChanged: (bool? value){
setState(() {
      taskCompleted = value;
    });
                  }),
              title: Text(
                widget.taskName,
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    letterSpacing: 0.5,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    decoration: taskCompleted!
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              
              subtitle:Text(widget.description!,style:  TextStyle(
                color:Color.fromARGB(255, 0, 0, 0),
                letterSpacing: 0.5,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                decoration: taskCompleted! ? TextDecoration.lineThrough: TextDecoration.none
               ),),
              trailing: IconButton(onPressed: widget.onClicked, icon: const Icon(Icons.edit, color: Colors.blue
              ,),),
            ),
          ),
        ));
        
  }
  
}
