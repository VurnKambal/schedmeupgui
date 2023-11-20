// Automatic FlutterFlow imports
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../widgets/process_animated_list_srtf.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!
import 'dart:collection';

Future startLRU(int frames, List<String> pageRequests) async {
  LRUCache cache = LRUCache(frames);
  for (int i = 0; i < frames; i++) {
    cache._doublyQueue.add("");
  }
  for (String pageRequest in pageRequests) {
    // Page Interrupt
    if (!cache._hashSet.contains(pageRequest)) {
      FFAppState().update(() {
        FFAppState().pageInterrupts++;
      });
    }
    await cache.refer(pageRequest);
  }

  cache.display();
  FFAppState().update(() {
    FFAppState().failRate =
        (FFAppState().pageInterrupts / pageRequests.length) * 100;
  });
  FFAppState().update(() {
    FFAppState().successRate = 100 - FFAppState().failRate;
  });
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
  Future<void> refer(String page) async {
    // Most Recently Used Page Reference
    // If page exists in the cache
    if (!_hashSet.contains(page)) {
      // Check if the queue is full
      if (_doublyQueue.length == _cacheSize) {
        String last = _doublyQueue[_doublyQueue.length - 1];

        _doublyQueue.removeAt(_doublyQueue.length - 1);
        _hashSet.remove(last);
      }
    } else {
      /* The found page may not be always the last
               element, even if it's an intermediate
               element that needs to be removed and added
               to the start of the Queue */

      // Animate? Moving the page to the front of the queue if it exists

      _doublyQueue.remove(page);
    }

    // Animate? Most Recently Used Page Insertion
    _doublyQueue.insert(0, page);
    _hashSet.add(page);
    print(_doublyQueue);
    print(_hashSet);
    for (int i = 0; i < _doublyQueue.length; i++) {
      if (_doublyQueue.isNotEmpty) {
        FFAppState().update(() {
          FFAppState().queueHistory[i].add(_doublyQueue[i]);
        });
      }
    }
  }

  // display contents of cache
  void display() {
    for (String page in _doublyQueue) {
      print("$page ");
    }
  }
}
 
// C# code by phasing17 : https://www.geeksforgeeks.org/lru-cache-implementation/