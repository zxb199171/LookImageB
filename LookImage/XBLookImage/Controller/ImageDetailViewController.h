//
//  ImageDetailViewController.h
//  HealthyCalendar
//
//  Created by chk on 15/10/22.
//  Copyright © 2015年 chk. All rights reserved.
//
//
//  ImageDetailViewController.h
//  Hairdresser
//
//  Created by chk on 15/5/27.
//  Copyright (c) 2015年 chk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerController.h"

@protocol imageDelegate <NSObject>


-(void)deleteImageWithIndexPathRow:(NSInteger)indexRow;

@end

@class ImageDetailTableView;



@interface ImageDetailViewController : UIViewController
{
    ImageDetailTableView *_tableView;  //浏览图片的表视图
}


@property(nonatomic,retain)NSMutableArray *dataList;   //用于存储图片数据
@property(nonatomic,assign)int index;  //获取点击索引

@property(nonatomic,assign)NSString *titleLabelStr;

@property(nonatomic, assign) id<imageDelegate> imageDelegate ;

//跟新图片数量 方法
-(void)updateImageCount:(NSInteger)count;

@end



