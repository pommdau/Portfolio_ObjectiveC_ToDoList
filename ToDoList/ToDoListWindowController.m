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
@property (weak) IBOutlet NSTableView *toDoListTableView;
@end

@implementation ToDoListWindowController

- (id)init {
    self = [super initWithWindowNibName:[self className] owner:self];
    if (self) {
        _toDoItems = [NSMutableArray array];
        ToDoItem *sample1 = [ToDoItem new];
        [_toDoItems addObject:sample1];
        [_toDoListTableView reloadData];
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

#pragma mark - NSTableView data source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return _toDoItems.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row{
    NSString *identifier = tableColumn.identifier;
    ToDoItem *data = _toDoItems[row];
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    cellView.objectValue = [data valueForKey:identifier];
    return cellView;
}

#pragma mark - Button Methods
/**
 @brief 項目を追加するボタン押下時
 */
- (IBAction)addToDoListItem:(id)sender {
    static int count = 0;
    ToDoItem *addItem = [ToDoItem new];
    addItem.name = [NSString stringWithFormat:@"sample %d", count];
    count++;
    
    // どの行が選択されているか（行が選択されていないときは-1）
    NSInteger row = _toDoListTableView.selectedRow;
    if (row == -1) {
        row = 0;
    }
    [_toDoItems insertObject:addItem atIndex:row];
    [_toDoListTableView reloadData];
}

/**
 @brief 項目を削除するボタン押下時
 */
- (IBAction)removeSelectedToDoListItem:(id)sender {
    // どの行が選択されているか
    NSIndexSet *rows = [_toDoListTableView selectedRowIndexes];
    
    // 選択されている項目は空か
    if (rows.count == 0) {
        NSBeep();
        return;
    }
    
    [_toDoItems removeObjectsAtIndexes:rows];
    [_toDoListTableView reloadData];
}

- (IBAction)editToDoListItem:(id)sender {
    // どの行が選択されているか
    NSInteger row = _toDoListTableView.selectedRow;
    NSLog(@"selectedRoe:%ld", (long)row);
}

@end
