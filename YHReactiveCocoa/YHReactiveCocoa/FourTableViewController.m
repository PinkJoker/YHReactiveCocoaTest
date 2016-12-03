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
    self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self creatTableView];
}

-(void)creatTableView
{
    [self getDataFromViewModal];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64) style:UITableViewStyleGrouped];
}

-(void)getDataFromViewModal
{
    RACSignal *signal = [self.RequestViewModal.requestCommand execute:nil];
    [signal subscribeNext:^(id x) {
        self.dataArray = [x copy];
        configureCellBlock block = ^(fourTableViewCell *myCell,fourModal *modal){
            [myCell setModal:modal];
        };
        self.tableDataSource = [[arrayDataSource alloc]initWithCellBlock:block withArray:self.dataArray withCellIdentifier:@"datacell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self.tableDataSource;
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
        });
       
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:kWidth tableView:self.tableView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    fourModal *modal = self.dataArray[indexPath.row];
    if (self.tableSubject) {
        [self.tableSubject sendNext:modal.commentcontent];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(fourViewModal *)RequestViewModal
{
    if (!_RequestViewModal) {
        NSDictionary *dic = @{@"newsid":@"1",@"usersession":@"",@"page":@"1",@"pagecount":@"20"};
        NSString *str = @"http://a.zkuaiji.cn/30/3012";
        _RequestViewModal = [[fourViewModal alloc]initWithDic:dic withURLStr:str];
    }
    return _RequestViewModal;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
