import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomWidget extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final TextDecoration textDecoration = TextDecoration.lineThrough;
  const CustomWidget(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.taskDescription});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {},
               
                icon: Icons.delete, 
                backgroundColor: Color.fromARGB(255, 255, 0, 0),
              )
            ],
          ),
          child: Material(
            elevation: 5.0,
  shadowColor: Colors.blueGrey,
            child: ListTile(
                   tileColor: Colors.white,
              leading: Checkbox(
                  activeColor: Colors.black,
                  value: taskCompleted,
                  onChanged: onChanged),
              title: Text(
                taskName,
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    letterSpacing: 0.5,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              subtitle: Text(
                taskDescription,
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    letterSpacing: 0.5,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ),
          ),
        ));
  }
}
