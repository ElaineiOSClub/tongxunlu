//
//  RegistersViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/12.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "RegistersViewController.h"
#import "NSString+Extension.h"
#import "HttpTool.h"
#import "MBProgressHUD.h"

@interface RegistersViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UITextField *A_AccountField;
@property (weak, nonatomic) IBOutlet UITextField *A_PasswordField;
@property (weak, nonatomic) IBOutlet UITextField *U_NameField;
@property (weak, nonatomic) IBOutlet UITextField *U_SexField;
@property (weak, nonatomic) IBOutlet UITextField *U_BirthdayField;
@property (weak, nonatomic) IBOutlet UITextField *U_PhoneField;
@property (weak, nonatomic) IBOutlet UITextField *S_SchoolNameField;
@property (weak, nonatomic) IBOutlet UITextField *C_NameField;
@property (weak, nonatomic) IBOutlet UITextField *provincecityField;
@property (weak, nonatomic) IBOutlet UITextField *U_AdressField;
@property (weak, nonatomic) IBOutlet UITextField *U_JobField;
@property (weak, nonatomic) IBOutlet UITextField *U_QQField;
@property (weak, nonatomic) IBOutlet UITextField *U_WeChatField;
@property (weak, nonatomic) IBOutlet UITextField *U_EmailField;


@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewTop;


@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *sexPicker;
@property (nonatomic, strong) UIPickerView *cityPicker;
@property (nonatomic, strong) UIPickerView *classPicker;

//选中的textField
@property (nonatomic, strong) UITextField *selectField;
@property (nonatomic, strong) NSArray *sexList;

//省市数据
@property (nonatomic, strong) NSArray *provinceList;
@property (nonatomic, strong) NSArray *cityList;
@property (nonatomic, copy) NSString *provinceID;
@property (nonatomic, copy) NSString *cityID;
//班级数据
@property (nonatomic, strong) NSArray *classList;
@property (nonatomic, copy) NSString *classID;//选择的班级ID

@end

@implementation RegistersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sexList = @[@"男",@"女"];
    self.U_BirthdayField.inputView = self.datePicker;
    self.U_SexField.inputView = self.sexPicker;
    self.provincecityField.inputView = self.cityPicker;
    self.C_NameField.inputView = self.classPicker;
    
    self.registerBtn.layer.cornerRadius = 4;
    
 

    
}



#pragma mark - event response

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    //日期数值变化后，显示在文本控件中
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    //日期格式
    self.U_BirthdayField.text = [formatter stringFromDate:datePicker.date];
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  键盘阿生改变时调用
 *
 *  @param notification
 */
- (void)KeyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    //键盘的frame
    CGRect frame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //键盘动画持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //转换坐标系
    CGRect newRect = [self.selectField.superview convertRect:self.selectField.frame toView:self.view];
    MLog(@"%@",NSStringFromCGRect(newRect));

    [UIView animateWithDuration:duration animations:^{
      self.scrollViewBottom.constant = kScreenH- frame.origin.y;
    }];
}



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.selectField = textField;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //判断是否注册：action=Check&Account=账户参数
    //允许注册返回 {\"CheckMes\":\"yes\"} 已注册返回{\"CheckMes\":\"no\"}
    
    if (textField != self.A_AccountField) {
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/UserService.ashx",KUrl];
    
    [HttpTool httpToolPost:urlStr parameters:@{@"action":@"Check",@"Account":textField.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"CheckMes"] isEqualToString:@"no"]) {
            [self alertWithStr:@"用户名已存在"];
            [textField becomeFirstResponder];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}


