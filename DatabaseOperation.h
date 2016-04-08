//
//  DatabaseOperation.h
//  LoginApp
//
//  Created by Tops on 10/30/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <sqlite3.h>
@interface DatabaseOperation : NSObject
{
    AppDelegate *deli;
    sqlite3 *dbsql;
}
@property(retain,nonatomic)NSString *st_dbpath;
-(NSMutableArray *)GetTwoField:(NSString *)query;
-(NSMutableArray *)SelectAllRecord:(NSString *)query;
-(NSString *)CheckLogin:(NSString *)query;
-(BOOL)InsUpdDel:(NSString *)query;
@end

