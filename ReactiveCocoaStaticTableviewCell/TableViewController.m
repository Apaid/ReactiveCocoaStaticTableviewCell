//
//  TableViewController.m
//  ReactiveCocoaStaticTableviewCell
//
//  Created by joy on 16/8月/17.
//  Copyright © 2016年 CrazyBadam. All rights reserved.
//

#import "TableViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "TableDataModel.h"
@interface TableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneText;

- (IBAction)doneAction:(id)sender;

- (IBAction)editAction:(id)sender;
@property (strong, nonatomic) TableDataModel *dataModel;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataModel = [TableDataModel new];
    self.dataModel.phone = @"13800000000";
    @weakify(self);
    [RACObserve(self,dataModel) subscribeNext:^(TableDataModel *dataModel) {
        
        @strongify(self);
        self.phoneText.text= dataModel.phone;
        
    }];
    
    //Start Binding our properties
    RAC(self.phoneText,text) = [RACObserve(self.dataModel, phone) distinctUntilChanged];
    
    [[self.phoneText.rac_textSignal distinctUntilChanged] subscribeNext:^(NSString *x) {
        //this creates a reference to self that when used with @weakify(self);
        //makes sure self isn't retained
        @strongify(self);
        self.dataModel.phone = x;
        NSLog(@"%@",x);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

- (IBAction)doneAction:(id)sender {
    NSLog(@"%@",self.dataModel.phone);
}

- (IBAction)editAction:(id)sender {
    self.dataModel.phone = @"0357-123456";
    NSLog(@"%@",self.dataModel.phone);
}
@end
