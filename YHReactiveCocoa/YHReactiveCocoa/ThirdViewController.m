//
//  ThirdViewController.m
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/11/30.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import "ThirdViewController.h"
//#import <ReactiveCocoa/racre>
#import "RequestModal.h"
@interface ThirdViewController ()
@property(nonatomic, strong)AFHTTPSessionManager *sessionManager;
@end

@interface ThirdViewController ()<UITextFieldDelegate>
{
    UITextField *_textField;
}

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _textField = [[UITextField alloc]init];
    [self.view addSubview:_textField];
    _textField.delegate = self;
    _textField.backgroundColor = [UIColor yellowColor];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(50);
    }];
    
    _testLabel = [[UILabel alloc]init];
    [self.view addSubview:_testLabel];
    [_testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_textField.mas_bottom).offset(30);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(30);
    }];
    _testLabel.backgroundColor = [UIColor blackColor];
    _testLabel.textColor = [UIColor whiteColor];
    
    // -ignore:(id)  忽略给定的值，既可以是地址相同的对象  也可以是相同的值
    [[_textField.rac_textSignal ignore:@"Joker"]subscribeNext:^(id x) {
        
    }];
#pragma mark --RAC(T,P) 与signal的绑定
    //将输入框的输入信号绑定到testLabel的text上
    //1.
  //  RAC(self.testLabel,text) = _textField.rac_textSignal;
    //2.
    //startwith"  一开始返回的初始值
    //return 当filter满足条件value.length>3条件之后才能传出
//    RAC(self.testLabel,text) = [[_textField.rac_textSignal startWith:@""]filter:^BOOL(NSString *value) {
//        return value.length >3;
//    }];
//    //3.
//    RAC(self.testLabel,text) = [_textField.rac_textSignal filter:^BOOL(NSString * value) {
//        return value.length >5;
//    }];
    //4.map:         当输入joker时显示输入正确
    RAC(self.testLabel,text) = [[[_textField.rac_textSignal startWith:@""]filter:^BOOL(NSString *value) {
        return value.length >3;
    }]map:^id(NSString *value) {
        return [value isEqualToString:@"Joker"] ?@"bingo!":value;
    }];
#pragma mark --  -take:
    //-take:(NSUInteger)
    //从开始一共取N次next值
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"1"];
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@3];
        return [RACDisposable disposableWithBlock:^{
            return [subscriber sendCompleted];
        }];
    }]take:2]subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    //-takeUntilBlock:(BOOL(^)(id x))
    //对于每个next值，运行block 当block返回YES时停止取值
    [[_textField.rac_textSignal takeUntilBlock:^BOOL(NSString* x) {
        return [x isEqualToString:@"stop"];
    }]subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //-takeLast:(NSUInteger)
    //取最后N次的next值，注意，由于一开始不能知道这个Signal将有多少个next值，所以RAC实现它的方法是将所有next值都存起来，然后原Signal完成时再将后N个依次发送给接收者，但Error发生时依然是立刻发送的
    //-take
    [[[_textField rac_signalForControlEvents:UIControlEventEditingChanged]map:^id(UITextField *value) {
        return value.text;
    }]takeUntil:_textField.rac_willDeallocSignal];
    //-takeUntil:(RACSignal *)
    //在给定的signal完成前一直取值
    
    //-takeWhileBlock:(BooL(^)(id x))
    //对于每个next值 ，block返回YES时才取值
#pragma mark --  -skip
    // -skip:(NSUInteger)
    //从开始跳过N次的next值，简单的例子
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"1"];
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@"3"];
        [subscriber sendCompleted];
        return nil;
    }]skip:1]subscribeNext:^(id x) {
        NSLog(@"回跳过第一个输入%@",x);
    }];
    // -skipUntilBlock:(BOOL (^)(id x))
    //同-takeuntil  一直跳过知道block为YES
    
    //-skipWhileBlock:(BOOL(^)(id x))
    //同-takewhile  一直跳过，知道block为NO
    
#pragma mark --TestRequest
    //http://a.zkuaiji.cn/20/2002
    self.sessionManager = [AFHTTPSessionManager manager];
//    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    RACSignal *fetchData = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        NSURLSessionDataTask *task = [self.sessionManager POST:@"http://a.zkuaiji.cn/20/2002" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@",responseObject);
//            [subscriber sendNext:responseObject];
//            [subscriber sendCompleted];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [subscriber sendError:error];
//        }];
//        return [RACDisposable disposableWithBlock:^{
//            if (task.state != NSURLSessionTaskStateCompleted) {
//                [task cancel];
//            }
//        }];
//        
//    }];
//    
//    RACSignal *title = [fetchData flattenMap:^RACStream *(id value) {
//        if ([value[@"title"] isKindOfClass:[NSString class]]) {
//            
//            
//            return [RACSignal return:value[@"title"]];
//        }else{
//            return [RACSignal error:[NSError errorWithDomain:@"some error" code:400 userInfo:@{@"originData":value}]];
//        }
//    }];
//    RACSignal* desc = [fetchData flattenMap:^RACStream *(id value) {
//        if ([value[@"introduction"] isKindOfClass:[NSString class]]) {
//            return [RACSignal return:value[@"introduction"]];
//        }else{
//            return [RACSignal error:[NSError errorWithDomain:@"some error" code:400 userInfo:value]];
//        }
//    }];
//   // UILabel *label = [[UILabel alloc]init];
//    RAC(_textField,text) = [[title catchTo:[RACSignal return:@"Error"]] startWith:@"Load..."];
//    RAC(_testLabel,text) = [[desc catchTo:[RACSignal return:@"Error"]]startWith:@"Load..."];
//    
//    [[RACSignal merge:@[title]] subscribeError:^(NSError *error) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:error.domain delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alertView show];
//    }];
//    
    
    
    
//    RACSignal *renderedDesc = [desc flattenMap:^RACStream *(id value) {
//        NSError *error = nil;
//        if (error) {
//            return [RACSignal error:error];
//        }error{
//            return [RACSignal return:<#(id)#>]
//        }
//    }];

    
    
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@,%@",textField.text,string);
    return YES;
}

//练习RAC传值
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.delegateSubject) {
        [_textField.rac_textSignal subscribeNext:^(id x) {
            if (self.delegateSubject) {
                [self.delegateSubject sendNext:x];
                [self.delegateSubject sendCompleted];
            }
        }];
        [self dismissViewControllerAnimated:YES completion:^{
           
            
        }];
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
