//
//  RegistersViewController.m
//  tongxunlu
//
//  Created by elaine on 15/9/12.
//  Copyright (c) 2015年 sancaikeji. All rights reserved.
//

#import "RegistersViewController.h"

@interface RegistersViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *A_AccountField;
@property (weak, nonatomic) IBOutlet UITextField *A_PasswordField;
@property (weak, nonatomic) IBOutlet UITextField *U_NameField;
@property (weak, nonatomic) IBOutlet UITextField *U_SexField;
@property (weak, nonatomic) IBOutlet UITextField *U_BirthdayField;
@property (weak, nonatomic) IBOutlet UILabel *U_PhoneField;
@property (weak, nonatomic) IBOutlet UITextField *S_SchoolNameField;
@property (weak, nonatomic) IBOutlet UITextField *C_NameField;
@property (weak, nonatomic) IBOutlet UITextField *provincecityField;
@property (weak, nonatomic) IBOutlet UITextField *U_AdressField;
@property (weak, nonatomic) IBOutlet UITextField *U_JobField;
@property (weak, nonatomic) IBOutlet UITextField *U_QQField;
@property (weak, nonatomic) IBOutlet UITextField *U_EmailField;


@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewTop;


@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *sexPicker;
@property (nonatomic, strong) UIPickerView *cityPicker;

//选中的textField
@property (nonatomic, strong) UITextField *selectField;
@property (nonatomic, strong) NSArray *sexList;

//省市数据
@property (nonatomic, strong) NSArray *provinceList;
@property (nonatomic, strong) NSArray *cityList;

@end

@implementation RegistersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sexList = @[@"男",@"女"];
    self.U_BirthdayField.inputView = self.datePicker;
    self.U_SexField.inputView = self.sexPicker;
    self.provincecityField.inputView = self.cityPicker;
    
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


#pragma mark - UIPickerDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self.sexPicker) {
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
    } else {
        if (component == 0) {
            NSDictionary *provinceDict = self.provinceList[row];
            return provinceDict[@"PR_Name"];
        } else {
            NSInteger rows = [pickerView selectedRowInComponent:0];
            NSDictionary *provinceDict = self.provinceList[rows];
            NSString *provinceID = provinceDict[@"PR_Id"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CT_Province == %@",provinceID];
            NSArray *cityList = [self.cityList filteredArrayUsingPredicate:predicate];
            
            return cityList[row][@"CT_Name"];
        }
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.sexPicker) {
        self.U_SexField.text = self.sexList[row];
    } else {
        if (component == 0) {
            [pickerView reloadComponent:1];
            NSDictionary *provinceDict = self.provinceList[row];
            NSString *provinceID = provinceDict[@"PR_Id"];
            NSString *provinceName = provinceDict[@"PR_Name"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CT_Province == %@",provinceID];
            NSArray *cityList = [self.cityList filteredArrayUsingPredicate:predicate];
            
            
            NSInteger rows = [pickerView selectedRowInComponent:1];
            NSString *cityName = cityList[rows][@"CT_Name"];
            
            self.provincecityField.text = [NSString stringWithFormat:@"%@%@",provinceName,cityName];
        } else {
            NSInteger rows = [pickerView selectedRowInComponent:0];
            NSDictionary *provinceDict = self.provinceList[rows];
            NSString *provinceID = provinceDict[@"PR_Id"];
            NSString *provinceName = provinceDict[@"PR_Name"];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CT_Province == %@",provinceID];
            NSArray *cityList = [self.cityList filteredArrayUsingPredicate:predicate];
            NSString *cityName = cityList[row][@"CT_Name"];
            
            self.provincecityField.text = [NSString stringWithFormat:@"%@%@",provinceName,cityName];
            
        }
        
        
        
      
        
    }
}




#pragma mark - lazy
- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        //_datePicker.bounds = CGRectMake(0, 0, 300, 100);
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
