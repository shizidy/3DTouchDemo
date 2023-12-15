//
//  ThreeDTouchViewController.m
//  3DTouchDemo
//
//  Created by wdyzmx on 2023/12/4.
//

#import "ThreeDTouchViewController.h"
#import "DetailViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ThreeDTouchViewController () <UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ThreeDTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
//    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"pic10.jpg"];
    
//    [self registerForPreviewingWithDelegate:self sourceView:self.view];
    
    // Do any additional setup after loading the view.
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
    // 机型要支持3DTouch，如iPhone6s
    [self registerForPreviewingWithDelegate:self sourceView:cell];

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    // 获取按压的cell
    UITableViewCell *cell = (UITableViewCell *)previewingContext.sourceView;
    // 获取cell的indexPath
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // sourceRect边界外部虚化
    previewingContext.sourceRect = cell.frame;
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.indexPath = indexPath;
    return vc;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    // 详情
    [self showViewController:viewControllerToCommit sender:self];
}

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
