//
//  CommentDetailsViewController.m
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/12/3.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import "CommentDetailsViewController.h"
#import "arrayDataSource.h"
static NSString *const cellIdentifier = @"cell";
@interface CommentDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)arrayDataSource *tableDataSource;
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation CommentDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    configureCellBlock cellBlock = ^(id cell,id items){
        
    };
    self.tableDataSource = [[arrayDataSource alloc]initWithCellBlock:cellBlock withArray:self.dataArray withCellIdentifier:cellIdentifier];
    self.CommentDetailsTableView.delegate = self;
    self.CommentDetailsTableView.dataSource = self.tableDataSource;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
