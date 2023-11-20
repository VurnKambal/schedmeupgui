import 'package:schedmeupgui/app_state.dart';

class MemoryBlock {
  int start;
  int size;
  bool isFree;

  MemoryBlock({required this.start, required this.size, this.isFree = true});
}

class Memory {
  List<MemoryBlock> blocks;
  int memorySize = 100;
  Memory({required this.blocks});

  void relocateAndCompact() {
    // Sort the blocks by start address
    blocks.sort((a, b) => a.start.compareTo(b.start));

    int currentAddress = 0;

    for (var block in blocks) {
      // If the block is not free, relocate it to the current address
      if (!block.isFree) {
        block.start = currentAddress;
        currentAddress += block.size;
      }
    }

    // Remove all free blocks
    blocks.removeWhere((block) => block.isFree);

    // Add a free block with the remaining memory
    if (currentAddress < memorySize) {
      blocks.add(MemoryBlock(
          start: currentAddress, size: memorySize - currentAddress));
    }
  }
}

Future<void> startRWC(int memorySize, List<int> jobSizes) async {
  // Initialize memory with some blocks
  Memory memory = Memory(blocks: [
    MemoryBlock(start: 0, size: 100, isFree: false),
    MemoryBlock(start: 100, size: 200, isFree: true),
    MemoryBlock(start: 300, size: 100, isFree: false),
    MemoryBlock(start: 400, size: 200, isFree: true),
  ]);

  // Print the initial state of the memory
  print('Initial state:');
  for (var block in memory.blocks) {
    print(
        'Start: ${block.start}, Size: ${block.size}, IsFree: ${block.isFree}');
  }

  // Relocate and compact the memory
  memory.relocateAndCompact();

  // Print the state of the memory after relocation and compaction
  print('\nAfter relocation and compaction:');
  for (var block in memory.blocks) {
    print(
        'Start: ${block.start}, Size: ${block.size}, IsFree: ${block.isFree}');
  }
}
