//
//  ToDoListWindowController.m
//  ToDoList
//
//  Created by HIROKI IKEUCHI on 2019/03/27.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "ToDoListWindowController.h"
#import "ToDoItem.h"

@interface ToDoListWindowController ()
@property NSMutableArray *toDoItems;
@property (strong) IBOutlet NSArrayController *toDoItemsController; // データとテーブルビューを結ぶ
@property (weak) IBOutlet NSTableView *toDoListTableView;
@end

@implementation ToDoListWindowController

- (id)init {
    self = [super initWithWindowNibName:[self className] owner:self];
    if (self) {
        _toDoItems = [NSMutableArray array];
        ToDoItem *sample1 = [ToDoItem new];
        [_toDoItems addObject:sample1];
        _toDoItemsController.content = _toDoItems;
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

#pragma mark - Button Action

- (IBAction)addToDoListItem:(id)sender {
    static int count = 0;
    ToDoItem *addItem = [ToDoItem new];
    addItem.name = [NSString stringWithFormat:@"sample %d", count];
    count++;
    
    // どの行が選択されているか
    NSInteger row = _toDoListTableView.selectedRow;
    if (row == -1) {
        row = 0;    // 行が選択されていないときは-1
    }
    [_toDoItems insertObject:addItem atIndex:row];
    
//    [_toDoItems addObject:addItem];
    _toDoItemsController.content = _toDoItems;
}

- (IBAction)removeSelectedToDoListItem:(id)sender {
    // どの行が選択されているか
    NSIndexSet *rows = [_toDoListTableView selectedRowIndexes];
    
    // 選択されている項目は空か
    if (rows.count == 0) {
        NSBeep();
        return;
    }
    
    [_toDoItems removeObjectsAtIndexes:rows];
    _toDoItemsController.content = _toDoItems;
}


@end
