//
//  ViewController.m
//  LookImage
//
//  Created by chk on 16/3/9.
//  Copyright © 2016年 chk. All rights reserved.
//

#import "ViewController.h"

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIScrollView *scrollView;
    UIButton *addPicBtn;

}
@property (nonatomic,copy)  NSMutableArray *imageDataArry;
@end

@implementation ViewController{
    
    UICollectionView * _collectionView;
}

-(NSMutableArray *)imageDataArry
{
    if (_imageDataArry==nil) {
        _imageDataArry=[NSMutableArray array];
    }
    return _imageDataArry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *navigationView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    navigationView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:navigationView];

    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(ScreenWidth-100, 20, 100, 40);
    [button setTitle:@"选择相片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(LocalPhoto) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:button];
    
//    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,64+1, ScreenWidth, ScreenHeight-64)];
//    scrollView.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:scrollView];
    
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.minimumInteritemSpacing = 1;
    collectionViewLayout.minimumLineSpacing = 1;
    //    collectionViewLayout.itemSize = CGSizeMake(100, 100);
    //    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) collectionViewLayout:collectionViewLayout];
    
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GradientCell"];
    [self.view addSubview:_collectionView];

    
    
    float  iconBtnW=(ScreenWidth-5)/3.0;
    addPicBtn = [[UIButton alloc] init];
    addPicBtn.tag=1111;
    addPicBtn.frame = CGRectMake(5, 5, iconBtnW, iconBtnW);
    [addPicBtn setImage:[UIImage imageNamed:@"添加图片"] forState:UIControlStateNormal];
    [addPicBtn addTarget:self action:@selector(LocalPhoto) forControlEvents:UIControlEventTouchUpInside];
    [_collectionView addSubview:addPicBtn];


}

//显示选择的图片
-(void)showImageView{
    
    float interval=4; //间隔
    
    float  roleBtnW=(ScreenWidth-16)/3.0;
    float  roleBtnH=roleBtnW;

    CGFloat roleBtnX;
    CGFloat roleBtnY;
    
    for (int i=0; i<self.imageDataArry.count; i++) {
        
        NSInteger row = i % 3;
        NSInteger col = i / 3;
        roleBtnX = row * (roleBtnW + interval)+interval;
        roleBtnY = col * (roleBtnH + interval);

        UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(roleBtnX, roleBtnY, roleBtnW, roleBtnH)];
        iconBtn.tag=1+i;
        [iconBtn setImage:self.imageDataArry[i] forState:UIControlStateNormal];
        [iconBtn addTarget:self action:@selector(lookPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:iconBtn];

    }
    
    //重新排列添加btn的位置

    UIButton *btn=scrollView.subviews.lastObject;

    if (btn.right/btn.width>=3) {
        addPicBtn.x=5;
        addPicBtn.top=btn.bottom+5;
    }else{
        addPicBtn.left=btn.right+5;
        addPicBtn.top=btn.top;
    }
    [self contentSizeHeight];
}

//TODO:选择图片
- (void)LocalPhoto
{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    int n=20; //设置最多选择9张
    elcPicker.maximumImagesCount = n;
    elcPicker.returnsOriginalImage = NO;
    elcPicker.imagePickerDelegate = self;
    [self presentViewController:elcPicker animated:YES completion:nil];
}

//查看点击相片
-(void)lookPhoto:(UICollectionViewCell *)btn{
   ImageDetailViewController *imageDetailVC = [[ImageDetailViewController alloc] init];
    imageDetailVC.imageDelegate=self; //设置代理
    imageDetailVC.dataList = self.imageDataArry;
    // 将当前点击的索引传递给图片浏览控制器
    imageDetailVC.index = (int)btn.tag-1;
    [self presentViewController:imageDetailVC animated:YES completion:NULL];
}

#pragma mark 返回图片数组
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    for (NSDictionary *dict in info) {
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        [self.imageDataArry addObject:image];
    }
//    [self showImageView];
    [_collectionView reloadData];
    
    NSInteger low=self.imageDataArry.count % 3;
    NSInteger n=self.imageDataArry.count / 3;
    
    float  roleBtnW=(ScreenWidth-5)/3.0;
    
//    if (low==1) {
        addPicBtn.x=3 + (low) * roleBtnW;
        addPicBtn.top=6 + (ScreenWidth-5)/3.0 * n;
//    }else{
//        addPicBtn.left=btn.right+5;
//        addPicBtn.top=btn.top;
//    }

}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 删除图片代理 方法
-(void)deleteImageWithIndexPathRow:(NSInteger)indexRow{
    [self.imageDataArry removeObjectAtIndex:indexRow];
    for (UIButton *btn in scrollView.subviews) {
        if(btn.tag!=1111)
            [btn removeFromSuperview];
    }
    
//    [self showImageView];
    
    [_collectionView reloadData];

    
    //删除全部图片后重新排列添加btn的位置
//    if (self.imageDataArry.count==0) {
//        addPicBtn.x=5;
//        addPicBtn.top=5;
//    }
}




//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageDataArry.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"GradientCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.tag=indexPath.row+1;
    
    
    UIImageView *_MyImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (ScreenWidth-5)/3.0, (ScreenWidth-5)/3.0)];
    if (self.imageDataArry.count) {
        _MyImage.image=self.imageDataArry[indexPath.row];
    }
    
    [cell.contentView addSubview:_MyImage];

    
    
    
    //cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-5)/3.0, (ScreenWidth-5)/3.0 );
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 1, 5, 1);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    [self lookPhoto:cell];
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



    
//计算scrollView的contentSize的高度
-(void)contentSizeHeight{
    float height;
    float heightSum=0;
    for (UIView *view in scrollView.subviews) {
        height=view.height;
        heightSum=heightSum+height;
    }
    float interval=scrollView.subviews.lastObject.bottom-heightSum;
    scrollView.contentSize = CGSizeMake(ScreenWidth, heightSum+interval);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
