// Automatic FlutterFlow imports
import 'dart:collection';
import 'dart:math';

import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';

// Begin custom widget code
class MemoryAnimatedListRWC extends StatefulWidget {
  const MemoryAnimatedListRWC({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  MemoryAnimatedListRWCState createState() =>
      MemoryAnimatedListRWCState(width: width, height: height);
}

class MemoryAnimatedListRWCState extends State<MemoryAnimatedListRWC> {
  MemoryAnimatedListRWCState({this.width, this.height});
  double? width;
  double? height;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  Memory _memory = Memory(blocks: []);
  List<MemoryBlock> _memoryBlocks = [];
  int delaySeconds = 1;
  int delayMiliseconds = 500;
  int jobNumber = -1;

  @override
  void initState() {
    super.initState();
  }

  List<MemoryBlock> get memoryBlocks => _memoryBlocks;
  set memoryBlocks(List<MemoryBlock> _value) {
    _memoryBlocks = _value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width!,
        height: height,
        child: AnimatedList(
          key: _listKey,
          initialItemCount: _memoryBlocks.length,
          itemBuilder: (context, index, animation) {
            return _buildItem(_memoryBlocks[index], animation);
          },
        ));
  }

  Widget _buildItem(MemoryBlock itemBlock, Animation<double> animation) {
    int item = itemBlock.size;
    int itemColorInt = item;
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
              child: Text(
                  '${itemBlock.isFree ? 'Free' : '${itemBlock.jobNumber != -1 ? "Job ${itemBlock.jobNumber}" : 'Used'}'}: ${item}',
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
        ));
  }

  Future<void> addItem(MemoryBlock item) async {
    int index = _memoryBlocks.isEmpty ? 0 : _memoryBlocks.length - 1;
    _memoryBlocks.insert(index, item);
    _listKey.currentState!.insertItem(0);
    await Future.delayed(Duration(seconds: delaySeconds));
  }

  Future<void> insertItem(int index, MemoryBlock item) async {
    _memoryBlocks.insert(index, item);
    _listKey.currentState!.insertItem(index);
    await Future.delayed(Duration(seconds: delaySeconds));
  }

  Future<void> removeItem(int index) async {
    MemoryBlock removedItem = _memoryBlocks.removeAt(index);

    _listKey.currentState!.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation),
    );
    await Future.delayed(Duration(milliseconds: delayMiliseconds));
  }

  Future<void> clear() async {
    while (_memoryBlocks.isNotEmpty) {
      MemoryBlock removedItem = _memoryBlocks.removeAt(0);
      _listKey.currentState!.removeItem(
        0,
        (context, animation) => _buildItem(removedItem, animation),
      );
    }
    await Future.delayed(Duration(seconds: delaySeconds));
  }

  // Unused
  Future<void> sortItems() async {
    List<MemoryBlock> newList = List.from(FFAppState().newMemoryBlocks);
    bool isSame = true;

    // Check if the old list contains the same items as the new list
    if (_memoryBlocks.length != newList.length) {
      Exception("Lists are not the same length [Backend Error]");
    }
    for (int i = 0; i < _memoryBlocks.length; i++) {
      if (_memoryBlocks[i] != newList[i]) {
        isSame = false;
        break;
      }
    }
    // If the lists are the same, do nothing (Not sorted)
    if (isSame) {
      return;
    }

    // If the lists are not the same, List has been sorted
    else {
      await removeItem(0);
      while (_memoryBlocks.isNotEmpty) {
        await removeItem(0);
      }
      // Add items back in sorted order
      for (int i = 0; i < newList.length; i++) {
        await insertItem(i, newList[i]);
      }
    }
  }

  Future<void> startRWC(GlobalKey<MemoryAnimatedListRWCState> listKey,
      int memorySize, List<int> jobSizes) async {
    if (_memory.blocks.isEmpty && _memory.blocks.length <= 1) {
      _memory.generateRandomBlocks(listKey);
    } else {
      // Print the initial state of the memory
      print('Initial state (NON GEN):');
      for (var block in _memory.blocks) {
        print(
            'Start: ${block.start}, Size: ${block.size}, IsFree: ${block.isFree}');
      }
      _memory.randomlyDeallocate(listKey);
      // Relocate and compact the memory
      _memory.relocateAndCompact(listKey);
      await listKey.currentState!.sortItems();
      await Future.delayed(Duration(seconds: delaySeconds));
      jobNumber = 1;
      for (int job in jobSizes) {
        _memory.allocateFirstFit(listKey, job, jobNumber: jobNumber);
        _memory.relocateAndCompact(listKey);
        jobNumber++;
      }
      await listKey.currentState!.sortItems();
      // Print the state of the memory after relocation and compaction
      print('\nAfter relocation and compaction:');
      for (var block in _memory.blocks) {
        print(
            'Start: ${block.start}, Size: ${block.size}, IsFree: ${block.isFree}');
      }
      MemoryBlock lastBlock = _memoryBlocks[_memoryBlocks.length - 1];
      if (lastBlock.isFree) {
        FFAppState().update(() {
          FFAppState().externalFragmentation = lastBlock.size;
        });
      } else {
        FFAppState().update(() {
          FFAppState().externalFragmentation = 0;
        });
      }
    }
  }

  void generateRandomBlocks(GlobalKey<MemoryAnimatedListRWCState> listKey) {
    _memory.generateRandomBlocks(listKey);
  }
}

