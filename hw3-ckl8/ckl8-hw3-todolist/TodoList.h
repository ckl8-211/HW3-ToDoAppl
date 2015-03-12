//
//  PCETodoList.h
//  UWTodoApp
//
//  Created by Martin Nash on 7/8/14.
//  Copyright (c) 2014 Martin Nash (UW). All rights reserved.
//

#import <Foundation/Foundation.h>


@class TodoList;
@class TodoItem;

@interface TodoList : NSObject

@property (assign) BOOL allowsDuplication;
@property (copy, nonatomic) NSString *title;

-(instancetype)initWithTitle:(NSString*)title;

// wrapper around array
-(void)addItem:(TodoItem*)item;
-(void)removeItem:(TodoItem*)item;


-(BOOL)canAddItem:(TodoItem*)item;
-(BOOL)canRemoveItem:(TodoItem*)item;

// Quick add and remove
-(void)addItemWithTitle:(NSString*)title;
-(void)removeItemWithTitle:(NSString*)title;
-(BOOL)canAddItemWithTitle:(NSString *)title;
-(BOOL)canRemoveItemWithTitle:(NSString*)title;
-(BOOL)hasItemWithTitle:(NSString*)title;

-(NSArray*)itemTitles;
//-(NSArray*)allItems;
@property (readonly) NSArray* allItems;
-(NSUInteger)itemCount;



@end
