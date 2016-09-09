//
//  DataModel.h
//  无限轮播
//
//  Created by 刘浩浩 on 16/6/12.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
/*
 *此模型不可省略，为的是传入图片链接，标题，链接地址，内容ID等数据
 */
@property(nonatomic,strong)NSString *imgURL;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *webLink;
@property(nonatomic,strong)NSString *contentID;


@end
