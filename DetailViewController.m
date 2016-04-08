//
//  DetailViewController.m
//  LoginApp
//
//  Created by Tops on 11/2/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize st_id_2,lbl_ct,lbl_des,lbl_id,lbl_nm,lbl_st,lbl_unm,u_pass;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dbop=[[DatabaseOperation alloc]init];
    NSString *st_que=[NSString stringWithFormat:@"select e.e_id,e.e_nm,s.st_nm,c.ct_nm,d.d_nm,e.e_unm,e.e_pass from emp e inner join state s on e.e_st=s.st_id inner join city c on e.e_ct=c.ct_id inner join designation d on e.e_designation=d.d_id where e.e_id=%@",st_id_2];
    arr=[[NSArray alloc]init];
    arr=[dbop SelectAllRecord:st_que];
    lbl_nm.text=[NSString stringWithFormat:@"Welcome %@",[[arr objectAtIndex:0]objectForKey:@"e_nm"]];
    lbl_id.text=[[arr objectAtIndex:0]objectForKey:@"e_id"];
    lbl_unm.text=[[arr objectAtIndex:0]objectForKey:@"e_unm"];
    lbl_st.text=[[arr objectAtIndex:0]objectForKey:@"st_nm"];
    lbl_ct.text=[[arr objectAtIndex:0]objectForKey:@"ct_nm"];
    lbl_des.text=[[arr objectAtIndex:0]objectForKey:@"d_nm"];
    u_pass.text=[[arr objectAtIndex:0]objectForKey:@"e_pass"];
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

- (IBAction)btn_edit:(id)sender
{
    NSArray *arrnav=[self.navigationController viewControllers];
    ViewController *vc=[arrnav objectAtIndex:0];
    vc.arr_vw_1=arr;
    [self.navigationController popToViewController:vc animated:YES];
}
@end
