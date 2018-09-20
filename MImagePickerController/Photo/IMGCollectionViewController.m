//
//  IMGCollectionViewController.m
//  VideoAndAudio
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "IMGCollectionViewController.h"
#import "IMGCollectionViewCell.h"
#import <Photos/Photos.h>
#import "IMGModel.h"
#import "ToolsView.h"


#define IPHONEX    ([UIScreen mainScreen].bounds.size.width==375 &&  [UIScreen mainScreen].bounds.size.height>800)
#define TABBARH    IPHONEX? 43:0

@interface IMGCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,IMGCollectionViewCellDelegate>

@property(strong,nonatomic)NSMutableArray *arrM;
@property(strong,nonatomic)UICollectionView *collectionIMG;
@property(strong,nonatomic)NSMutableDictionary *saveIMG; //存放图片对象
@property(strong,nonatomic)ToolsView *tools;/**工具*/
@property(strong,nonatomic)NSString *reuseIdentifier;/**代理标记 回调标记*/
@end

@implementation IMGCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

/**通过block方法获取图片*/
-(instancetype)initController:(NSInteger)num block:(IMGblock)returnIMG
{
   
    if (self=[super init])
    {
        self.imgBlock = returnIMG;
        self.numCount=num;
        self.reuseIdentifier=@"block";
    }
    
    return  self;
}

/**委托初始化*/
-(instancetype)initController:(NSInteger)num
{
    if (self=[super init]) {
        
        self.numCount=num;
        self.reuseIdentifier=@"delegate";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [UIScreen mainScreen].bounds.size.width
   // [UIScreen mainScreen].bounds.size.height
    self.numCount=3;
    self.view.backgroundColor=[UIColor whiteColor];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(80, 80);
    layout.minimumLineSpacing=5;
    layout.minimumInteritemSpacing=5;
    layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionIMG=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionIMG.backgroundColor=UIColor.whiteColor;
    self.collectionIMG.delegate=self;
    self.collectionIMG.dataSource=self;
    [self.collectionIMG registerClass:[IMGCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.collectionIMG];
    
    [self.view addSubview:self.tools];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          [self accessIMG];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.collectionIMG reloadData];
        });
    });
  
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(barItemWay)];
    
    rightItem.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    
    /**约束布局*/
    
    self.collectionIMG.translatesAutoresizingMaskIntoConstraints=NO;
    self.tools.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *leftA=[NSLayoutConstraint constraintWithItem:self.collectionIMG attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:0.0];
    
     NSLayoutConstraint *topA=[NSLayoutConstraint constraintWithItem:self.collectionIMG attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0.0];
    
     NSLayoutConstraint *widthA=[NSLayoutConstraint constraintWithItem:self.collectionIMG attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeWidth) multiplier:1.0 constant:0.0];
    
     NSLayoutConstraint *bottomA=[NSLayoutConstraint constraintWithItem:self.collectionIMG attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeBottom) multiplier:1.0 constant:-50.0-(TABBARH)];
    
    [self.view addConstraints:@[leftA,topA,widthA,bottomA]];
    
    NSLayoutConstraint *leftB=[NSLayoutConstraint constraintWithItem:self.tools attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:0.0];

    NSLayoutConstraint *topB=[NSLayoutConstraint constraintWithItem:self.tools attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.collectionIMG attribute:(NSLayoutAttributeBottom) multiplier:1.0 constant:0.0];

    NSLayoutConstraint *widthB=[NSLayoutConstraint constraintWithItem:self.tools attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeWidth) multiplier:1.0 constant:0.0];

    NSLayoutConstraint *bottomB=[NSLayoutConstraint constraintWithItem:self.tools attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeBottom) multiplier:1.0 constant:-(TABBARH)];

    [self.view addConstraints:@[leftB,topB,widthB,bottomB]];
    
   // NSLog(@"%d",TABBARH);
    //[self.collectionIMG addConstraint:topB];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent=NO;
}
-(void)barItemWay
{
    [self toolsBtnWay];
}

-(void)accessIMG
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:YES  containerArr:nil];
    }
    
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    // 遍历相机胶卷,获取大图
    [self enumerateAssetsInAssetCollection:cameraRoll original:YES containerArr:nil];
    
}
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original containerArr:(NSMutableArray *)containerArr {
    //    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        
        __weak typeof(self) weakself=self;
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            IMGModel *obj=[[IMGModel alloc]init];
            obj.img=result;
            obj.isImg=NO;
            [weakself.arrM addObject:obj];
        }];
    }
}


