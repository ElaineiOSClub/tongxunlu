//
//  RegisterViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/11.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;

//账号
@property (nonatomic, strong) UITextField *A_AccountField;
//密码
@property (nonatomic, strong) UITextField *A_PasswordField;
//用户姓名
@property (nonatomic, strong) UITextField *U_NameField;
//性别
@property (nonatomic, strong) UITextField *U_SexField;
//生日
@property (nonatomic, strong) UITextField *U_BirthdayField;
//联系电话
@property (nonatomic, strong) UITextField *U_PhoneField;
//班级
@property (nonatomic, strong) UITextField *C_NameField;
//学校
@property (nonatomic, strong) UITextField *C_SchoolField;
//用户地址
@property (nonatomic, strong) UITextField *U_AdressField;
//QQ
@property (nonatomic, strong) UITextField *U_QQField;
//微信号
@property (nonatomic, strong) UITextField *U_WeChatField;
//邮箱
@property (nonatomic, strong) UITextField *U_EmailField;
//职业
@property (nonatomic, strong) UITextField *U_JobField;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    
}


- (void)addUI
{
    
}


#pragma mark - lazy
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
    }
    return _scrollView;
}
//账号
- (UITextField *)A_AccountField
{
    if (!_A_AccountField) {
        
    }
    return _A_AccountField;
}
//密码
- (UITextField *)A_PasswordField
{
    if (!_A_PasswordField) {
        
    }
    return _A_PasswordField;
}

//用户姓名
- (UITextField *)U_NameField
{
    if (!_U_NameField) {
        
    }
    return _U_NameField;
}

//性别
- (UITextField *)U_SexField
{
    if (!_U_SexField) {
        
    }
    return _U_SexField;
}

//生日
- (UITextField *)U_BirthdayField
{
    if (!_U_BirthdayField) {
        
    }
    return _U_BirthdayField;
}

//联系电话
- (UITextField *)U_PhoneField
{
    if (!_U_PhoneField) {
        
    }
    return _U_PhoneField;
}

//用户地址
- (UITextField *)U_AdressField
{
    if (!_U_AdressField) {
        
    }
    return _U_AdressField;
}
//学校
- (UITextField *)C_SchoolField
{
    if (!_C_SchoolField) {
        
    }
    return _C_SchoolField;
}

//班级
- (UITextField *)C_NameField
{
    if (!_C_NameField) {
        
    }
    return _C_NameField;
}
//QQ
- (UITextField *)U_QQField
{
    if (!_U_QQField) {
        
    }
    return _U_QQField;
}

//微信号
- (UITextField *)U_WeChatField
{
    if (!_U_WeChatField) {
        
    }
    return _U_WeChatField;
}

//邮箱
- (UITextField *)U_EmailField
{
    if (!_U_EmailField) {
        
    }
    return _U_EmailField;
}

//职业
- (UITextField *)U_JobField
{
    if (!_U_JobField) {
        
    }
    return _U_JobField;
}







@end
