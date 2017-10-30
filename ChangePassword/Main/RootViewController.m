//
//  RootViewController.m
//  ChangePassword
//
//  Created by Jason_Xu on 2017/10/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITextFieldDelegate>

@end

static NSString *originPassword = @"123456";

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self config];
    //
    [self layoutRootViewControllerSubviews];
}
#pragma mark - 基本设置
- (void)config{
    self.navigationItem.title = @"重置密码";
    if (!kIsValidNSString(self.originPassword.text) || !self.originPassword.text) {
        [self changeTFUserInteractionEnabled:NO];
    }else{
        [self changeTFUserInteractionEnabled:YES];
    }
    //
    [self.originPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
#pragma mark - 布局
- (void)layoutRootViewControllerSubviews{
    __weak typeof(self) weak_self = self;
    [weak_self.flagSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weak_self.view);
    }];
    //
    [weak_self.originPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.flagSuperView.mas_top).offset(kNavgationBarHeight + 30 * kViewSizeScale);
        make.left.mas_equalTo(weak_self.flagSuperView.mas_left).offset(10 * kViewSizeScale);
        make.right.mas_equalTo(weak_self.flagSuperView.mas_right).offset(-10 * kViewSizeScale);
        make.height.mas_equalTo(44 * kViewSizeScale);
    }];
    //
    [weak_self.resetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.originPassword.mas_bottom).offset(20 * kViewSizeScale);
        make.left.right.height.equalTo(weak_self.originPassword);
    }];
    //
    [weak_self.repetNewPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.resetPassword.mas_bottom).offset(20 * kViewSizeScale);
        make.left.right.height.equalTo(weak_self.originPassword);
    }];
    //
    [weak_self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.repetNewPassword.mas_bottom).offset(30 * kViewSizeScale);
        make.centerX.equalTo(weak_self.flagSuperView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kMainScreenW/2, 50 * kViewSizeScale));
    }];
}
#pragma mark - 网络操作
- (IBAction)loginAction:(id)sender {
    
    [self giveUpFirstReponcedWithBool:YES];
    //
    if (!self.originPassword.text || !kIsValidNSString(self.originPassword.text)) {
        [SVProgressHUD showInfoWithStatus:@"请输入原密码!" defaultStyle:SVProgressHUDStyleCustom dismisWithDelay:1.0f];
        return;
    }
    //
    if ((!self.resetPassword.text || !self.repetNewPassword.text) ||(!kIsValidNSString(self.resetPassword.text) || !kIsValidNSString(self.repetNewPassword.text))) {
        [SVProgressHUD showInfoWithStatus:@"请输入新密码!" defaultStyle:SVProgressHUDStyleCustom dismisWithDelay:1.0f];
        return;
    }
    //
    if ((kIsValidNSString(self.repetNewPassword.text) && kIsValidNSString(self.resetPassword.text)) && ![self.resetPassword.text isEqualToString:self.repetNewPassword.text]) {
        [SVProgressHUD showErrorWithStatus:@"请确保两次输入的新密码一致！" defaultStyle:SVProgressHUDStyleCustom dismissWithDelay:1.f];
        return;
    }
    //
    [SVProgressHUD showInfoWithStatus:@"修改中..." defaultStyle:SVProgressHUDStyleCustom];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"完成修改!" dismissWithDelay:1.5f];
    });
}
//
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (self.originPassword.text && [self.originPassword.text isEqualToString:originPassword]) {
        [self changeTFUserInteractionEnabled:YES];
    }else{
        [self changeTFUserInteractionEnabled:NO];
    }
}
//
- (void)changeTFUserInteractionEnabled:(BOOL)boolFlag{
    self.resetPassword.userInteractionEnabled = boolFlag;
    self.repetNewPassword.userInteractionEnabled = boolFlag;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self giveUpFirstReponcedWithBool:YES];
}

- (void)giveUpFirstReponcedWithBool:(BOOL)flag{
    [self.originPassword endEditing:flag];
    [self.resetPassword endEditing:flag];
    [self.repetNewPassword endEditing:flag];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
