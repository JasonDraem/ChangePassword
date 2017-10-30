//
//  RootViewController.h
//  ChangePassword
//
//  Created by Jason_Xu on 2017/10/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *flagSuperView;

@property (weak, nonatomic) IBOutlet UITextField *originPassword;

@property (weak, nonatomic) IBOutlet UITextField *resetPassword;

@property (weak, nonatomic) IBOutlet UITextField *repetNewPassword;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
