// Automatic FlutterFlow imports
import 'dart:collection';

import 'package:flutter/foundation.dart';

import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';

// Begin custom widget code
class MemoryAnimatedListLRU extends StatefulWidget {
  const MemoryAnimatedListLRU({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  MemoryAnimatedListLRUState createState() =>
      MemoryAnimatedListLRUState(width: width, height: height);
}

class MemoryAnimatedListLRUState extends State<MemoryAnimatedListLRU> {
  MemoryAnimatedListLRUState({this.width, this.height});
  double? width;
  double? height;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  LRUCache _cache = LRUCache(0);
  List<String> _pageQueue = [];
  int delaySeconds = 1;
  int delayMiliseconds = 500;
  int time = 0;

  @override
  void initState() {
    super.initState();
  }

  List<String> get pageQueue => _pageQueue;
  set pageQueue(List<String> _value) {
    _pageQueue = _value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width!,
        height: height,
        child: AnimatedList(
          key: _listKey,
          initialItemCount: _pageQueue.length,
          itemBuilder: (context, index, animation) {
            print("index: $index");
            print("pageQueue: ${pageQueue[index]}");
            return _buildItem(_pageQueue[index], animation);
          },
        ));
  }

  Widget _buildItem(String item, Animation<double> animation) {
    int itemColorInt = item.length > 0 ? item.codeUnitAt(item.length - 1) : 0;
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child: SizedBox(
          // Actual widget to display
          height: 50.0,
          child: Card(
            color: Colors.primaries[itemColorInt % Colors.primaries.length],
            child: Center(
              child: Text('Page ${item}',
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
        ));
  }

  Future<void> addItem(String item) async {
    // If the page is not already in the list, add it
    print(item);
    print(_pageQueue);
    print("---");
    if (!_pageQueue.contains(item)) {
      _pageQueue.insert(0, item);
      _listKey.currentState!.insertItem(0);
      await Future.delayed(Duration(seconds: delaySeconds));
    }
  }

  Future<void> insertItem(int index, String item) async {
    _pageQueue.insert(index, item);
    _listKey.currentState!.insertItem(index);
    await Future.delayed(Duration(seconds: delaySeconds));
  }

  Future<void> removeItem(int index) async {
    String removedItem = _pageQueue.removeAt(index);

    _listKey.currentState!.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation),
    );
    await Future.delayed(Duration(milliseconds: delayMiliseconds));
  }

  Future<void> clear() async {
    while (_pageQueue.isNotEmpty) {
      String removedItem = _pageQueue.removeAt(0);
      _listKey.currentState!.removeItem(
        0,
        (context, animation) => _buildItem(removedItem, animation),
      );
    }
    await Future.delayed(Duration(seconds: delaySeconds));
  }

  // Unused
  Future<void> sortItems() async {
    List<String> newList = FFAppState().newQueue;
    bool isSame = true;

    // Check if the old list contains the same items as the new list
    if (_pageQueue.length != newList.length) {
      Exception("Lists are not the same length [Backend Error]");
    }
    for (int i = 0; i < _pageQueue.length; i++) {
      if (_pageQueue[i] != newList[i]) {
        isSame = false;
        break;
      }
    }
    // if (_processList.isEmpty) {
    //   print("empty");
    //   insertItem(0, newList[0]);
    //   await Future.delayed(Duration(seconds: delaySeconds));
    //   print("Not anymore");
    //   return;
    // }
    // If the lists are the same, do nothing (Not sorted)
    if (isSame) {
      return;
    }

    // If the lists are not the same, List has been sorted
    else {
      // Remove all items except for the running process

      if (_pageQueue[0] != newList[0]) {
        await removeItem(0);
        while (_pageQueue.isNotEmpty) {
          await removeItem(0);
        }
        // Add items back in sorted order
        for (int i = 0; i < newList.length; i++) {
          await insertItem(i, newList[i]);
        }
      } else {
        while (_pageQueue.length > 1) {
          await removeItem(1);
        }
        // Add items back in sorted order
        for (int i = 1; i < newList.length; i++) {
          await insertItem(i, newList[i]);
        }
      }
    }
  }

  Future startLRU(GlobalKey<MemoryAnimatedListLRUState> listKey, int frames,
      List<String> pageRequests) async {
    await listKey.currentState!.clear();
    int cacheSize = frames;
    _cache = LRUCache(cacheSize);
    for (String pageRequest in pageRequests) {
      if (FFAppState().isSimulating == true) {
        await _cache.refer(listKey, pageRequest);
      } else {
        return;
      }
    }
    _cache.display();
  }

  // /* Refer the page within the LRU cache */
  // void refer(LRUCache cache, page) {
  //   // Most Recently Used Page Reference
  //   // If page exists in the cache
  //   if (!cache._hashSet.contains(page)) {
  //     // Check if the queue is full
  //     if (cache._doublyQueue.length == cache._cacheSize) {
  //       int last = cache._doublyQueue[cache._doublyQueue.length - 1];

  //       // Animate? Least Recently Used Page Removal
  //       cache._doublyQueue.removeAt(_pageQueue.length - 1);
  //       cache._hashSet.remove(last);
  //     }
  //   } else {
  //     /* The found page may not be always the last
  //              element, even if it's an intermediate
  //              element that needs to be removed and added
  //              to the start of the Queue */

  //     // Animate? Moving the page to the front of the queue if it exists
  //     _doublyQueue.remove(page);
  //   }

  //   // Animate? Most Recently Used Page Insertion
  //   _doublyQueue.insert(0, page);
  //   _hashSet.add(page);
  //   print(_doublyQueue);
  //   print(_hashSet);
  // }
}

class LRUCache {
  // store keys of cache
  final List _doublyQueue = [];

  // store references of key in cache
  final HashSet _hashSet = HashSet<String>();

  // maximum capacity of cache
  int _cacheSize = 0;

  LRUCache(int capacity) {
    _cacheSize = capacity;
  }

  /* Refer the page within the LRU cache */
  Future<void> refer(
      GlobalKey<MemoryAnimatedListLRUState> listKey, String page) async {
    // Most Recently Used Page Reference
    // If page exists in the cache
    if (!_hashSet.contains(page)) {
      // Check if the queue is full
      if (_doublyQueue.length == _cacheSize) {
        String last = _doublyQueue[_doublyQueue.length - 1];

        // Animate? Least Recently Used Page Removal
        if (_doublyQueue.isNotEmpty) {
          await listKey.currentState!.removeItem(
            _doublyQueue.length - 1,
          );
        }
        _doublyQueue.removeAt(_doublyQueue.length - 1);
        _hashSet.remove(last);
      }
    } else {
      /* The found page may not be always the last
               element, even if it's an intermediate
               element that needs to be removed and added
               to the start of the Queue */

      // Animate? Moving the page to the front of the queue if it exists

      await listKey.currentState!
          .removeItem(listKey.currentState!._pageQueue.indexOf(page));
      _doublyQueue.remove(page);
    }

    // Animate? Most Recently Used Page Insertion
    _doublyQueue.insert(0, page);
    _hashSet.add(page);
    await listKey.currentState!.addItem(page);
    print(_doublyQueue);
    print(_hashSet);
  }

  // display contents of cache
  void display() {
    for (String page in _doublyQueue) {
      print("$page ");
    }
  }
}
 

// C# code by phasing17 : https://www.geeksforgeeks.org/lru-cache-implementation/