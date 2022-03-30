import 'package:demo_drap_drop_list_view/data/draggable_list_data.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<DragAndDropList> list;

  @override
  void initState() {
    list = _buildListDragAndDrop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DragAndDropLists(
          listPadding: const EdgeInsets.all(16),
          itemDivider: const Divider(color: Colors.grey),
          listInnerDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          children: list,
          onItemReorder: _onItemReoder,
          onListReorder: _onListReoder,
        ),
      ),
    );
  }

  List<DragAndDropList> _buildListDragAndDrop() => allLists
      .map((e) => DragAndDropList(
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.header,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          children: e.items
              .map((e1) => DragAndDropItem(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.network(
                          e1.image,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          e1.title,
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  )))
              .toList()))
      .toList();

  void _onItemReoder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      final oldListItems = list[oldListIndex].children;
      final newListItems = list[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);
    });
  }

  void _onListReoder(int oldListIndex, int newListIndex) {
    setState(() {
      final movedList = list.removeAt(oldListIndex);
      list.insert(newListIndex, movedList);
    });
  }
}
