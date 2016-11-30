//
//  CaculatorMaker.h
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/11/28.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorMaker : NSObject
#pragma mark --链式编程
@property(nonatomic, assign) int result;
#pragma mark --链式编程模拟加法计算器
- (CaculatorMaker *(^)(int))add;
- (CaculatorMaker *(^)(int))sub;
- (CaculatorMaker *(^)(int))muilt;
- (CaculatorMaker *(^)(int))divide;
#pragma mark --函数是编程
@property(nonatomic, assign)BOOL isEqule;
@property(nonatomic, assign)int hsResult;

- (CaculatorMaker *)caculator:(void(^)(int result))caculator;

- (CaculatorMaker *)equle:(BOOL (^)(int result))operation;


@end
