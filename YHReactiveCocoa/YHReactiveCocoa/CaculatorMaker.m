//
//  CaculatorMaker.m
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/11/28.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

- (CaculatorMaker *(^)(int))add
{
    return ^CaculatorMaker *(int value){
        _result +=value;
        return self;
    };
}

-(CaculatorMaker *(^)(int))sub
{
    return ^CaculatorMaker *(int value){
        _result -=value;
        return self;
    };
}
- (CaculatorMaker *(^)(int))muilt
{
    return ^CaculatorMaker *(int value){
        _result *=value;
        return self;
    };
}

- (CaculatorMaker *(^)(int))divide
{
    return ^CaculatorMaker *(int value){
        _result /=value;
        return self;
    };
}

@end
