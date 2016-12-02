//
//  FourTableViewController.m
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/12/2.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import "FourTableViewController.h"
#import "arrayDataSource.h"
#import "fourTableViewCell.h"
#import "fourViewModal.h"
#import "fourModal.h"
@interface FourTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)arrayDataSource *tableDataSource;
@property(nonatomic, copy)NSMutableArray *dataArray;
@property(nonatomic, strong)fourViewModal *RequestViewModal;
@property(nonatomic, strong)fourModal *modal;
@end

@implementation FourTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self getDataFromViewModal];
    configureCellBlock block = ^(fourTableViewCell *myCell,fourModal *modal){
//        [myCell ]
    };
    self.tableDataSource = [[arrayDataSource alloc]initWithCellBlock:block withArray:self.dataArray withCellIdentifier:@"datacell"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.tableDataSource;
    
}

-(void)getDataFromViewModal
{
    RACSignal *signal = [self.RequestViewModal.requestCommand execute:nil];
    [signal subscribeNext:^(id x) {
        self.dataArray = x;
        [self.tableView reloadData];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
