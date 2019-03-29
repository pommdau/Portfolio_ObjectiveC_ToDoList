//
//  ToDoItem.m
//  ToDoList
//
//  Created by HIROKI IKEUCHI on 2019/03/27.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "ToDoItem.h"

// Keys for registering UserDefault
NSString *const kIsCheckedKey          = @"isChecked";
NSString *const kPriorityKey           = @"priority";
NSString *const kNameKey               = @"name";
NSString *const kPlaceKey              = @"place";
NSString *const kStartDateKey          = @"startDate";
NSString *const kLimitDateKey          = @"limitDate";
NSString *const kIsEnableEditButtonKey = @"isEnableEditButton";

@implementation ToDoItem

- (id)init {
    self = [super init];
    if (self) {
        _isChecked = NO;
        _priority  = @"None";
        _name      = @"new item";
        _place     = @"自宅";
        _startDate = [NSDate date];
        _limitDate = [NSDate date];
        _isEnableEditButton = YES;
    }
    return self;
}

/**
 @brief チェックボックスの状態を反転させる
 */
- (void)toggleChecked {
    _isChecked = !_isChecked;
}
#pragma mark - NSCoding Delegate

/**
 @brief 変換用メソッド（NSDataへの変換で使用）
 */
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeBool  :_isChecked             forKey:kIsCheckedKey];
    [aCoder encodeObject:_priority              forKey:kPriorityKey];
    [aCoder encodeObject:_name                  forKey:kNameKey];
    [aCoder encodeObject:_place                 forKey:kPlaceKey];
    [aCoder encodeObject:_startDate             forKey:kStartDateKey];
    [aCoder encodeObject:_limitDate             forKey:kLimitDateKey];
    [aCoder encodeBool  :_isEnableEditButton    forKey:kIsEnableEditButtonKey];
}

/**
 @brief 初期化用メソッド（NSDataからの変換で使用する）
 */
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _isChecked          = [aDecoder decodeBoolForKey  :kIsCheckedKey];
        _priority           = [aDecoder decodeObjectForKey:kPriorityKey];
        _name               = [aDecoder decodeObjectForKey:kNameKey];
        _place              = [aDecoder decodeObjectForKey:kPlaceKey];
        _startDate          = [aDecoder decodeObjectForKey:kStartDateKey];
        _limitDate          = [aDecoder decodeObjectForKey:kLimitDateKey];
        _isEnableEditButton = [aDecoder decodeBoolForKey  :kIsEnableEditButtonKey];
    }
    return self;
}

@end
