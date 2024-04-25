import 'package:flutter/material.dart';
import 'package:tasks_app/presentation/shared/custom_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class HomeView extends ConsumerStatefulWidget {
  const HomeView({ super.key });

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin{
  

@override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    

    return CustomScrollView(

      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),

         SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return const Column(
              children: [
                _HomeView()
              ]
            );
          },
          childCount: 1
         )
         )
      ],
    );


  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home!!'));
  }


}