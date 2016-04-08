//
//  DetailViewController.h
//  LoginApp
//
//  Created by Tops on 11/2/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseOperation.h"
#import "ViewController.h"
@interface DetailViewController : UIViewController
{
    DatabaseOperation *dbop;
    NSArray *arr;
}
@property(retain,nonatomic)NSString *st_id_2;
@property (weak, nonatomic) IBOutlet UILabel *lbl_nm;
@property (weak, nonatomic) IBOutlet UILabel *lbl_id;
@property (weak, nonatomic) IBOutlet UILabel *lbl_st;
@property (weak, nonatomic) IBOutlet UILabel *lbl_ct;
@property (weak, nonatomic) IBOutlet UILabel *lbl_des;
@property (weak, nonatomic) IBOutlet UILabel *lbl_unm;
@property (weak, nonatomic) IBOutlet UILabel *u_pass;
- (IBAction)btn_edit:(id)sender;
@end