#pragma mark - UIPickerDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self.sexPicker) {
        return 1;
    } else if(pickerView == self.classPicker) {
        return 1;
    } else {
        return 2;
    }
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.sexPicker) {
        return 2;
    } else if (pickerView == self.classPicker) {
        return self.classList.count;
    } else {
        if (component == 0) {
            return self.provinceList.count;
        } else {
            NSInteger row = [pickerView selectedRowInComponent:0];
            NSDictionary *provinceDict = self.provinceList[row];
            NSString *provinceID = provinceDict[@"PR_Id"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CT_Province == %@",provinceID];
            NSArray *cityList = [self.cityList filteredArrayUsingPredicate:predicate];
            
            return cityList.count;
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    if (pickerView == self.sexPicker) {
        return self.sexList[row];
    } else if(pickerView == self.classPicker) {
        return self.classList[row][@"name"];
    }else {
        if (component == 0) {
            NSDictionary *provinceDict = self.provinceList[row];
             MLog(@"%@",provinceDict[@"PR_Name"]);
            return provinceDict[@"PR_Name"];
        }
        else {
//            NSInteger rows = [pickerView selectedRowInComponent:0];
//            NSDictionary *provinceDict = self.provinceList[rows];
//            NSString *provinceID = provinceDict[@"PR_Id"];
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CT_Province == %@",provinceID];
//            NSArray *cityList = [self.cityList filteredArrayUsingPredicate:predicate];
//            MLog(@"%@",cityList[row][@"CT_Name"]);
//            return cityList[row][@"CT_Name"];
            return @"11";
        }
    }
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.sexPicker) {
        self.U_SexField.text = self.sexList[row];
    } else if (pickerView == self.classPicker) {
        self.C_NameField.text = self.classList[row][@"name"];
        self.classID = self.classList[row][@"id"];
    } else {
        if (component == 0) {
            NSDictionary *provinceDict = self.provinceList[row];
            NSString *provinceID = provinceDict[@"PR_Id"];
            self.provinceID = provinceID;
            NSString *provinceName = provinceDict[@"PR_Name"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CT_Province == %@",provinceID];
            NSArray *cityList = [self.cityList filteredArrayUsingPredicate:predicate];
            
            
            NSInteger rows = [pickerView selectedRowInComponent:1];
            NSString *cityName = cityList[rows][@"CT_Name"];
            self.cityID = cityList[rows][@"CT_Id"];
            
            self.provincecityField.text = [NSString stringWithFormat:@"%@%@",provinceName,cityName];
            [pickerView reloadComponent:1];
        } else {
            NSInteger rows = [pickerView selectedRowInComponent:0];
            NSDictionary *provinceDict = self.provinceList[rows];
            NSString *provinceID = provinceDict[@"PR_Id"];
            NSString *provinceName = provinceDict[@"PR_Name"];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CT_Province == %@",provinceID];
            NSArray *cityList = [self.cityList filteredArrayUsingPredicate:predicate];
            NSString *cityName = cityList[row][@"CT_Name"];
            self.cityID = cityList[rows][@"CT_Id"];
            
            self.provincecityField.text = [NSString stringWithFormat:@"%@%@",provinceName,cityName];
            
        }
    }
}

- (IBAction)registerClick:(id)sender {
    
    if (self.U_QQField.text.length == 0) {
        self.U_QQField.text = @"";
    }
    if (self.U_WeChatField.text.length == 0) {
        self.U_WeChatField.text = @"";
    }
    if (self.U_EmailField.text.length == 0) {
        self.U_EmailField.text = @"";
    }
    
    
    
    //用户名不能为空
    //1.创建正则表达式
    NSString *pattern = @"^[a-zA-Z][a-zA-Z0-9_]{5,17}$";
    
    //先判断用户名
    if (![self predicate:pattern withStr:self.A_AccountField.text]) {
        [self alertWithStr:@"用户名必须6-18字符,字母开头,只能包含字母,数字,下划线"];
        return;
    }
    pattern = @"^[a-zA-Z0-9_]{5,19}$";
    //判断密码
    if (![self predicate:pattern withStr:self.A_PasswordField.text]) {
        [self alertWithStr:@"密码必须6-20字符,只能包含字母,数字,下划线"];
        return;
    }
    
    //判断姓名
    if ([self.U_NameField.text containsStringWithios7:@" "] || [self.U_NameField.text isEqualToString:@""]) {
        [self alertWithStr:@"姓名不能为空"];
        return;
    }
    //性别
    if ([self.U_SexField.text isEqualToString:@""]) {
        [self alertWithStr:@"性别不能为空"];
        return;
    }
    //生日
    if ([self.U_BirthdayField.text isEqualToString:@""]) {
        [self alertWithStr:@"生日不能为空"];
        return;
    }
    //电话
    pattern = @"^[0-9]{11}";
    if (![self predicate:pattern withStr:self.U_PhoneField.text]) {
        [self alertWithStr:@"请填写11位手机号"];
        return;
    }
    //学校
    if ([self.S_SchoolNameField.text containsStringWithios7:@" "] || [self.S_SchoolNameField.text isEqualToString:@""]) {
        [self alertWithStr:@"学校不能为空"];
        return;
    }
    //班级
    if ([self.C_NameField.text containsStringWithios7:@" "] || [self.C_NameField.text isEqualToString:@""]) {
        [self alertWithStr:@"班级不能为空"];
        return;
    }
    //省市
    if ([self.provincecityField.text isEqualToString:@""]) {
        [self alertWithStr:@"省市不能为空"];
        return;
    }
    //街道
    if ([self.U_AdressField.text containsStringWithios7:@" "] || [self.U_AdressField.text isEqualToString:@""]) {
        [self alertWithStr:@"街道地址不能为空"];
        return;
    }
    //职业
    if ([self.U_JobField.text containsStringWithios7:@" "] || [self.U_JobField.text isEqualToString:@""]) {
        [self alertWithStr:@"职位不能为空"];
        return;
    }
//    //QQ
//    if ([self.U_QQField.text containsStringWithios7:@" "] || [self.U_QQField.text isEqualToString:@""]) {
//        [self alertWithStr:@"QQ不能为空"];
//        return;
//    }
//    //微信
//    if ( [self.U_WeChatField.text containsStringWithios7:@" "] || [self.U_WeChatField.text isEqualToString:@""]) {
//        [self alertWithStr:@"微信不能为空"];
//        return;
//    }
    //邮箱
    if (![self predicate:@"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(.[a-zA-Z0-9_-]+)+$" withStr:self.U_EmailField.text] && ![self.U_EmailField.text isEqualToString:@""]) {
        [self alertWithStr:@"请填写正确的邮箱"];
        return;
    }

//    
//    action=Reg&&&U_Class=班级（下拉框选择传递整形）&U_QQ=QQ可空&U_WeChat=微信 可空&U_Email=邮箱 可空&U_CurrentAdress=定位的当前位置 可空&U_Job=职业&U_Province=省份（根据JSON来 整型ID）&U_City=城市 根据JSON来 整型ID
//    
//
    

    
    NSDictionary *dict = @{
                           @"action":@"Reg",
                           @"A_Account":self.A_AccountField.text,
                           @"A_Password":self.A_PasswordField.text,
                           @"U_Name":self.U_NameField.text,
                           @"U_Sex":[self.U_SexField.text isEqualToString:@"男"]?@"1":@"0",
                           @"U_Birthday":self.U_BirthdayField.text,
                           @"U_Phone":self.U_PhoneField.text,
                           @"U_Adress":self.U_AdressField.text,
                           @"U_Class":self.classID,
                           @"U_QQ":self.U_QQField.text,
                           @"U_WeChat":self.U_WeChatField.text,
                           @"U_Email":self.U_EmailField.text,
                           @"U_CurrentAdress":@"",
                           @"U_Job":self.U_JobField.text,
                           @"U_Province":self.provinceID,
                           @"U_City":self.cityID
                           };
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"正在注册";
    [HUD show:YES];
    
    
     NSString *urlStr = [NSString stringWithFormat:@"%@/AppDo/UserService.ashx",KUrl];
    [HttpTool httpToolPost:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MLog(@"%@",responseObject);
        if ([responseObject[@"RegMess"] isEqualToString:@"Success"]) {
            HUD.labelText = @"注册成功";
            [HUD hide:YES afterDelay:1];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            HUD.labelText = @"注册失败";
            [HUD hide:YES afterDelay:1];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MLog(@"%@",operation.responseString);
        MLog(@"%@",error);
        HUD.labelText = @"注册失败";
        [HUD hide:YES afterDelay:1];
        
    }];
    

}


- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}


/**
 *  验证用户信息
 *
 *  @param predicate 正则表达式
 *  @param str       验证内容
 *
 *  @return bool
 */
- (BOOL)predicate:(NSString *)predicate withStr:(NSString *)str
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicate];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

