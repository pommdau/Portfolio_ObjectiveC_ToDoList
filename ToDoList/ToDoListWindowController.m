//
//  ToDoListWindowController.m
//  ToDoList
//
//  Created by HIROKI IKEUCHI on 2019/03/27.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "ToDoListWindowController.h"
#import "ToDoItem.h"

static NSString *const kToDoItemsKey = @"ToDoItems";    // ToDoリストの項目リスト

@interface ToDoListWindowController ()
@property NSMutableArray<ToDoItem *> *toDoItems;
@property (weak) IBOutlet NSTableView *toDoListTableView;
@property (nonatomic, readonly) ItemDetailWindowController *editDetailWindowController;
@property (weak) IBOutlet NSButton *editButton;
@property (weak) IBOutlet NSButton *removeButton;
@end

@implementation ToDoListWindowController

- (id)init {
    self = [super initWithWindowNibName:[self className] owner:self];
    if (self) {
        [self loadToDoListItems];
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

#pragma mark - User Default

/**
 @brief 現在の状態をUserDefaultで登録する
 */
- (void)saveToDoListItems {
    // 各種プロパテイ、UserDefaultの初期化（既に値がセットされていれば上書きしない）
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *toDoItems = [NSKeyedArchiver archivedDataWithRootObject: _toDoItems];   // アーカイブ化してToDoListの項目を登録する
    [ud setObject: toDoItems forKey:kToDoItemsKey];
    [ud synchronize];
}

/**
 @brief UserDefaultで保存された値を読み込む
 */
- (void)loadToDoListItems {
    _toDoItems = [NSMutableArray array];
    // NSUserDefaultsからデータを読み込む
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    NSData *data = [ud dataForKey:kToDoItemsKey];
    if (data.length != 0) {
        _toDoItems = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
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

/**
 @brief テーブルの行の選択状態によって、ボタンのEnableを変更する
 */
- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    if (_toDoListTableView.selectedRow == -1) {
        _editButton.enabled   = NO;
        _removeButton.enabled = NO;
    } else {
        _editButton.enabled   = YES;
        _removeButton.enabled = YES;
    }
}

#pragma mark - Button Methods
/**
 @brief 項目を追加するボタン押下時
 */
- (IBAction)addToDoListItem:(id)sender {
    ItemDetailWindowController *editDetailWindowController = [[ItemDetailWindowController alloc] init];
    editDetailWindowController.delegate = self;
    [editDetailWindowController showWindow:self];
    _editDetailWindowController = editDetailWindowController;
}

/**
 @brief 項目を削除するボタン押下時
 */
- (IBAction)removeSelectedToDoListItem:(id)sender {
    // どの行が選択されているか
    // TODO: 複数選択して削除したい
    NSIndexSet *rows = [_toDoListTableView selectedRowIndexes];
    
    // 選択されている項目は空か
    if (rows.count == 0) {
        NSBeep();
        return;
    }
    [_toDoItems removeObjectsAtIndexes:rows];
    [self saveToDoListItems];
    
    _editButton.enabled = NO;
    _removeButton.enabled = NO;
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
    [self saveToDoListItems];
}

- (IBAction)editSelectedToDoListItem:(id)sender {
    // どの行が選択されているか
    NSInteger row;
    if ([[sender identifier] isEqualToString:@"editButtonInRow"]) {     // tableView内のボタンが押下された場合
        row = [_toDoListTableView rowForView:sender];
    } else if ([[sender identifier] isEqualToString:@"editButton"]) {   // tableViewのRowを選択してEditが押下された場合
        row = _toDoListTableView.selectedRow;
    } else {
        NSLog(@"select editbutton error");
        return;
    }
    
    ItemDetailWindowController *editDetailWindowController = [[ItemDetailWindowController alloc] init];
    editDetailWindowController.toDoItem = _toDoItems[row];
    editDetailWindowController.delegate = self;
    [editDetailWindowController showWindow:self];
    _editDetailWindowController = editDetailWindowController;
}

#pragma mark - EditDetailWindowControllerDelegate Methods

- (void)EditDetailWindowController:(ItemDetailWindowController *)editDetailWindowController didOKWithToDoItem:(ToDoItem *)toDoItem {
    [editDetailWindowController close];
    NSInteger replaceIndex = [_toDoItems indexOfObject:toDoItem];    // 編集されている場合はその項目のRowを取得する
    if (replaceIndex == NSNotFound) {
        [_toDoItems addObject:toDoItem];
    } else {
        [_toDoItems replaceObjectAtIndex: replaceIndex withObject:toDoItem];
    }
    
    [self saveToDoListItems];
    
    [_toDoListTableView reloadData];
}

- (void)EditDetailWindowControllerDidCancel:(ItemDetailWindowController *)editDetailWindowController {
    [editDetailWindowController close];
}


@end
