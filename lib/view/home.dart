import 'package:flutter/material.dart';
import 'package:task_app/model/task.dart';
import 'package:task_app/utils/database_helper.dart';
import 'package:task_app/view/add_task.dart';
import 'package:task_app/view/detail_screen.dart';
import 'package:task_app/view/edit_task.dart';

class Home extends StatefulWidget {
  static const String home = "/home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper helper = DatabaseHelper();

  Future<List<Map>> getTasks() async {
    return await helper.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Task",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: FutureBuilder<List<Map>>(
          future: getTasks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int i) {
                    int l = snapshot.data!.length - 1 - i;
                    if (l >= 0) {
                      return Card(
                        shadowColor: Colors.white54,
                        margin: const EdgeInsets.only(
                          top: 19.0,
                          left: 10.0,
                          right: 10.0,
                        ),
                        elevation: 3.5,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          onTap: () {
                            final Task task = Task(
                              id: snapshot.data![i]['id'],
                              title: snapshot.data![i]['title'],
                              description: snapshot.data![i]['description'],
                            );
                            Navigator.of(context).pushNamed(
                              DetailScreen.detailScreen,
                              arguments: task,
                            );
                          },
                          title: Text(
                            snapshot.data![l]['title'],
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data![l]['description'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                iconSize: 30.0,
                                onPressed: () {
                                  final Task task = Task(
                                    id: snapshot.data![i]['id'],
                                    title: snapshot.data![i]['title'],
                                    description: snapshot.data![i]
                                        ['description'],
                                  );
                                  Navigator.of(context).pushNamed(
                                      EditTask.editTask,
                                      arguments: task);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                iconSize: 30.0,
                                onPressed: () async {
                                  await helper
                                      .deleteData(snapshot.data![i]['id']);
                                  setState(() {
                                    getTasks();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No Notes \n Add new one",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              AddTask.addTask,
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
