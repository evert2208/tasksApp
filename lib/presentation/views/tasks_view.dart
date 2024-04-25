import 'package:flutter/material.dart';


class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      
      body: const _TasksView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Task'),
        icon: const Icon( Icons.add ),
        onPressed: () {},
      ),
    );
  }
}


class _TasksView extends StatelessWidget {
  const _TasksView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Taks view'));
  }
}