-(NSMutableArray *)arrM
{
    if (!_arrM) {
        
        _arrM=[NSMutableArray array];
    }
    return _arrM;
}


-(NSMutableDictionary *)saveIMG
{
    if (!_saveIMG) {
        
        _saveIMG=[NSMutableDictionary dictionary];
    }
    return _saveIMG;
}

-(ToolsView *)tools
{
    if (!_tools) {
    
        _tools=[[ToolsView alloc]initWithFrame:CGRectZero];
      //  _tools.backgroundColor=[UIColor colorWithRed:113/225.0 green:207/255.0 blue:251/255.0 alpha:1.0];
        [_tools.determineBtn addTarget:self action:@selector(toolsBtnWay) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }
    return _tools;
}

/**确定按钮方法*/
-(void)toolsBtnWay
{
    
    NSArray *arrModel=[self.saveIMG allValues];  //IMGModel 数组
    
    NSMutableArray *arrImg=[NSMutableArray array]; //存放图片的数组
    for (int i=0; i<arrModel.count; i++) {
     
        IMGModel *obj=arrModel[i];
        [arrImg addObject:obj.img];
    }
    
    if ([self.reuseIdentifier isEqualToString:@"block"]) {  //回调
        
        
        
        
        self.imgBlock((NSArray *)arrImg);
    }
    
    if ([self.reuseIdentifier isEqualToString:@"delegate"]) { //委托
        
        [self.delegate IMGCollectionViewController:(NSArray *)arrImg];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return self.arrM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IMGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imgSelected.selected=NO;
    IMGModel *obj= self.arrM[indexPath.row];
    cell.imgView.image=obj.img;
    cell.imgSelected.selected=obj.isImg;
    cell.delegate=self;
    // Configure the cell
    
    return cell;
}

-(void)IMGCollectionView:(IMGCollectionViewCell *)cell isSelected:(Boolean)isA
{
    NSIndexPath *index=[self.collectionIMG indexPathForCell:cell];
    IMGModel *obj=self.arrM[index.row];
    obj.isImg=isA;
    
    if (self.saveIMG.count==self.numCount) { //最大数量的判断
        [self.saveIMG removeObjectForKey:index]; //删除存储的照片对象
        cell.imgSelected.selected=NO;
        obj.isImg=NO;
        /**提示文本*/
        
        if (self.saveIMG.count==self.numCount) {
            __block UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示消息" message:@"照片超出选择的最大数量！" preferredStyle:(UIAlertControllerStyleAlert)];
            [self presentViewController:alert animated:YES completion:nil];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [alert dismissViewControllerAnimated:YES completion: nil];
            });
        }
      
        return;
    }
    
   
    if (isA)
    {
        [self.saveIMG setObject:obj forKey:index];
    }else
    {
        [self.saveIMG removeObjectForKey:index];
    }
    
    NSMutableAttributedString *mutable=[[NSMutableAttributedString alloc]initWithString:@"选中照片的数量: " attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSAttributedString *txt=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%lu个",(unsigned long)self.saveIMG.count] attributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]}];
    [mutable appendAttributedString:txt];
    self.tools.txtLabel.attributedText=mutable;
    //NSLog(@"%@",self.saveIMG);
}

/**按钮背景颜色*/
-(void)setBtnColor:(UIColor *)btnColor
{
    _btnColor=btnColor;
    self.tools.determineBtn.backgroundColor=btnColor;
}

/**按钮文字颜色*/
-(void)setBtnTitleColor:(UIColor *)btnTitleColor
{
    _btnTitleColor=btnTitleColor;
    [self.tools.determineBtn setTitleColor:btnTitleColor forState:(UIControlStateNormal)];
}

/**按钮高亮颜色*/
-(void)setBtnTitleHightColor:(UIColor *)btnTitleHightColor
{
    _btnTitleHightColor=btnTitleHightColor;
    [self.tools.determineBtn setTitleColor:btnTitleHightColor forState:(UIControlStateHighlighted)];
}



/**设置选中图片*/


@end
