//
//  ViewController.m
//  ckl8-hw3-todolist
//
//  Created by rlam on 3/10/15.
//  Copyright (c) 2015 rlam. All rights reserved.
//

#import "ViewController.h"
#import "TodoItem.h"
#import "TodoList.h"
@interface ViewController () <NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate>
@property (weak) IBOutlet NSButtonCell *allowDuplicate;
@property (weak) IBOutlet NSButton *addItem;
@property (weak) IBOutlet NSButtonCell *removeItem;
@property (weak) IBOutlet NSTextField *inputItem;
@property (weak) IBOutlet NSTableView *ToDoTableView;
@property (strong, nonatomic) TodoList *list;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ToDoTableView.delegate = self;
    self.ToDoTableView.dataSource = self;
    
    // Do any additional setup after loading the view.
}

//-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
//{
//    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"TableCell" owner:nil];
//    return cell;
//}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
-(void)viewDidAppear
{
    [super viewDidAppear];
    [self updateInterface];
//    self.view.window.title = _list.title;
}

-(void)updateInterface
{
    self.allowDuplicate.state = self.list.allowsDuplication;
    TodoItem *currentItem = [self todoItemFromCurrentInput];
    self.addItem.enabled = [self.list canAddItem:currentItem];
    self.removeItem.enabled = [self.list canRemoveItem:currentItem];
//    self.view.window.title = self.list.title;
    
}

-(TodoItem*)todoItemFromCurrentInput
{
    return [TodoItem todoItemWithTitle:self.inputItem.stringValue];
}




#pragma mark - Property Overrides

-(void)setList:(TodoList *)list
{
    _list = list;
    [self updateInterface];
    [self.ToDoTableView reloadData];
}



#pragma mark - Actions

- (IBAction)clickedAddButton:(id)sender
{
    [self tryToInsertNewItem];
}

- (IBAction)clickedRemoveButton:(id)sender
{
    TodoItem *item = [self todoItemFromCurrentInput];
    if ([self.list canRemoveItem:item]) {
        [self.list removeItem:item];
        
        // update table view
        [self.ToDoTableView reloadData];
        
        // clear text input
        self.inputItem.stringValue = @"";
    }
    
    [self updateInterface];
}

- (IBAction)clickedDuplicatesButton:(id)sender
{
    self.list.allowsDuplication = !self.list.allowsDuplication;
    [self updateInterface];
}

-(void)tryToInsertNewItem
{
    TodoItem *item = [self todoItemFromCurrentInput];
    if ([self.list canAddItem:item]) {
        [self.list addItem:item];
        
        // update table view
        NSUInteger nextRow = self.ToDoTableView.numberOfRows;
        NSIndexSet *nextRowSet = [NSIndexSet indexSetWithIndex:nextRow];
        [self.ToDoTableView insertRowsAtIndexes:nextRowSet withAnimation:NSTableViewAnimationSlideDown];
        
        // clear text input
        self.inputItem.stringValue = @"";
    }
    
    [self updateInterface];
    
}




#pragma mark - NSTextFieldDelegate

-(void)controlTextDidChange:(NSNotification *)obj
{
    if (obj.object == self.inputItem) {
        [self updateInterface];
    }
}

-(void)controlTextDidEndEditing:(NSNotification *)obj
{
    if (obj.object == self.inputItem) {
        [self tryToInsertNewItem];
    }
}




#pragma mark - NSTableViewDataSource, NSTableViewDelegate

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.list itemCount];
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"TableCell" owner:nil];
    TodoItem *item = self.list.allItems[row];
    cellView.textField.stringValue = item.title;
    return cellView;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    if (row % 2 == 0) {
        return 50;
    } else {
        return 100;
    }
}



@end
