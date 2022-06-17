import 'package:flutter/material.dart';
import 'package:task_app/model/task.dart';
import 'package:task_app/utils/database_helper.dart';
import 'package:task_app/view/home.dart';

class AddTask extends StatelessWidget {
  static const String addTask = "/addTask";
  final DatabaseHelper dbhelper = DatabaseHelper();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Task",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              style: const TextStyle(
                fontSize: 24,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                labelText: "Task Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 4,
                  ),
                ),
                icon: Icon(Icons.title),
              ),
              controller: titleController,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              minLines: 1,
              maxLines: 20,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                labelText: "Task Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 4,
                  ),
                ),
                icon: Icon(Icons.description),
              ),
              controller: descriptionController,
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: MaterialButton(
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  final Task task = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                  );
                  await dbhelper.insertTask(task);

                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Home.home,
                    (route) => false,
                  );
                },
                child: const Text(
                  "Insert Task",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
