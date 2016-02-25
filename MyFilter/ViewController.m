//
//  ViewController.m
//  MyFilter
//
//  Created by WangMinglang on 16/2/25.
//  Copyright © 2016年 好价. All rights reserved.
//

#import "ViewController.h"
#import "ImageUtil.h"
#import "ColorMatrix.h"

@interface ViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *filterView;

@property (nonatomic, strong) UILabel *filterLabel;

@property (nonatomic, strong) UIImagePickerController *picker;

@property (nonatomic, strong) UIImage *originImage;

@end

@implementation ViewController

- (UIImageView *)filterView
{
    if (_filterView == nil) {
        _filterView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 50.0f, self.view.frame.size.width, 200.0f)];
        _filterView.userInteractionEnabled = YES;
        _filterView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _filterView;
}

- (UILabel *)filterLabel
{
    if (_filterLabel == nil) {
        _filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 300.0f, self.view.frame.size.width, 25.0f)];
        _filterLabel.backgroundColor = [UIColor clearColor];
        _filterLabel.textColor = [UIColor orangeColor];
        _filterLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _filterLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"滤镜";
    self.view.backgroundColor = [UIColor grayColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.filterView.image = [UIImage imageNamed:@"bianjitupian.png"];
    self.originImage = [UIImage imageNamed:@"bianjitupian.png"];
    [self.view addSubview:self.filterView];
    
    self.filterLabel.text = @"原图";
    [self.view addSubview:self.filterLabel];
    
    [self addButton];
    
}

- (void)addButton {
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    [sender setTitle:@"滤镜" forState:UIControlStateNormal];
    sender.frame = CGRectMake(self.view.frame.size.width/2.0f - 50.0f, 350.0f, 100.0f, 30.0f);
    sender.backgroundColor = [UIColor redColor];
    sender.layer.cornerRadius = 5.0f;
    [sender addTarget:self action:@selector(senderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender];
    
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton setTitle:@"相机" forState:UIControlStateNormal];
    cameraButton.frame = CGRectMake(self.view.frame.size.width/2.0f - 50.0f, 400, 100, 30);
    cameraButton.backgroundColor = [UIColor redColor];
    cameraButton.layer.cornerRadius = 5.0f;
    [cameraButton addTarget:self action:@selector(openCameraAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
    
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton setTitle:@"相册" forState:UIControlStateNormal];
    photoButton.frame = CGRectMake(self.view.frame.size.width/2.0f - 50.0f, 450, 100, 30);
    photoButton.backgroundColor = [UIColor redColor];
    photoButton.layer.cornerRadius = 5.0f;
    [photoButton addTarget:self action:@selector(openPhotosLib) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoButton];
    

}

#pragma mark - senderAction 按钮点击事件
- (void)senderAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"滤镜" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"原图",@"LOMO",@"黑白",@"复古",@"哥特",@"锐化",@"淡雅",@"酒红",@"清宁",@"浪漫",@"光晕",@"蓝调",@"梦幻",@"夜色", nil];
    [actionSheet showInView:self.view];
}

//打开相机
- (void)openCameraAction {
#if TARGET_IPHONE_SIMULATOR
    return;
#else
    if (!self.picker) {
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
    }
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.picker animated:YES completion:nil];
#endif
}

//打开相册
- (void)openPhotosLib {
    if (!self.picker) {
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
    }
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    self.filterView.image = image;
    self.originImage = image;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *str = @"";
    switch (buttonIndex) {
        case 0:
            str = @"原图";
            self.filterView.image = self.originImage;
            break;
        case 1:
            str = @"LOMO";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_lomo];
            break;
        case 2:
            str = @"黑白";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_heibai];
            break;
        case 3:
            str = @"复古";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_huajiu];
            break;
        case 4:
            str = @"哥特";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_gete];
            break;
        case 5:
            str = @"锐化";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_ruise];
            break;
        case 6:
            str = @"淡雅";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_danya];
            break;
        case 7:
            str = @"酒红";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_jiuhong];
            break;
        case 8:
            str = @"清宁";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_qingning];
            break;
        case 9:
            str = @"浪漫";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_langman];
            break;
        case 10:
            str = @"光晕";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_guangyun];
            break;
        case 11:
            str = @"蓝调";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_landiao];
            break;
        case 12:
            str = @"梦幻";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_menghuan];
            break;
        case 13:
            str = @"夜色";
            self.filterView.image = [ImageUtil imageWithImage:self.originImage withColorMatrix:colormatrix_yese];
            break;
            
        default:
            break;
    }
    
    self.filterLabel.text = str;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