/**
 *  提示
 *
 *  @param str 内容
 */
- (void)alertWithStr:(NSString *)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:@"" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
}




#pragma mark - lazy
- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor = [UIColor whiteColor];
        //设置区域
        NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"];
        _datePicker.locale = local;
        [_datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (UIPickerView *)sexPicker
{
    if (!_sexPicker) {
        _sexPicker = [[UIPickerView alloc] init];
        _sexPicker.delegate = self;
        _sexPicker.dataSource = self;
        _sexPicker.showsSelectionIndicator = YES;
    }
    return _sexPicker;
}

- (UIPickerView *)cityPicker
{
    if (!_cityPicker) {
        _cityPicker = [[UIPickerView alloc] init];
        _cityPicker.delegate = self;
        _cityPicker.dataSource = self;
        _cityPicker.showsSelectionIndicator = YES;
        _cityPicker.backgroundColor = [UIColor whiteColor];
    }
    return _cityPicker;
}

- (UIPickerView *)classPicker
{
    if (!_classPicker) {
        _classPicker = [[UIPickerView alloc] init];
        _classPicker.delegate = self;
        _classPicker.dataSource = self;
        _classPicker.showsSelectionIndicator = YES;
        _classPicker.backgroundColor = [UIColor whiteColor];
    }
    return _classPicker;
}

- (NSArray *)provinceList
{
    if (!_provinceList) {
        NSString *strUlr = [[NSBundle mainBundle] pathForResource:@"province" ofType:@"plist"];
        _provinceList = [NSArray arrayWithContentsOfFile:strUlr];
    }
    return _provinceList;
}

- (NSArray *)cityList
{
    if (!_cityList) {
        NSString *strUlr = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        _cityList = [NSArray arrayWithContentsOfFile:strUlr];
    }
    return _cityList;
}

- (NSArray *)classList
{
//    1	初1992级102班
//    2	初1992级103班
//    3	初1992级104班
//    4	初1992级105班
//    5	高1995级199班(高一高二)
//    6	高1995级200班(高一高二)
//    7	高1995级201班(高一高二)
//    8	高1995级202班(高一高二)
//    9	高1995级203班(高一高二)
//    10	高1995级204班(高一高二)
//    11	高1995级199班(高三)
//    12	高1995级200班(高三)
//    13	高1995级201班(高三)
//    14	高1995级202班(高三)
//    15	高1995级203班(高三)
//    16	高1995级204班(高三)
    if (!_classList) {
        _classList = @[@{@"id":@"1",@"name":@"初1992级102班"},@{@"id":@"2",@"name":@"初1992级103班"},@{@"id":@"3",@"name":@"初1992级104班"},@{@"id":@"4",@"name":@"初1992级105班"},@{@"id":@"5",@"name":@"高1995级199班(高一高二)"},@{@"id":@"6",@"name":@"高1995级200班(高一高二)"},@{@"id":@"7",@"name":@"高1995级201班(高一高二)"},@{@"id":@"8",@"name":@"高1995级202班(高一高二)"},@{@"id":@"9",@"name":@"高1995级202班(高一高二)"},@{@"id":@"10",@"name":@"高1995级204班(高一高二)"},@{@"id":@"11",@"name":@"高1995级199班(高三)"},@{@"id":@"12",@"name":@"高1995级200班(高三)"},@{@"id":@"13",@"name":@"高1995级201班(高三)"},@{@"id":@"14",@"name":@"高1995级202班(高三)"},@{@"id":@"15",@"name":@"高1995级203班(高三)"},@{@"id":@"16",@"name":@"高1995级203班(高三)"}];
    }
    return _classList;
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