class MemoryBlock {
  int start;
  int size;
  bool isFree;
  int jobNumber;

  MemoryBlock(
      {this.start = 0, this.size = 0, this.isFree = true, this.jobNumber = -1});
}

class Memory {
  List<MemoryBlock> blocks;
  int memorySize = 100;
  Memory({required this.blocks});
  void randomlyDeallocate(
    GlobalKey<MemoryAnimatedListRWCState> listKey,
  ) {
    int totalJobSize =
        FFAppState().jobSizes.fold(0, (prev, jobSize) => prev + jobSize);
    Random random = Random();
    int totalFreeSize = blocks
        .where((block) => block.isFree)
        .fold(0, (prev, block) => prev + block.size);

    // Get all non-free blocks
    List<MemoryBlock> nonFreeBlocks = [];

    nonFreeBlocks = blocks.where((block) => !block.isFree).toList();

    while (totalFreeSize < totalJobSize && nonFreeBlocks.isNotEmpty) {
      // Randomly select a non-free block
      int randomIndex = random.nextInt(nonFreeBlocks.length);
      int blockIndex = blocks.indexOf(nonFreeBlocks[randomIndex]);

      // Deallocate the block
      blocks[blockIndex].isFree = true;
      nonFreeBlocks.removeAt(randomIndex);

      // Update the total free size
      totalFreeSize += blocks[blockIndex].size;
    }
  }

  void generateRandomBlocks(
      final GlobalKey<MemoryAnimatedListRWCState> listKey) {
    Random random = Random();
    MemoryBlock block;
    memorySize = FFAppState().memorySize;
    int remainingMemorySize = memorySize;
    listKey.currentState!.clear();
    blocks.clear();

    while (remainingMemorySize > 0) {
      int blockSize =
          min(random.nextInt(memorySize ~/ 2) + 1, remainingMemorySize);
      bool isFree = random.nextBool();
      block = MemoryBlock(
          start: blocks.isNotEmpty
              ? blocks[blocks.length - 1].start + blocks[blocks.length - 1].size
              : 0,
          size: blockSize,
          isFree: isFree);

      listKey.currentState!.addItem(block);
      blocks.add(block);

      remainingMemorySize -= blockSize;
    }

    // Print the initial state of the memory
    print('Initial state:');
    for (var block in blocks) {
      print(
          'Start: ${block.start}, Size: ${block.size}, IsFree: ${block.isFree}');
    }
    // Generate random blocks
    // Random random = Random();
    // int numberOfBlocks = random.nextInt(10) + 1;
    // int currentAddress = 0;
    // for (int i = 0; i < numberOfBlocks; i++) {
    //   int blockSize = random.nextInt(100) + 1;
    //   blocks.add(MemoryBlock(start: currentAddress, size: blockSize));
    //   currentAddress += blockSize;
    // }
  }

  void relocateAndCompact(
    GlobalKey<MemoryAnimatedListRWCState> listKey,
  ) async {
    memorySize = FFAppState().memorySize;
    // Sort the blocks by start address
    blocks.sort((a, b) => a.start.compareTo(b.start));

    int currentAddress = 0;

    for (int i = 0; i < blocks.length; i++) {
      // If the block is not free, relocate it to the current address
      if (!blocks[i].isFree) {
        blocks[i].start = currentAddress;
        currentAddress += blocks[i].size;
      }
    }
    // Remove all free blocks
    for (int i = blocks.length - 1; i >= 0; i--) {
      if (blocks[i].isFree) {
        blocks.removeAt(i);
      }
    }
    // Add a free block with the remaining memory
    if (currentAddress < memorySize) {
      MemoryBlock memoryBlock =
          MemoryBlock(start: currentAddress, size: memorySize - currentAddress);

      blocks.add(memoryBlock);
    }

    FFAppState().update(() {
      FFAppState().newMemoryBlocks = List.from(blocks);
    });
  }

  void allocateFirstFit(
      GlobalKey<MemoryAnimatedListRWCState> listKey, int processSize,
      {jobNumber = -1}) {
    // Find the first free block that is large enough
    int? blockIndex = blocks.length - 1;
    if (blockIndex != -1) {
      // If the block is exactly the size of the process, simply allocate it
      if (blocks[blockIndex].size == processSize) {
        blocks[blockIndex].isFree = false;
      } else {
        // If the block is larger than the process, split it into two blocks
        blocks[blockIndex] = MemoryBlock(
            start: blocks[blockIndex].start,
            size: processSize,
            isFree: false,
            jobNumber: jobNumber);
        blocks.insert(
            blockIndex + 1,
            MemoryBlock(
                start: blocks[blockIndex].start + processSize,
                size: blocks[blockIndex].size - processSize,
                jobNumber: jobNumber));
      }
    } else {
      print('No suitable block found for process size $processSize');
    }
  }
}
