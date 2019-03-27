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
@property (strong) IBOutlet NSArrayController *toDoItemsController;
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

@end
