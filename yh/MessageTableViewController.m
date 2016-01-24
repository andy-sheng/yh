//
//  MessageTableViewController.m
//  yh
//
//  Created by andy on 15/10/29.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "MessageTableViewController.h"
#import "ChatTogetherController.h"
#import "YHChartCell.h"
#import "YHStatus.h"
#import "YHConfig.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface MessageTableViewController ()<UITableViewDataSource, UITableViewDelegate,SegViewProtocol>
@end

@implementation MessageTableViewController
@synthesize status=_status;
@synthesize initdata=init_data;
- (void) show {

}

- (void) hide {
    [self.tableView removeFromSuperview];
}

- (void)viewDidLoad {

    //UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Title"];
    [super viewDidLoad];
    NSLog(@"changeButton");
    [self initData];
    NSLog(@"REGISTERED");

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.delegate =  self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"YHChartCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:[YHChartCell identifier]];
    }

-(void)initData{
    NSString *path=[NSString stringWithFormat:@"%@%s",SERVER_ADDR,"indi_message.json"];
    NSLog(@"%@",path);
    //AFHTTPRequestOperationManager *operation=[AFHTTPRequestOperationManager manager];

    NSURL *url=[NSURL URLWithString:path];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        init_data=(NSDictionary*)responseObject;

        _status=[[NSMutableArray alloc]init];
        int j=(int)[init_data[@"message"] count];
        NSLog(@"%d",j);
        for(int i=0;i<j;i++)
        {
            [_status addObject:[YHStatus staticinitwithYHstatusdic:init_data[@"message"][i]]];
        }
        [self.tableView reloadData];

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"cannot get the initial message data" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    int a =(int)_status.count;
    NSLog(@"%d",a);
    if (a==0)
    {
        NSLog(@"WRONG!没有消息了");
    }
    [operation start];
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
    int a =(int)_status.count;
    NSLog(@"%d",a);
    if (a==0)
    {
        NSLog(@"wRONG!");
        return 0;
    }
    else
        return _status.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHChartCell *cell = (YHChartCell *)[tableView dequeueReusableCellWithIdentifier:[YHChartCell identifier] forIndexPath:indexPath];
    YHStatus *cells=[_status objectAtIndex:indexPath.row];
    cell.userName.text=cells.userNameData;
    NSLog(@"%@",cells.userNameData);
    cell.userMessage.text=cells.usertextData;
     NSLog(@"%@",cells.usertextData);
    cell.userSource.text=cells.userSourceData;
     NSLog(@"%@",cells.userSourceData);
    cell.userTimer.text=cells.userCreateAtData;
     NSLog(@"%@",cells.userCreateAtData);


    NSString *path_image=[NSString stringWithFormat:@"%@%@",SERVER_ADDR,cells.userImageData];
    NSURL *url=[NSURL URLWithString:path_image];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];

    UIImage *placeholderImage=[UIImage imageNamed:@"idontknowwhy"];
    __weak UITableViewCell *weakCell=cell;

    [cell.imageView setImageWithURLRequest:request placeholderImage:placeholderImage success:
     ^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        weakCell.imageView.image=image;
        [weakCell setNeedsLayout];
         [weakCell updateConstraints];
    } failure:nil];
    //cell.textLabel.text = @"消息";

    // Configure the cell...

    return cell;
}
- (UIViewController*)loadViewControllerWithStoryBoard:(NSString*)storyBoardName Identifier:(NSString*) identifier{
    return [[UIStoryboard storyboardWithName:storyBoardName bundle:nil] instantiateViewControllerWithIdentifier:identifier];
}
- (UIViewController*)getBarBtnResponder{
    return [self loadViewControllerWithStoryBoard:@"Message" Identifier:@"chatTogether"];
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
        [_status removeObjectAtIndex:indexPath.row];
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
