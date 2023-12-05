//
//  ContextMenuInteractionViewController.m
//  3DTouchDemo
//
//  Created by hxbank on 2023/12/5.
//

#import "ContextMenuInteractionViewController.h"
#import "ScreenshotTableViewController.h"
#import "MenuListViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ContextMenuInteractionViewController () <UITableViewDelegate, UITableViewDataSource, UIContextMenuInteractionDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *previewImageView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UISwitch *switch1;
@property (nonatomic, strong) UISwitch *switch2;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ContextMenuInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.view addSubview:self.tableView];
    
    // 添加imageView
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 100 / 2, 80, 100, 100)];
    [self.view addSubview:self.imageView];
    // 一定要开启userInteractionEnabled
    self.imageView.userInteractionEnabled = YES;
    self.imageView.image = [UIImage imageNamed:@"pic10.jpg"];
    
    UIContextMenuInteraction *interaction = [[UIContextMenuInteraction alloc] initWithDelegate:self];
    [self.imageView addInteraction:interaction];
    
    // 添加previewImageView
    self.previewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 200 / 2, CGRectGetMaxY(self.imageView.frame) + 10, 200, 200)];
    [self.view addSubview:self.previewImageView];
    self.previewImageView.image = [UIImage imageNamed:@"pic8.jpg"];
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Normal", @"View B", @"Controller"]];
    self.segmentedControl.frame = CGRectMake(20, CGRectGetMaxY(self.previewImageView.frame) + 10, kScreenWidth - 40, 50);
    [self.view addSubview:self.segmentedControl];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.segmentedControl.frame) + 10, 200, 50)];
    [self.view addSubview:label1];
    label1.text = @"子菜单预主菜单并页显示";
    label1.textAlignment = NSTextAlignmentLeft;
    self.switch1 = [[UISwitch alloc] init];
    [self.view addSubview:self.switch1];
    CGPoint point1 = label1.center;
    point1.x = kScreenWidth - 10 - 35;
    self.switch1.center = point1;
    [self.switch1 addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label1.frame) + 10, 200, 50)];
    [self.view addSubview:label2];
    label2.text = @"设置dismiss预览视图";
    label2.textAlignment = NSTextAlignmentLeft;
    self.switch2 = [[UISwitch alloc] init];
    [self.view addSubview:self.switch2];
    CGPoint point2 = label2.center;
    point2.x = kScreenWidth - 10 - 35;
    self.switch2.center = point2;
    [self.switch2 addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(label2.frame) + 20, kScreenWidth - 40, 50)];
    [self.view addSubview:button];
    [button setTitle:@"在tableView和collectionView中的应用" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

- (void)segmentedControlValueChanged:(UISegmentedControl *)control {
    NSLog(@"%ld", (long)control.selectedSegmentIndex);
}

- (void)switchValueChanged:(UISwitch *)sender {
    NSLog(@"%ld", (long)sender.on);
}

- (void)buttonAction:(UIButton *)btn {
    MenuListViewController *vc = [[MenuListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行", indexPath.row];

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UIContextMenuInteractionDelegate
- (UIContextMenuConfiguration *)contextMenuInteraction:(UIContextMenuInteraction *)interaction configurationForMenuAtLocation:(CGPoint)location {
    // 预览控制器提供者
    UIContextMenuContentPreviewProvider previewProvider = nil;
    if (self.segmentedControl.selectedSegmentIndex == 2) {
        previewProvider = ^UIViewController * _Nullable{
            return [[ScreenshotTableViewController alloc] init];
        };
    }
    
    // 菜单栏提供者
    UIContextMenuActionProvider actionProvider = ^UIMenu * _Nullable(NSArray<UIMenuElement *> * _Nonnull suggestedActions) {
        // 创建子菜单
        UIAction *copyAction = [UIAction actionWithTitle:@"Copy" image:[UIImage systemImageNamed:@"doc.on.doc"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            NSLog(@"%s", __func__);
        }];
        
        UIAction *duplicateAction = [UIAction actionWithTitle:@"Duplicate" image:[UIImage systemImageNamed:@"plus.square.on.square"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            NSLog(@"%s", __func__);
        }];
        
        // 黑色样式、不展开子菜单
        UIMenu *edit = [UIMenu menuWithTitle:@"Edit" children:@[copyAction,duplicateAction]];
        if (self.switch1.on) {
            // options UIMenuOptionsDisplayInline 黑色样式，自动展开子菜单
            // options UIMenuOptionsDestructive 红色样式，不展开子菜单
            edit = [UIMenu menuWithTitle:@"Edit"
                                           image:[UIImage systemImageNamed:@"pencil.and.outline"]
                                      identifier:@"edit"
                                         options:UIMenuOptionsDisplayInline
                                        children:@[copyAction,duplicateAction]];
        }
        
        // 主菜单
        UIAction *shareAction = [UIAction
                                 actionWithTitle:@"Share"
                                 image:[UIImage systemImageNamed:@"square.and.arrow.up"]
                                 identifier:@""
                                 handler:^(__kindof UIAction * _Nonnull action) {
            NSLog(@"%s", __func__);
        }];
        UIAction *deleteAction = [UIAction
                                  actionWithTitle:@"Delete"
                                  image:[UIImage systemImageNamed:@"trash"]
                                  identifier:@""
                                  handler:^(__kindof UIAction * _Nonnull action) {
            NSLog(@"%s", __func__);
        }];
        deleteAction.attributes = UIMenuElementAttributesDestructive;
        
        return [UIMenu menuWithTitle:@"" children:@[edit, shareAction, deleteAction]];
    };
    
    UIContextMenuConfiguration *menuConfig = [UIContextMenuConfiguration configurationWithIdentifier:@"menu" previewProvider:previewProvider actionProvider:actionProvider];
    return menuConfig;
}

//MARK: - 可选代理方法
/// 返回触发菜单后，要显示的预览目标视图，默认(不实现或返回nil)为触发菜单的视图(imgView)
- (nullable UITargetedPreview *)contextMenuInteraction:(UIContextMenuInteraction *)interaction previewForHighlightingMenuWithConfiguration:(UIContextMenuConfiguration *)configuration {
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        return [[UITargetedPreview alloc] initWithView:self.previewImageView]; // 显示previewImageView
    }
    
    return nil; // 显示imgView
}

/// 返回dismiss时的预览目标视图
- (nullable UITargetedPreview *)contextMenuInteraction:(UIContextMenuInteraction *)interaction previewForDismissingMenuWithConfiguration:(UIContextMenuConfiguration *)configuration {
    if (self.switch2.on) {
        return [[UITargetedPreview alloc] initWithView: self.previewImageView];
    }
    
    return nil;
}

// MARK: - Menu Life Cycle Observer
/// 当交互将要“提交”,以响应用户点击 "预览" 时调用。
- (void)contextMenuInteraction:(UIContextMenuInteraction *)interaction willPerformPreviewActionForMenuWithConfiguration:(UIContextMenuConfiguration *)configuration animator:(id<UIContextMenuInteractionCommitAnimating>)animator {
    NSLog(@"willPerformPreviewAction");
}

/// 将要显示菜单时调用(先调用后显示)
- (void)contextMenuInteraction:(UIContextMenuInteraction *)interaction willDisplayMenuForConfiguration:(UIContextMenuConfiguration *)configuration animator:(nullable id<UIContextMenuInteractionAnimating>)animator {
    NSLog(@"willDisplayMenu");
}

/// 交互即将结束时调用（隐藏菜单前调用）
- (void)contextMenuInteraction:(UIContextMenuInteraction *)interaction willEndForConfiguration:(UIContextMenuConfiguration *)configuration animator:(nullable id<UIContextMenuInteractionAnimating>)animator {
    NSLog(@"willEnd");
}

//MARK: - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
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
