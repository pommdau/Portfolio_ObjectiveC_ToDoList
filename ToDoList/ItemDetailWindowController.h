//
//  EditDetailWindowController.h
//  ToDoList
//
//  Created by HIROKI IKEUCHI on 2019/03/27.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol EditDetailWindowControllerDelegate;
@class ToDoItem;

@interface ItemDetailWindowController : NSWindowController
@property (nonatomic, weak) id<EditDetailWindowControllerDelegate> delegate;

- (id)initWithToDoItem:(ToDoItem *)toDoItem;
@end


@protocol EditDetailWindowControllerDelegate <NSObject>
- (void)EditDetailWindowController:(ItemDetailWindowController *)editDetailWindowController didOKWithToDoItem:(ToDoItem *)toDoItem;
- (void)EditDetailWindowControllerDidCancel:(ItemDetailWindowController *)editDetailWindowController;
@end
