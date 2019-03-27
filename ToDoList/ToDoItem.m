//
//  ToDoItem.m
//  ToDoList
//
//  Created by HIROKI IKEUCHI on 2019/03/27.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

- (id)init {
    self = [super init];
    if (self) {
        _isChecked = NO;
        _priority  = @"nil";
        _name      = @"new item";
        _place     = @"place";
        _startDate = [NSDate date];
        _limitDate = [NSDate date];
        _isEnableEditButton = YES;
    }
    return self;
}

@end
