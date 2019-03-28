//
//  ToDoItem.h
//  ToDoList
//
//  Created by HIROKI IKEUCHI on 2019/03/27.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property BOOL      isChecked;  // チェックされていたら完了済み
@property NSString  *priority;  // 優先順位
@property NSString  *name;      // 項目名
@property NSString  *place;     // 場所
@property NSDate    *startDate; // 開始日
@property NSDate    *limitDate; // 期限日
@property BOOL      isEnableEditButton; // Editボタンを有効にするかどうか

- (void)toggleChecked; // チェックボックスの状態をを反転させる
@end
