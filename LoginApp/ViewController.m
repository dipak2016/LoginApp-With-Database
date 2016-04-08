//
//  ViewController.m
//  LoginApp
//
//  Created by Tops on 10/30/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize txt_city,txt_designation,txt_id,txt_nm,txt_state,txt_u_nm,txt_u_pass,btn_submit,arr_vw_1;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    txt_city.delegate=self;
    txt_id.delegate=self;
    txt_u_nm.delegate=self;
    
    dbop=[[DatabaseOperation alloc]init];
    
    //designation
    arr_desgnation=[[NSArray alloc]init];
    arr_desgnation=[dbop GetTwoField:@"select d_id,d_nm from designation"];
    pkr_designation=[[UIPickerView alloc]init];
    pkr_designation.dataSource=self;
    pkr_designation.delegate=self;
    [txt_designation setInputView:pkr_designation];
    //designation
    
    //state
    arr_state=[[NSArray alloc]init];
    arr_state=[dbop GetTwoField:@"select st_id,st_nm from state"];
    pkr_state=[[UIPickerView alloc]init];
    pkr_state.dataSource=self;
    pkr_state.delegate=self;
    [txt_state setInputView:pkr_state];
    //state
    
    //city
    arr_ct=[[NSArray alloc]init];
    pkr_city=[[UIPickerView alloc]init];
    pkr_city.dataSource=self;
    pkr_city.delegate=self;
    [txt_city setInputView:pkr_city];
    //city
}
-(void)viewWillAppear:(BOOL)animated
{
    if (arr_vw_1.count>0)
    {
        [btn_submit setTitle:@"UPDATE" forState:UIControlStateNormal];
        txt_id.enabled=NO;
        txt_nm.text=[[arr_vw_1 objectAtIndex:0]objectForKey:@"e_nm"];
        txt_id.text=[[arr_vw_1 objectAtIndex:0]objectForKey:@"e_id"];
        txt_u_nm.text=[[arr_vw_1 objectAtIndex:0]objectForKey:@"e_unm"];
        txt_state.text=[[arr_vw_1 objectAtIndex:0]objectForKey:@"st_nm"];
        txt_city.text=[[arr_vw_1 objectAtIndex:0]objectForKey:@"ct_nm"];
        txt_designation.text=[[arr_vw_1 objectAtIndex:0]objectForKey:@"d_nm"];
        txt_u_pass.text=[[arr_vw_1 objectAtIndex:0]objectForKey:@"e_pass"];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int index=0;
    if (pickerView==pkr_designation)
    {
        index=(int)arr_desgnation.count;
    }
    if (pickerView==pkr_state)
    {
        index=(int)arr_state.count;
    }
    if (pickerView==pkr_city)
    {
        index=(int)arr_ct.count;
    }
    return index;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *index=@"";
    if (pickerView==pkr_designation)
    {
        index=[[arr_desgnation objectAtIndex:row]objectForKey:@"st_nm"];
    }
    if (pickerView==pkr_state)
    {
        index=[[arr_state objectAtIndex:row]objectForKey:@"st_nm"];
    }
    if (pickerView==pkr_city)
    {
        index=[[arr_ct objectAtIndex:row]objectForKey:@"st_nm"];
    }
    return index;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==pkr_designation)
    {
        txt_designation.text=[[arr_desgnation objectAtIndex:row]objectForKey:@"st_nm"];
    }
    if (pickerView==pkr_state)
    {
        txt_state.text=[[arr_state objectAtIndex:row]objectForKey:@"st_nm"];
    }
    if (pickerView==pkr_city)
    {
        txt_city.text=[[arr_ct objectAtIndex:row]objectForKey:@"st_nm"];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==txt_city)
    {
        if (txt_state.text.length>0)
        {
            NSPredicate *prd2=[NSPredicate predicateWithFormat:@"st_nm==%@",txt_state.text];
            
            NSArray *arr_demo=[arr_state filteredArrayUsingPredicate:prd2];
            
            
            NSString *st_ct=[NSString stringWithFormat:@"select ct_id,ct_nm from city where s_id='%@'",[[arr_demo objectAtIndex:0]objectForKey:@"st_id"]];
            
             arr_ct=[dbop GetTwoField:st_ct];
            [pkr_city reloadAllComponents];
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==txt_id)
    {
        NSString *query2=[NSString stringWithFormat:@"select count(e_id) from emp where e_id='%@'",txt_id.text];
        if([[dbop CheckLogin:query2]intValue]==1)
        {
            txt_id.text=@"";
            UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Exists" message:@"ID Already Exists.." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
        }
    }
    if (textField==txt_u_nm)
    {
        if ([btn_submit.titleLabel.text isEqual:@"SUBMIT"])
        {
            NSString *query2=[NSString stringWithFormat:@"select count(e_id) from emp where e_unm='%@'",txt_u_nm.text];
            if([[dbop CheckLogin:query2]intValue]==1)
            {
                txt_u_nm.text=@"";
                UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Exists" message:@"User Name Already Exists.." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alrt show];
            }
        }
        else if ([btn_submit.titleLabel.text isEqual:@"UPDATE"])
        {
            if (![txt_u_nm.text isEqualToString:[[arr_vw_1 objectAtIndex:0]objectForKey:@"e_unm"]])
            {
                NSString *query2=[NSString stringWithFormat:@"select count(e_id) from emp where e_unm='%@'",txt_u_nm.text];
                if([[dbop CheckLogin:query2]intValue]==1)
                {
                    txt_u_nm.text=@"";
                    UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Exists" message:@"User Name Already Exists.." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    [alrt show];
                }
            }
        }
    }
}
- (IBAction)btn_action:(id)sender
{
    NSString *msg=@"";
    NSString *query=@"";
    NSPredicate *prd_st=[NSPredicate predicateWithFormat:@"st_nm==%@",txt_state.text];
    NSPredicate *prd_ct=[NSPredicate predicateWithFormat:@"st_nm==%@",txt_city.text];
    NSPredicate *prd_des=[NSPredicate predicateWithFormat:@"st_nm==%@",txt_designation.text];
    NSString *st_id=[[[arr_state filteredArrayUsingPredicate:prd_st]objectAtIndex:0]objectForKey:@"st_id"];
    NSString *ct_id=[[[arr_ct filteredArrayUsingPredicate:prd_ct]objectAtIndex:0]objectForKey:@"st_id"];
    NSString *des_id=[[[arr_desgnation filteredArrayUsingPredicate:prd_des]objectAtIndex:0]objectForKey:@"st_id"];
    
    if ([btn_submit.titleLabel.text isEqual:@"SUBMIT"])
    {
        query=[NSString stringWithFormat:@"insert into emp(e_id,e_nm,e_st,e_ct,e_unm,e_pass,e_designation)values('%@','%@','%@','%@','%@','%@','%@')",txt_id.text,txt_nm.text,st_id,ct_id,txt_u_nm.text,txt_u_pass.text,des_id];
        BOOL result=[dbop InsUpdDel:query];
        if (result==YES)
        {
            msg=@"Inserted..";
        }
        else
        {
            msg=@"Failed..";
        }
    }
    else if ([btn_submit.titleLabel.text isEqual:@"UPDATE"])
    {
        query=[NSString stringWithFormat:@"update emp set e_nm='%@',e_st='%@',e_ct='%@',e_unm='%@',e_pass='%@',e_designation='%@' where e_id='%@'",txt_nm.text,st_id,ct_id,txt_u_nm.text,txt_u_pass.text,des_id,txt_id.text];
        BOOL result=[dbop InsUpdDel:query];
        if (result==YES)
        {
            msg=@"Updated..";
        }
        else
        {
            msg=@"Failed..";
        }
    }
    
    
    UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Alert" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    alrt.tag=2002;
    [alrt show];
    
}
-(void)ClearAll
{
    txt_city.text=@"";
    txt_designation.text=@"";
    txt_id.text=@"";
    txt_nm.text=@"";
    txt_state.text=@"";
    txt_u_nm.text=@"";
    txt_u_pass.text=@"";
    [btn_submit setTitle:@"SUBMIT" forState:UIControlStateNormal];
    txt_id.enabled=YES;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==101)
    {
        NSLog(@"unm:%@",[[alertView textFieldAtIndex:0]text]);
        NSLog(@"pass:%@",[[alertView textFieldAtIndex:1]text]);
        
        NSString *query=[NSString stringWithFormat:@"select count(e_id) from emp where e_unm='%@' and e_pass='%@'",[[alertView textFieldAtIndex:0]text],[[alertView textFieldAtIndex:1]text]];
        if ([[dbop CheckLogin:query]intValue]==1)
        {
            NSString *query2=[NSString stringWithFormat:@"select e_id from emp where e_unm='%@' and e_pass='%@'",[[alertView textFieldAtIndex:0]text],[[alertView textFieldAtIndex:1]text]];
            DetailViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
            detail.st_id_2=[dbop CheckLogin:query2];
            [self.navigationController pushViewController:detail animated:YES];
        }
        else
        {
            UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Error" message:@"try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
        }
        
    }
    if (alertView.tag==2002)
    {
        NSString *query2=[NSString stringWithFormat:@"select e_id from emp where e_id='%@'",txt_id.text];
        DetailViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        detail.st_id_2=[dbop CheckLogin:query2];
        [self.navigationController pushViewController:detail animated:YES];
    }
    [self ClearAll];
}
- (IBAction)btn_login:(id)sender
{
    UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"LOGIN" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"LOGIN", nil];
    alrt.alertViewStyle=UIAlertViewStyleLoginAndPasswordInput;
    alrt.tag=101;
    [alrt show];
}
@end
