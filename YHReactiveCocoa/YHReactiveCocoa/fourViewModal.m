//
//  fourViewModal.m
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/12/2.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import "fourViewModal.h"
#import "fourModal.h"
@implementation fourViewModal


-(instancetype)init
{
    self = [super init];
    if (self) {
        [self getData];
    }
    return self;
}

-(void)getData
{
    self.requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           [[AFHTTPSessionManager manager]POST:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               NSLog(@"发送成功");
               self.dataArray = [fourModal mj_objectArrayWithKeyValuesArray:responseObject[@"results"]];
               [subscriber sendNext:self.dataArray];
               
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               NSLog(@"请求失败");
           }];
            return nil;
            
        }];
        return signal;
    }];
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
