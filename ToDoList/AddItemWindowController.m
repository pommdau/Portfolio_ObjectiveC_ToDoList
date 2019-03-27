//
//  AddItemWindowController.m
//  ToDoList
//
//  Created by HIROKI IKEUCHI on 2019/03/27.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "AddItemWindowController.h"
#import "ToDoItem.h"

@interface AddItemWindowController ()
@property (weak) IBOutlet NSPopUpButton *priority_input;
@property (weak) IBOutlet NSTextField   *name_input;
@property (weak) IBOutlet NSTextField   *place_input;
@property (weak) IBOutlet NSDatePicker  *startDate_input;
@property (weak) IBOutlet NSDatePicker  *limitDate_input;
@property (weak) IBOutlet NSButton      *okButton;
@end

@implementation AddItemWindowController
- (id)initWithToDoItem:(ToDoItem *)toDoItem {
    self = [super initWithWindowNibName:[self className] owner:self];
    if (self) {
        if (toDoItem == nil) {
            return self;    // 新規に項目を追加する場合
        }
        // 既存の項目を編集する場合
        
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

#pragma mark - Button Methods

- (IBAction)okButtonPush:(id)sender {
    ToDoItem *newItem = [ToDoItem new];
    newItem.name = _name_input.stringValue;
    newItem.priority = _priority_input.selectedItem.title;
    [_delegate AddItemWindowController:self didOKWithToDoItem:newItem];
}

- (IBAction)cancelButtonPush:(id)sender {
    [_delegate AddItemWindowControllerDidCancel:self];
}


@end
