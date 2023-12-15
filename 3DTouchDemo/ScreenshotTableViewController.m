//
//  ScreenshotTableViewController.m
//  3DTouchDemo
//
//  Created by wdyzmx on 2023/12/5.
//

#import "ScreenshotTableViewController.h"
 
@interface ScreenshotTableViewController () <UIScreenshotServiceDelegate>

@end

@implementation ScreenshotTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.rowHeight = 70;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    UIImage *img = [UIImage imageNamed:@"screenshot"];
    UIImageView *header = [[UIImageView alloc] initWithImage:img];
    header.contentMode = UIViewContentModeCenter;
    header.frame = CGRectMake(0, 0, self.view.bounds.size.width, 500);
    self.tableView.tableHeaderView = header;
    
    // 设置UIScreenshotService代理
    UIScreenshotService *screenshotService = [UIApplication sharedApplication].keyWindow.windowScene.screenshotService;
    screenshotService.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"yanhua"];
    cell.textLabel.text = [NSString stringWithFormat:@"Table View Cell For Row At [%zi, %zi]", indexPath.section, indexPath.row];
    return cell;
}

// MARK: - UIScreenshotServiceDelegate
- (void)screenshotService:(UIScreenshotService *)screenshotService generatePDFRepresentationWithCompletion:(void (^)(NSData * _Nullable, NSInteger, CGRect))completionHandler {
    // 临时更改self.tableView.frame的frame，保证tableView能够完整的渲染出来
    CGRect frame = self.tableView.frame;
    CGRect toframe = frame;
    toframe.size = self.tableView.contentSize;
    self.tableView.frame = toframe;
    
    // 将table view 渲染成PDF,参考：
    // https://stackoverflow.com/questions/5443166/how-to-convert-uiview-to-pdf-within-ios/6566696#6566696
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, self.tableView.frame, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    [self.tableView.layer renderInContext:pdfContext];

    UIGraphicsEndPDFContext();
    
    // 恢复tableView frame
    self.tableView.frame = frame;

    // 输入PDF
    completionHandler(pdfData, 1, self.tableView.bounds);
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
