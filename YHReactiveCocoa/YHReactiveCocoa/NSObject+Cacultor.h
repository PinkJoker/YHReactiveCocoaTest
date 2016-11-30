//
//  NSObject+Cacultor.h
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/11/28.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CaculatorMaker;
@interface NSObject (Cacultor)
//计算
+(int)makeCaculators:(void(^)(CaculatorMaker *make))caculatorMaker;
@end
