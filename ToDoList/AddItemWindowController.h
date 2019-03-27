//
//  AddItemWindowController.h
//  ToDoList
//
//  Created by HIROKI IKEUCHI on 2019/03/27.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol AddItemWindowControllerDelegate;
@class ToDoItem;

@interface AddItemWindowController : NSWindowController
@property (nonatomic, weak) id<AddItemWindowControllerDelegate> delegate;

- (id)initWithToDoItem:(ToDoItem *)toDoItem;
@end


@protocol AddItemWindowControllerDelegate <NSObject>
- (void)AddItemWindowController:(AddItemWindowController *)addItemWindowController didOKWithToDoItem:(ToDoItem *)toDoItem;
- (void)AddItemWindowControllerDidCancel:(AddItemWindowController *)addItemWindowController;
@end
