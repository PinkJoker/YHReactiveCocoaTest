//
//  SecondViewController.h
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/11/29.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSubject;
@interface SecondViewController : UIViewController
//添加RACSubject替换代理
@property(nonatomic, strong)RACSubject *delegateSignal;

@end
