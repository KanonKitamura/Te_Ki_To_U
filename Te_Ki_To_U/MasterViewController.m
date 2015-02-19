//
//  MasterViewController.m
//  Te_Ki_To_U
//
//  Created by kanon kitamura on 2015/02/19.
//  Copyright (c) 2015年 myname. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()



@property NSMutableArray *objects;
@end

/*①NSMutableArrayは、数が固定されているNSArrayとは違って、
 あとから追加したり削除したりできます。
 ②「objects」という変数名の前に「_(アンダースコア)」がついていますが、
 これはインスタンス変数を宣言するときに、通常の変数の宣言と
 区別するために付けられることがあります。
 ③.mのファイルの中に、使用する宣言をしていますが、
 これは”ある変数をこのファイル内でしか使わない”ということが確定している場合、
 .hに書かずに.mに書くと、変数の使用状況をよりわかりやすくするために使われる書き方です。*/

@implementation MasterViewController

-(BOOL)textFieldShouldReturn:(UITextField *)tf{
    insertMode= YES;
    if (!_objects){
        _objects=[[NSMutableArray alloc]init];
    }
    if([textField.text length]>0){
        [_objects insertObject:textField.text atIndex:0];
        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        UIAlertView*alert=[[UIAlertView alloc]
                           initWithTitle:@"未記入"message:@"何も書かれていません。"delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
        [alert show];
    }
    if(blackView){
        [blackView removeFromSuperview];
    }
    [textField resignFirstResponder];
    return  YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    insertMode = YES;//予定追加モードをONにします
    /*①画面の上にある「ナビゲーションバー(UINavigationBar)」に
     コードでボタンを追加しています。
      ②追加ボタンをバーの右側に設置しています。押したときには
     「insertNewObject:)」が呼ばれるように設定されています。
      ③「insertMode」というフラグを立てておいて、連打したときに
     何度もメソッドが呼ばれてしまうのを防ぎます。insertModeは
     「insertNewObject」のif文内で使用します。初期設定はYESにしておきます。*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    
    if (insertMode == YES){
        blackView =[[UIView alloc]initWithFrame:CGRectMake(0,200,320,320)];
       blackView.backgroundColor=[UIColor blackColor];
        textField =[[UITextField alloc]initWithFrame:CGRectMake(25, 25, 270, 40)];
        textField.backgroundColor=[UIColor blackColor];
        textField.delegate=self;
        [blackView addSubview:textField];
        [self.view addSubview:blackView];
        insertMode=NO;
    }else{
        NSLog(@"insertModeになっていません");
    }
    }



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
