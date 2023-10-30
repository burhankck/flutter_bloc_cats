import 'package:bloc_cats/cat_bloc/cat_state.dart';
import 'package:bloc_cats/cat_bloc/cats_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCatsView extends StatefulWidget {
  const BlocCatsView({super.key});

  @override
  State<BlocCatsView> createState() => _BlocCatsViewState();
}

class _BlocCatsViewState extends State<BlocCatsView> with _PageProperties {
  @override
  void initState() {
    _initCubits();
    super.initState();
  }

  void _initCubits() {
    _catsCubit = context.read<CatsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Bloc Cats"),
      ),
      body: BlocConsumer<CatsCubit, CatsState>(
        listener: (context, state) {
          if (state is CatsError) {
            Scaffold.of(context).showBottomSheet((context) => Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is CatsInitial) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 200),
                  Text('Click Button'),
                  SizedBox(height: 20),
                  buttonCall(context),
                ],
              ),
            );
          } else if (state is CatsLoading) {
            return CircularProgressIndicator(color: Colors.red);
          } else if (state is CatsCompleted) {
            return ListView.builder(
              itemCount: state.catModelList.length,
              itemBuilder: (context, index) => ListTile(
                title: Image.network(
                    state.catModelList[index]!.imageUrl.toString()),
                subtitle:
                    Text(state.catModelList[index]!.description.toString()),
              ),
            );
          } else {
            final errorStates = state as CatsError;
            return Text(errorStates.message);
          }
        },
      ),
    );
  }

  FloatingActionButton buttonCall(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.clear_all),
      onPressed: () {
        _catsCubit.getCats();
      },
    );
  }
}

mixin _PageProperties {
  late CatsCubit _catsCubit;
}
