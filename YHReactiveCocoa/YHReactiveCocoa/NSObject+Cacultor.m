//
//  NSObject+Cacultor.m
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/11/28.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import "NSObject+Cacultor.h"
#import "CaculatorMaker.h"

@implementation NSObject (Cacultor)

+(int)makeCaculators:(void (^)(CaculatorMaker *))caculatorMaker
{
    CaculatorMaker *manager = [[CaculatorMaker alloc]init];
    caculatorMaker(manager);
    return manager.result;
}

@end
