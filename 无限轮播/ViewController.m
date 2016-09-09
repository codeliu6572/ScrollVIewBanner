//
//  ViewController.m
//  无限轮播
//
//  Created by 刘浩浩 on 16/6/12.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "TopScrollView.h"
#import "DataModel.h"
@interface ViewController ()<TopScrollViewDelegate>
{
    NSMutableArray *_dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor orangeColor];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Data" ofType:@"json"];
    NSString *dataString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *focusImgs=dict[@"focusImgs"];
    for (NSDictionary *subDic in focusImgs) {
        DataModel *dataModel=[[DataModel alloc]init];
        dataModel.imgURL=subDic[@"imgURL"];
        dataModel.title=subDic[@"title"];
        dataModel.webLink=subDic[@"webLink"];
        dataModel.contentID=subDic[@"id"];
        [_dataArray addObject:dataModel];
    }
    
    _topScrollView=[[TopScrollView alloc]initWithDataArray:_dataArray];
    _topScrollView.delegate=self;
    [self.view addSubview:_topScrollView];
}
#
-(void)didClickScrollViewWithIndex:(NSInteger)index
{
    NSString *webLink=((DataModel *)[_dataArray objectAtIndex:index]).webLink;
    ViewController1 *view1=[[ViewController1 alloc]init];
    view1.webLink=webLink;
    [self.navigationController pushViewController:view1 animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
