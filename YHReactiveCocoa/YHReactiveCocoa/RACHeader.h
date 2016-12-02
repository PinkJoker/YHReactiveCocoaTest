//
//  RACHeader.h
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/12/1.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#ifndef RACHeader_h
#define RACHeader_h

//#define RAC(TARGET,[KEYPATH,[NIL_VALUE]]) //用于给某个对象的某个属性绑定
//#define RACObserve(self,name)//监听某个对象的某个属性 返回的是信号
#define kWidth     [UIScreen mainScreen].bounds.size.width
#define kHeight   [UIScreen mainScreen].bounds.size.height
#define weakObj(obj,R)    __weak __typeof(obj)R = obj;
#define strongObj(obj,R) __strong __typeof(obj)R = obj;
#endif /* RACHeader_h */
