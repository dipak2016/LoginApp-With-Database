//
//  ViewController.h
//  LoginApp
//
//  Created by Tops on 10/30/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseOperation.h"
#import "DetailViewController.h"

@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    DatabaseOperation *dbop;
    UIPickerView *pkr_designation;
    UIPickerView *pkr_state;
    UIPickerView *pkr_city;
    NSArray *arr_ct;
    NSArray *arr_desgnation;
    NSArray *arr_state;
}
@property (weak, nonatomic) IBOutlet UITextField *txt_id;
@property (weak, nonatomic) IBOutlet UITextField *txt_nm;
@property (weak, nonatomic) IBOutlet UITextField *txt_state;
@property (weak, nonatomic) IBOutlet UITextField *txt_city;
@property (weak, nonatomic) IBOutlet UITextField *txt_u_nm;
@property (weak, nonatomic) IBOutlet UITextField *txt_u_pass;
@property (weak, nonatomic) IBOutlet UITextField *txt_designation;
@property(retain,nonatomic)NSArray *arr_vw_1;
- (IBAction)btn_action:(id)sender;
-(void)ClearAll;
@property (weak, nonatomic) IBOutlet UIButton *btn_submit;
- (IBAction)btn_login:(id)sender;
@end

