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
        make.height.mas_equalTo(20);
    }];
    
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
