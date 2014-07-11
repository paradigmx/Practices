//
//  CharCountViewController.m
//  Practices
//
//  Created by Neo on 7/8/14.
//  Copyright (c) 2014 Paradigm X. All rights reserved.
//

#import "CharCountViewController.h"

@interface CharCountViewController ()
- (IBAction)count:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UITextView *outputTextView;
@end

@implementation CharCountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_inputTextView setText:@"This is a test and we will find many interesting things here."];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSDictionary *)charCountInString:(NSString *)input {
    NSUInteger len = [input length];
    unichar buffer[len+1];
    [input getCharacters:buffer range:NSMakeRange(0, len)];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for(int i = 0; i < len; i++) {
        NSString *key = [NSString stringWithFormat:@"%C", buffer[i]];
        NSNumber *value = [dict valueForKey:key];
        if (value == nil) {
            // First time for this char
            [dict setObject:@1 forKey:key];
        }
        else {
            [dict setObject:@([value intValue]+1) forKey:key];
        }
    }

    return dict;
}

- (IBAction)count:(id)sender {
    [self.view endEditing:YES];

    NSString *input = [[_inputTextView text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    NSDictionary *dict = [self charCountInString:input];
//    NSArray *keys = [dict keysSortedByValueUsingSelector:@selector(compare:)];
    NSArray *keys = [dict keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1]; // Descending
//        return [obj1 compare:obj2]; // Ascending
    }];

    NSMutableArray *lines = [[NSMutableArray alloc] init];
    for (NSString *key in keys) {
        [lines addObject:[NSString stringWithFormat:@"'%@':%d", key, [[dict valueForKey:key] intValue]]];
    }

    [_outputTextView setText:[lines componentsJoinedByString:@"\n"]];
}

@end
