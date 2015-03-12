//
//  PCETodoItem.h
//  UWTodoApp
//
//  Created by Martin Nash on 7/8/14.
//  Copyright (c) 2014 Martin Nash (UW). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoItem : NSObject

@property (copy, nonatomic) NSString *title;

+(instancetype)todoItemWithTitle:(NSString*)title;

@end

