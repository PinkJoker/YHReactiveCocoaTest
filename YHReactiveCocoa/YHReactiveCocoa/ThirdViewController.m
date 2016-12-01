//
//  ThirdViewController.m
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/11/30.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import "ThirdViewController.h"

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
