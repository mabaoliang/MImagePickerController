# MImagePickerController
直接将photo文件拖入项目使用
引入 #import"IMGCollectionViewController"
   
   方法一：
           IMGCollectionViewController *vc=[[IMGCollectionViewController alloc]initController:3 block:^(NSArray *arrIMG) {
                NSLog(@"%@",arrIMG);
            }];
             [self.navigationController pushViewController:vc animated:YES];
            
    方法二：
            IMGCollectionViewController *vc=[[IMGCollectionViewController alloc]initController:3];
            vc.btnColor=[UIColor purpleColor];
            vc.delegate=self;
            [self.navigationController pushViewController:vc animated:YES];
            
      //代理方法
            -(void)IMGCollectionViewController:(NSArray *)imgArr
{
    NSLog(@"%@",imgArr);
}
        
