//
//  EditDetailWindowController.m
//  ToDoList
//
//  Created by HIROKI IKEUCHI on 2019/03/27.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "ItemDetailWindowController.h"
#import "ToDoItem.h"

@interface ItemDetailWindowController ()
@property (weak) IBOutlet NSPopUpButton *priority_input;
@property (weak) IBOutlet NSTextField   *name_input;
@property (weak) IBOutlet NSTextField   *place_input;
@property (weak) IBOutlet NSDatePicker  *startDate_input;
@property (weak) IBOutlet NSDatePicker  *limitDate_input;
@property (weak) IBOutlet NSButton      *okButton;
@property ToDoItem *toDoItem;   // toDoリストのアイテム
@end

@implementation ItemDetailWindowController
- (id)initWithToDoItem:(ToDoItem *)toDoItem {
    self = [super initWithWindowNibName:[self className] owner:self];
    if (self) {
        if (toDoItem == nil) {
            _toDoItem = [ToDoItem new];
            return self;    // 新規に項目を追加する場合
        }
        // 既存の項目を編集する場合
        _toDoItem = toDoItem;
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    // 入力フィールドに各値をセットする
    [_priority_input selectItemWithTitle: _toDoItem.priority];
    _name_input.stringValue  = _toDoItem.name;
    _place_input.stringValue = _toDoItem.place;
    _startDate_input.dateValue = _toDoItem.startDate;
    _limitDate_input.dateValue = _toDoItem.limitDate;
}

#pragma mark - Button Methods

- (IBAction)okButtonPush:(id)sender {
    _toDoItem.priority  = _priority_input.selectedItem.title;
    _toDoItem.name      = _name_input.stringValue;
    _toDoItem.place     = _place_input.stringValue;
    _toDoItem.startDate = _startDate_input.dateValue;
    _toDoItem.limitDate = _limitDate_input.dateValue;
    
    [_delegate EditDetailWindowController:self didOKWithToDoItem:_toDoItem];
}

- (IBAction)cancelButtonPush:(id)sender {
    [_delegate EditDetailWindowControllerDidCancel:self];
}


@end
