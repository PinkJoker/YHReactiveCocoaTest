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


-(instancetype)initWithDic:(NSDictionary *)dict withURLStr:(NSString *)str
{
    self = [super init];
    if (self) {
        [self getDataWithDic:dict withURLStr:str];
    }
    return self;
}

-(void)getDataWithDic:(NSDictionary *)dict withURLStr:(NSString *)str
{
    self.requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           [[AFHTTPSessionManager manager]POST:str parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               self.dataArray = [fourModal mj_objectArrayWithKeyValuesArray:responseObject[@"results"]];
               [subscriber sendNext:self.dataArray];
               [subscriber sendCompleted];
               NSLog(@"发送成功");
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
