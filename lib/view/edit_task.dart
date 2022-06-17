import 'package:flutter/material.dart';
import 'package:task_app/model/task.dart';
import 'package:task_app/utils/database_helper.dart';
import 'package:task_app/view/home.dart';

class EditTask extends StatelessWidget {
  static const String editTask = "/editTask";

  final DatabaseHelper dbhelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    Task args = ModalRoute.of(context)!.settings.arguments as Task;
    final TextEditingController titleController =
        TextEditingController(text: args.title);
    final TextEditingController descriptionController =
        TextEditingController(text: args.description);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Edit Note",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  labelText: "Task Title",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 4,
                    ),
                  ),
                  icon: const Icon(Icons.title),
                ),
                controller: titleController,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                maxLines: 20,
                minLines: 1,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  labelText: "Task Description",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 4,
                    ),
                  ),
                  icon: const Icon(Icons.description_outlined),
                ),
                controller: descriptionController,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: MaterialButton(
                  onPressed: () async {
                    final Task task = Task(
                      id: args.id,
                      title: titleController.text,
                      description: descriptionController.text,
                    );
                    int response = await dbhelper.updateData(task);

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Home.home,
                      (route) => false,
                    );
                  },
                  textColor: Colors.white,
                  color: Colors.green,
                  child: const Text(
                    "Update Task",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
