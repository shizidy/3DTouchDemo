//
//  ViewController.m
//  3DTouchDemo
//
//  Created by hxbank on 2023/12/4.
//

#import "ViewController.h"
#import "ThreeDTouchViewController.h"
#import "ContextMenuInteractionViewController.h"
#import "ScreenshotTableViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    [self.view addSubview:button1];
    button1.backgroundColor = [UIColor redColor];
    button1.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2 - 150);
    [button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"3DTouch方式" forState:UIControlStateNormal];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    [self.view addSubview:button2];
    button2.backgroundColor = [UIColor redColor];
    button2.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2 - 150 + 60);
    [button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"ContextMenuInteraction方式" forState:UIControlStateNormal];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    [self.view addSubview:button3];
    button3.backgroundColor = [UIColor redColor];
    button3.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2 - 150 + 60 + 60);
    [button3 addTarget:self action:@selector(button3Action:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitle:@"全屏截图生成PDF" forState:UIControlStateNormal];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)button1Action:(UIButton *)btn {
    ThreeDTouchViewController *viewController = [[ThreeDTouchViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)button2Action:(UIButton *)btn {
    ContextMenuInteractionViewController *viewController = [[ContextMenuInteractionViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)button3Action:(UIButton *)btn {
    ScreenshotTableViewController *viewController = [[ScreenshotTableViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

//- (nullable UIContextMenuConfiguration *)contextMenuInteraction:(nonnull UIContextMenuInteraction *)interaction configurationForMenuAtLocation:(CGPoint)location {
//    <#code#>
//}


@end
