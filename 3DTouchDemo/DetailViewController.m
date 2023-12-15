//
//  DetailViewController.m
//  3DTouchDemo
//
//  Created by wdyzmx on 2023/12/4.
//

#import "DetailViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [self.view addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = self.view.center;
    label.text = [NSString stringWithFormat:@"indexPath.row=%ld", self.indexPath.row];
    
    // Do any additional setup after loading the view.
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"收藏" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"收藏");
    }];
        
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"分享" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"分享");
    }];
        
    NSArray *actions = @[action1, action2];
    return actions;
//    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Action 1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
//        // 点击此选项触发
//        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"你查看的是:" message:@"123" preferredStyle:UIAlertControllerStyleActionSheet];
//        UIAlertAction *alert = [UIAlertAction actionWithTitle:@"噢噢" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //
//        }];
//        [alertC addAction:alert];
//
//        // 因为预览视图与根视图不在一个视图层级上，所以需要通过根视图去推出这个
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertC animated:YES completion:^{}];
//    }];
//
//    // 可以添加多个选项
//    NSArray *arr = @[action1];
//    return arr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
