//
//  AppDelegate.m
//  ToDoList
//
//  Created by HIROKI IKEUCHI on 2019/03/27.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "AppDelegate.h"
#import "ToDoListWindowController.h"

@interface AppDelegate ()
@property (nonatomic, readonly) ToDoListWindowController *toDoListWindowController;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    ToDoListWindowController *toDoListWindowController = [[ToDoListWindowController alloc] init];
    [toDoListWindowController showWindow:self];
    _toDoListWindowController = toDoListWindowController;
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
