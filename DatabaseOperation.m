//
//  DatabaseOperation.m
//  LoginApp
//
//  Created by Tops on 10/30/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import "DatabaseOperation.h"

@implementation DatabaseOperation
@synthesize st_dbpath;
-(id)init
{
    if (self==[super init])
    {
        deli=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        st_dbpath=deli.DB_path;
    }
    return self;
}
-(NSMutableArray *)GetTwoField:(NSString *)query
{
    NSMutableArray *arrmute=[[NSMutableArray alloc]init];
    NSMutableDictionary *dictmute=[[NSMutableDictionary alloc]init];
    if (sqlite3_open([st_dbpath UTF8String], &(dbsql))==SQLITE_OK)
    {
        sqlite3_stmt *ppStmt;
        if (sqlite3_prepare_v2(dbsql, [query UTF8String], -1, &ppStmt, nil)==SQLITE_OK)
        {
            while (sqlite3_step(ppStmt)==SQLITE_ROW)
            {
                NSString *st_id=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt,0)];
                NSString *st_nm=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt,1)];
                [dictmute setObject:st_id forKey:@"st_id"];
                [dictmute setObject:st_nm forKey:@"st_nm"];
                [arrmute addObject:[dictmute copy]];
            }
        }
        sqlite3_finalize(ppStmt);
    }
    sqlite3_close(dbsql);
    return arrmute;
}
-(NSString *)CheckLogin:(NSString *)query
{
    NSString *result=@"";
    if (sqlite3_open([st_dbpath UTF8String], &(dbsql))==SQLITE_OK)
    {
        sqlite3_stmt *ppStmt;
        if (sqlite3_prepare_v2(dbsql, [query UTF8String], -1, &ppStmt, nil)==SQLITE_OK)
        {
            while (sqlite3_step(ppStmt)==SQLITE_ROW)
            {
                NSString *st_id=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt,0)];
                result=st_id;
            }
        }
        sqlite3_finalize(ppStmt);
    }
    sqlite3_close(dbsql);
    return result;
}
-(BOOL)InsUpdDel:(NSString *)query
{
    BOOL result=NO;
    if (sqlite3_open([st_dbpath UTF8String], &(dbsql))==SQLITE_OK)
    {
        sqlite3_stmt *ppStmt;
        if (sqlite3_prepare_v2(dbsql, [query UTF8String], -1, &ppStmt, nil)==SQLITE_OK)
        {
            sqlite3_step(ppStmt);
            result=YES;
        }
        sqlite3_finalize(ppStmt);
    }
    sqlite3_close(dbsql);
    return result;
}
-(NSMutableArray *)SelectAllRecord:(NSString *)query
{
    NSMutableArray *arrmute=[[NSMutableArray alloc]init];
    NSMutableDictionary *dictmute=[[NSMutableDictionary alloc]init];
    if (sqlite3_open([st_dbpath UTF8String], &(dbsql))==SQLITE_OK)
    {
        sqlite3_stmt *ppStmt;
        if (sqlite3_prepare_v2(dbsql, [query UTF8String], -1, &ppStmt, nil)==SQLITE_OK)
        {
            while (sqlite3_step(ppStmt)==SQLITE_ROW)
            {
                NSString *e_id=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt,0)];
                NSString *e_nm=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt,1)];
                NSString *st_nm=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt,2)];
                NSString *ct_nm=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt,3)];
                NSString *d_nm=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt,4)];
                NSString *e_unm=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt,5)];
                NSString *e_pass=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt,6)];
                
                [dictmute setObject:e_id forKey:@"e_id"];
                [dictmute setObject:e_nm forKey:@"e_nm"];
                [dictmute setObject:st_nm forKey:@"st_nm"];
                [dictmute setObject:ct_nm forKey:@"ct_nm"];
                [dictmute setObject:d_nm forKey:@"d_nm"];
                [dictmute setObject:e_unm forKey:@"e_unm"];
                [dictmute setObject:e_pass forKey:@"e_pass"];
                
                [arrmute addObject:[dictmute copy]];
            }
        }
        sqlite3_finalize(ppStmt);
    }
    sqlite3_close(dbsql);
    return arrmute;
}
@end
