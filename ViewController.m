//
//  ViewController.m
//  demo_FilterEffects
//
//  Created by abner on 2016/11/3.
//  Copyright © 2016年 abner. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (retain,nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation ViewController
{
    int flag;//0 为CISepiaTone 1为CIGaussianBlur
}
- (IBAction)segmentedControl:(id)sender {
    if (_segmentedController.selectedSegmentIndex == 0) {
        [self filterSepiaTone];
    }else
    {
        [self filterGaussianBlur];
    }
}
- (IBAction)sliderBtnClick:(id)sender {
//    if (_segmentedController.selectedSegmentIndex == 0) {
//        [self filterSepiaTone];
//    }
//    else
//    {
//        [self filterGaussianBlur];
//    }
}
#pragma mark - filterSepiaTone 旧色调方法
- (void)filterSepiaTone
{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *cImage = [CIImage imageWithCGImage:[_image CGImage]];
    CIImage *result;
    //创建滤镜
    CIFilter *sepiaToneFilter = [CIFilter filterWithName:@"CISepiaTone"];
    [sepiaToneFilter setValue:cImage forKey:@"inputImage"];
   
    
    
    
    NSString *str = [[NSString alloc]initWithFormat:@"旧色调 Intensity：%.2f",[_slider value]];
    _label.text = str;
    
    
    [sepiaToneFilter setValue:[NSNumber numberWithFloat:[_slider value]] forKey:@"inputIntensity"];
    result = [sepiaToneFilter valueForKey:@"outputImage"];
    CGImageRef imageRef = [context createCGImage:result fromRect:CGRectMake(0, 0, self.imageView.bounds.size.width, self.imageView.bounds.size.height)];
    UIImage *image = [[UIImage alloc]initWithCGImage:imageRef];
    _imageView.image = image;
    flag = 0;
}

#pragma mark - CIGaussianBlur 高斯模糊
- (void)filterGaussianBlur{
    
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *cImage = [CIImage imageWithCGImage:[_image CGImage]];
    CIImage *result;
    //创建滤镜
    CIFilter *gaussianFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussianFilter setValue:cImage forKey:@"inputImage"];
    double value = [_slider value];
    value *= 10;
    
    
    NSString *str = [[NSString alloc]initWithFormat:@"高斯模糊 Radius：%.2f",value];
    _label.text = str;
    
    
    [gaussianFilter setValue:[NSNumber numberWithFloat:value] forKey:@"inputRadius"];
    result = [gaussianFilter valueForKey:@"outputImage"];
    CGImageRef imageRef = [context createCGImage:result fromRect:CGRectMake(0, 0, self.imageView.bounds.size.width, self.imageView.bounds.size.height)];
    UIImage *image = [[UIImage alloc]initWithCGImage:imageRef];
    _imageView.image = image;
    
    flag = 1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //获取图片
    NSURL *url = [NSURL URLWithString:@"http://localhost/V.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _image = [UIImage imageWithData:data];
    _imageView.image = _image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
