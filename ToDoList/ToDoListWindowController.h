//
//  ToDoListWindowController.h
//  ToDoList
//
//  Created by HIROKI IKEUCHI on 2019/03/27.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AddItemWindowController.h"
@interface ToDoListWindowController : NSWindowController <NSTableViewDelegate,NSTableViewDataSource, AddItemWindowControllerDelegate>

@end
