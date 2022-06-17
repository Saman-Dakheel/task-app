import 'package:flutter/material.dart';
import 'package:task_app/model/task.dart';

class DetailScreen extends StatelessWidget {
  static const String detailScreen = "/detailScreen";
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Task args = ModalRoute.of(context)!.settings.arguments as Task;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(args.title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            )),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SelectableText(
              args.description,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 28,
                color: Colors.green[50],
              ),
              textAlign: TextAlign.center,
              onTap: () => print('Tapped'),
              toolbarOptions: ToolbarOptions(
                copy: true,
                selectAll: true,
                cut: true,
                paste: true,
              ),
              showCursor: true,
              cursorWidth: 2,
              cursorColor: Colors.red,
              cursorRadius: Radius.circular(5),
            ),
          ),
        ],
      )),
    );
  }
}
