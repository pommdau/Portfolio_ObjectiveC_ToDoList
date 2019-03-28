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
@property NSMutableArray<ToDoItem *> *toDoItems;
@property (weak) IBOutlet NSTableView *toDoListTableView;
@property (nonatomic, readonly) ItemDetailWindowController *editDetailWindowController;
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
    ItemDetailWindowController *editDetailWindowController = [[ItemDetailWindowController alloc] initWithToDoItem:nil];
    editDetailWindowController.delegate = self;
    [editDetailWindowController showWindow:self];
    _editDetailWindowController = editDetailWindowController;
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

- (IBAction)checkBoxPushed:(id)sender {
    // 選択されたチェックボックスはどの行か
    NSInteger row = [_toDoListTableView rowForView:sender];
    // 選択されている項目は空か
    if (row < 0) {
        NSBeep();
        return;
    }
    [_toDoItems[row] toggleChecked];
}

- (IBAction)editSelectedToDoListItem:(id)sender {
    // どの行が選択されているか
    NSInteger row = [_toDoListTableView rowForView:sender];
    NSLog(@"%ld", (long)row);
    
    ItemDetailWindowController *editDetailWindowController = [[ItemDetailWindowController alloc] initWithToDoItem:_toDoItems[row]];
    editDetailWindowController.delegate = self;
    [editDetailWindowController showWindow:self];
    _editDetailWindowController = editDetailWindowController;
}

#pragma mark - EditDetailWindowControllerDelegate Methods

- (void)EditDetailWindowController:(ItemDetailWindowController *)editDetailWindowController didOKWithToDoItem:(ToDoItem *)toDoItem {
    [editDetailWindowController close];
    [_toDoItems addObject:toDoItem];
    [_toDoListTableView reloadData];
}

- (void)EditDetailWindowControllerDidCancel:(ItemDetailWindowController *)editDetailWindowController {
    [editDetailWindowController close];
}


@end
