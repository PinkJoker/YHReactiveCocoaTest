//
//  fourViewModal.h
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/12/2.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fourViewModal : NSObject
@property(nonatomic, strong)RACCommand *requestCommand;
@property(nonatomic,copy)NSMutableArray *dataArray;
@end
