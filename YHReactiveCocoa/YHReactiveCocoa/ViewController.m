//
//  ViewController.m
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/11/28.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import "ViewController.h"
#import "CaculatorMaker.h"
#import "NSObject+Cacultor.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor yellowColor];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark --RAC RACSignal
    //1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //2.发送信号
        [subscriber sendNext:@1];
        //如果不再发送数据，最好结束发送信号完成，内部自动调用[RACDisposable disposable]取消订阅
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
           //当信号发送完成或出现错误。就会自动执行，取消订阅信号。
            //执行完成当前信号就会被销毁，不再被订阅
        }];
    }];
    //3.订阅信号  才会激活信号
    [signal subscribeNext:^(id x) {
       //每当有信号发出数据就会调用此block
        
    }];
    
#pragma mark --RACSubject与RACReplaySubject
    //创建信号
    RACSubject *subject = [RACSubject subject];
    //订阅信号
    [subject subscribeNext:^(id x) {
       //当信号发出新值，就会调用
        //第一个订阅者
    }];
    [subject subscribeNext:^(id x) {
        //第二个订阅者
    }];
    //发送信号
    [subject sendNext:@"1"];
    
    ////////RACReplaySubject/////
    //1.创建信号[RACReplaySubject subject]
    //2.可以先订阅信号，也可以先发送信号
 
    RACReplaySubject *rePlaySubject = [RACReplaySubject subject];

    //发送信号
    [rePlaySubject sendNext:@"1"];
    [rePlaySubject sendNext:@"2"];
    //   //订阅信号
    [rePlaySubject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    [rePlaySubject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
//    [rePlaySubject subscribeNext:^(id x) {
//        NSLog(@"第三个订阅者接收到的数据%@",x);
//    }];
    

    
}
#pragma mark --RACSubject替换代理
//需求
//1，给当前控制器添加一个按钮。莫泰到另一个控制器界面
//2. 另一个控制器中有个按钮，点击按钮，通知当前控制器
-(void)touch:(UIButton *)sender{
    //创建第二个控制器
    SecondViewController *second = [[SecondViewController alloc]init];
    //设置代理信号
    second.delegateSignal  = [RACSubject subject];
    //订阅代理信号
    [second.delegateSignal subscribeNext:^(id x) {
        NSLog(@"点击了通知按钮");
        NSLog(@"%@",x);
    }];
    //跳转控制器
    [self presentViewController:second animated:YES completion:^{
        
    }];
    
    
}
//模仿masonry实现简单计算器(链式编程思想)
-(void)testMaker{
    int result = [NSObject makeCaculators:^(CaculatorMaker *make) {
        make.add(2).add(3).add(5);
    }];
    
    int resultsub = [NSObject makeCaculators:^(CaculatorMaker *make) {
        make.sub(10).sub(4);
    }];
    NSLog(@"%d",result);
    NSLog(@"%d",resultsub);
    int resultmutile = [NSObject makeCaculators:^(CaculatorMaker *make) {
        make.muilt(10).add(10);
    }];
    NSLog(@"%d",resultmutile);
    int resultdivide = [NSObject makeCaculators:^(CaculatorMaker *make) {
        make.add(30).muilt(10).divide(10).muilt(5);
    }];
    NSLog(@"%d",resultdivide);
}
//模拟函数式编程
-(void)test{
    //    CaculatorMaker *maker = [[CaculatorMaker alloc]init];
    //    BOOL isQule = [[[maker caculator:^void(int result) {
    //        result +=2;
    //        result *=5;
    //        return result;
    //    }] equle:^BOOL(int result) {
    //        return result == 110;
    //    }]isEqule];
    //    NSLog(@"%d",isQule);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
