//
//  PCETodoItem.m
//  UWTodoApp
//
//  Created by Martin Nash on 7/8/14.
//  Copyright (c) 2014 Martin Nash (UW). All rights reserved.
//

#import "TodoItem.h"

@implementation TodoItem

+(instancetype)todoItemWithTitle:(NSString *)title
{
    // in a class method, self equals the class.
    TodoItem *item = [[self alloc] init];
    item.title = title;
    return item;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = @"";
    }
    return self;
}

#pragma mark - Custom Description

-(NSString *)description
{
    return [NSString stringWithFormat: @"<%@: %@>", self.className,  self.title];
}

@end
