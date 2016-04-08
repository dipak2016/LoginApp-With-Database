//
//  AppDelegate.h
//  LoginApp
//
//  Created by Tops on 10/30/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(retain,nonatomic)NSString *DB_path;

-(void)CopyAndPaste;
@end

