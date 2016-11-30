//
//  SecondViewController.m
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/11/29.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import "SecondViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "racModal.h"
@interface SecondViewController ()
{
    NSMutableArray *_itemArray;
}
//强引用命令，不要被销毁，否则接收不到数据
@property(nonatomic, strong)RACCommand *_command;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor yellowColor];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"这是Second的按钮" forState:UIControlStateNormal];

    
#pragma mark --RACSequence 
    //RAC中的集合类，用于代理NSArray,NSdictionary，可以用来快速便利数组和字典
    //1.字典转模型
    
       //1.便利数组
        //三个步骤
    //1.把数组装换成集合RACSequence array.rac_sequence
    //2.把集合RACSequence转换成RACSignal信号类
    //3.订阅信号，激活信号。自动把集合中的所有值便利
    NSArray *array = @[@"1",@"3",@"5",@"6",@"7",@"8",@"9"];
    [array.rac_sequence.signal subscribeNext:^(id x) {
       //订阅信号
    //    NSLog(@"%@",x);
    }];
    
    //2.便利字典,便利出来的键值对会包装秤RACTuple(元组对象)
    NSDictionary *dic = @{@"a":@"s",@"d":@"f",@"3":@"t"};
    [dic.rac_sequence.signal subscribeNext:^(id x) {
       //解包元组，会把元组的值，按照顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        //作用同上
//        NSString *key = x[0];
//        NSString *value = x[1];
        
     //   NSLog(@"%@====%@",key,value);
        
    }];
    
    //3,字典转模型
    NSMutableArray *dicArray = [NSMutableArray arrayWithObject:dic];
//    [dicArray addObject:dic];
    NSMutableArray *itemArray = [NSMutableArray array];
    _itemArray = itemArray;
    //rac_sequence 注意点:调用subscribeNext,并不会马上执行Nextblock，而是会等一会
    [dicArray.rac_sequence.signal subscribeNext:^(id x) {
        //运用RAC便利字典 x:字典
        
        
    }];
    
#pragma mark --字典转模型 RAC高级
    NSArray *flagsItem = [dicArray copy];
    //map：映射的意思,目的  把原始值value映射成一个新值
    //array:把集合转换成数组
    //底层实现:当信号被订阅，会便利集合中的原始值，映射成新值，并且保存到新的数组里
    NSArray *flags = [[flagsItem.rac_sequence map:^id(id value) {
   
        return  nil;
    }] array];
    
#pragma mark --RACCommand :用于处理事件的类
//可以把时间如何处理，事件中的数据如何传递，包装到这个类 ，可以方便监控事件的执行过程
    //使用步骤
    //1.创建命令
    //2.在signalBlock中，创建RACSignal并且作为signalblock的返回值
    //3.执行命令  - (RACSignal *)execute:(id)input
    //使用注意
    //1.signalBlock必须返回一个信号，不能传nil
    //2.如果不想要传递信号，直接创建空的信号[RACSignal empty]
    //3.RACCommand中信号如果数据传递完成，必须调用[subscriber sendCompleted] ，这时命令才会执行完毕，否则将永远处于执行中
    //4.RACCommand需要被强引用。否则接收不到RACCommand中的信号。因此RACCommand中的信号是延迟发送的
    //设计思想
    //1.在RAC开法中，通常会把网络请求封装到RACCommand,直接执行某个RACConmand就能发送请求
    //2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalblock返回的信号传递
    //如何拿到RACCommand中返回信号发出的数据
    //1.RACCommand有个执行信号源executionSignals,这个是signal of signals（信号的信号）,意思就是信号发出的数据是信号，不是普通的类型
    //2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalblock返回的信号
    //监听当前命令是否正在执行executing
    //使用场景，监听按钮点击，网络请求
    
    ///1.创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
     //创建空信号  必须返回信号
//        return [RACSignal empty];
        //2.创建信号用来传递数据
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"请求数据"];
            //当完成数据请求，要调用sendCompleted,表示命令执行完毕，否则将永远处于执行中
          //  [subscriber sendCompleted];
            return nil;
        }];
        
    }];

    //强引用命令，不要被销毁，否则接收不到数据
//    __strong __typeof(command)_command = command;
    __command = command;
    //3.订阅RACCommand中的信号
    [__command.executionSignals subscribeNext:^(id x) {
       [x subscribeNext:^(id x) {
           NSLog(@"----------%@--------",x);
       }];
    }];
    //执行命令
    [__command execute:@"2"];
    //普通做法调用
    [self commandOne];
    //一般做法
    [self commandTwo];
    //高级
    [self commandThree];
    //swichtolasted
    [self commandFour];

    
}
#pragma mark --RACCommand五种做法
//普通做法
-(void)commandOne{
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"网络请求"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    RACSignal *signal = [command execute:@"1"];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//
-(void)commandTwo{
    RACCommand *command =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        //input 为执行命令传进来的参数
       return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           [subscriber sendNext:@"执行命令产生的数据"];
           [subscriber sendCompleted];
           return nil;
       }];
    }];
    //这里必须县订阅才能发送命令
    //executionSignals :信号源，信号中信号。发送的数据就是信号
    [command.executionSignals subscribeNext:^(RACSignal *x) {
        [x subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }];
    //执行命令
    [command execute:@2];
}
//高级
-(void)commandThree{
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@1];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [command execute:@2];
    
}
//swichtoLasted(没能获取到信号)
#pragma mark --没有正确获取到信号 （未完成）
-(void)commandFour{
    //创建信号中的信号
    RACSubject *signalofsignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    //订阅信号
//    [signalofsignals subscribeNext:^(id x) {
//       [x subscribeNext:^(id x) {
//           NSLog(@"%@",x);
//       }];
//    }];
    //获取信号中信号发送的最新信号
    [signalofsignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    //发送信号
    [signalofsignals sendNext:signal];
  //  [signal sendNext:@4];
}



//RACSubject模拟代理
-(void)touchButton:(UIButton *)sender
{
    //通知第一个控制器，按钮被点击
    //判断代理信号时候有值
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:sender.titleLabel.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
