//
//  MessageTableViewController.m
//  yh
//
//  Created by andy on 15/10/29.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "MessageTableViewController.h"
#import "YHChartCell.h"
#import "YHStatus.h"

//#define identifier1 @"MyMessage"
//#define identifier2 @"OthersMessage"
@interface MessageTableViewController ()<UITableViewDataSource, UITableViewDelegate,SegViewProtocol>

@end

@implementation MessageTableViewController
{
    NSMutableArray *tableName;
    NSMutableArray *tableMessage;
    NSMutableArray *tableImage;
    NSMutableArray *tableTimer;
    NSMutableArray *tableSource;
    NSMutableArray *_status;
}
- (void) show {
    
}

- (void) hide {
    [self.tableView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Title"];
    
    NSLog(@"changeButton");
    
    [self initData1];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YHChartCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:[YHChartCell identifier]];
    NSLog(@"REGISTERED");
    
        //[self.tableView registerNib:[UINib nibWithNibName:@"chartcell2" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:[YHChartCell identifier]];
    self.tableView.delegate =  self;
    self.tableView.dataSource = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)initData1{
    tableName=[NSMutableArray arrayWithObjects:@"张三",@"李四",nil];
    
    tableMessage=[NSMutableArray arrayWithObjects:@"今天天气好好好好😀",@"谢谢！！", nil];
    
    tableImage=[NSMutableArray arrayWithObjects:@"张三.jpg",@"李四.jpg",nil];
    
    tableTimer=[NSMutableArray arrayWithObjects:@"09:34",@"10:20", nil];
    
    tableSource=[NSMutableArray arrayWithObjects:@"奥迪",@"奇瑞QQ", nil];
}

-(void)initData2{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"StatusInfo" ofType:@"plist"];
    NSArray *array=[NSArray arrayWithContentsOfFile:path];
    _status=[[NSMutableArray alloc]init];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        [_status addObject:[YHStatus staticinitwithYHstatusdic:obj]];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableName count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHChartCell *cell = (YHChartCell *)[tableView dequeueReusableCellWithIdentifier:[YHChartCell identifier] forIndexPath:indexPath];
    
    cell.userName.text=[tableName objectAtIndex:indexPath.row];
    cell.userMessage.text=[tableMessage objectAtIndex:indexPath.row];
    cell.userSource.text=[tableSource objectAtIndex:indexPath.row];
    cell.userTimer.text=[tableTimer objectAtIndex:indexPath.row];
    cell.userImage.image=[UIImage imageNamed:[tableImage objectAtIndex:indexPath.row]];
    //cell.textLabel.text = @"消息";
    
    // Configure the cell...
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 97;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableImage removeObjectAtIndex:indexPath.row];
        [tableMessage removeObjectAtIndex:indexPath.row];
        [tableName removeObjectAtIndex:indexPath.row];
        [tableSource removeObjectAtIndex:indexPath.row];
        [tableTimer removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
