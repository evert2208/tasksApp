import 'package:flutter/material.dart';
// import 'package:tasks_app/infrastructure/models/tasks_model.dart';


class TasksView extends StatefulWidget {
  const TasksView({super.key});

   @override
  State<TasksView> createState() => _TasksViewState();

}


class _TasksViewState extends State<TasksView> with TickerProviderStateMixin{
  final scaffoldKey = GlobalKey<ScaffoldState>();
   late TabController _model;
   @override
  void initState() {
    super.initState();
  

    _model = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
     _model.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Tasks'),
        centerTitle: false,
        ),
      body:  SafeArea(
      top: true,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              children: [
              Align(
              alignment: const Alignment(0, 0),
              child: TabBar(
                unselectedLabelColor: colors.primary,
                tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
              ],
              controller: _model,
              onTap: (i) async {
                 [() async {}, () async {}][i]();
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _model,
              children: const [
                Center(
                  child: Text('upcoming view'),
                ),
                Center(
                  child: Text('completed view'),
                )
                //  SizedBox(width: 100,
                //  height: 100,
                //  child: Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                //  ),
                //  ),
                //  SizedBox(width: 100,
                //  height: 100,
                //  child: Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                //  ),
                //  ),
              ],
            ),
          )
          ]
          )
          )
        ],
      ),
    ),
     floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child:  const Icon( Icons.add ),
      ),
    );
    
   
  }
}