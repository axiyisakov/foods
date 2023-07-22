import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _list = ['Salom', "dunyo", 'i can fly', 'dont cry'];

  final _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: body),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddItem,
        child: const Icon(Icons.add),
      ),
    );
  }

  ///body
  Widget get body {
    return AnimatedList(
        key: _listKey,
        shrinkWrap: true,
        initialItemCount: _list.length,
        itemBuilder: (context, index, animation) => BuildCardItem(
            animation: animation,
            index: index,
            onDelete: () => _onDelete(index),
            text: _list[index]));
  }

  ///insert item function
  void _onAddItem() {
    final newIndex = _list.length;
    const newItem = 'hello';
    _list.insert(newIndex, newItem);
    _listKey.currentState!
        .insertItem(newIndex, duration: const Duration(seconds: 1));
  }

  ///delete item from list
  void _onDelete(int? index) {
    final removedItem = _list[index!];
    _list.removeAt(index);
    _listKey.currentState!.removeItem(
        index,
        (context, animation) => BuildCardItem(
              animation: animation,
              onDelete: () {},
              text: removedItem,
              index: index,
            ),
        duration: const Duration(seconds: 1));
  }
}

class BuildCardItem extends StatelessWidget {
  final Animation<double> animation;
  final VoidCallback? onDelete;
  final int? index;
  final String? text;
  const BuildCardItem(
      {super.key,
      required this.animation,
      required this.onDelete,
      required this.text,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation
          .drive(Tween(begin: const Offset(-1, 0), end: const Offset(0, 0))),
      child: Card(
          child: ListTile(
        key: ValueKey<String>(index.toString()),
        tileColor: Colors.green,
        title: Text(text!),
        trailing: IconButton(
            onPressed: onDelete, icon: const Icon(Icons.remove_circle_outline)),
      )),
    );
  }
}
