//
//  arrayDataSource.m
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/12/2.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import "arrayDataSource.h"
#import "fourTableViewCell.h"
@interface arrayDataSource ()
@property(nonatomic, copy)NSArray *itemArray;
@property(nonatomic, copy)NSString *identifier;
@property(nonatomic, copy)configureCellBlock cellBlock;
@end
@implementation arrayDataSource

-(id)initWithCellBlock:(configureCellBlock)block withArray:(NSArray *)items withCellIdentifier:(NSString *)cellIdenfier
{
    self = [super init];
    if (self) {
        self.cellBlock = block;
        self.itemArray = items;
        self.identifier = cellIdenfier;
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    fourTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:self.identifier];
    if (cell == nil) {
        cell = [[fourTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.identifier];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(id)numberOfItemswithIndex:(NSIndexPath *)indexPath
{
    return self.itemArray[indexPath.row];
}

@end
