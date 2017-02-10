//
//  PhotoScrollView.h
//  Hairdresser
//
//  Created by chk on 15/5/27.
//  Copyright (c) 2015年 chk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageDetailTableView;

@interface PhotoScrollView : UIScrollView<UIScrollViewDelegate>

{
    
    UIImageView *_imageView;
}

@property(nonatomic,copy)UIImage *imageName;
@property(nonatomic,assign)int row;
@property(nonatomic,retain)ImageDetailTableView *tableView;
@property(nonatomic,retain)NSArray *dataList;  //总共的图片数据






@end
