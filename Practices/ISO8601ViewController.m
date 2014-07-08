//
//  ISO8601ViewController.m
//  Practices
//
//  Created by Neo on 7/8/14.
//  Copyright (c) 2014 Paradigm X. All rights reserved.
//

#import "ISO8601ViewController.h"
#import "ISO8601DateFormatter.h"

@interface ISO8601ViewController ()
- (IBAction)parse:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UILabel *labelYear;
@property (weak, nonatomic) IBOutlet UILabel *labelMonth;
@property (weak, nonatomic) IBOutlet UILabel *labelDay;
@property (weak, nonatomic) IBOutlet UILabel *labelHour;
@property (weak, nonatomic) IBOutlet UILabel *labelMinute;
@property (weak, nonatomic) IBOutlet UILabel *labelSecond;
@property (weak, nonatomic) IBOutlet UILabel *labelTZ;
@end

@implementation ISO8601ViewController

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

    [_dateTextField setText:@"2013-06-05T14:10:43.678Z"];
    [_dateTextField setText:@"2013-02-03T19:54:00-0800"];
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

- (IBAction)parse:(id)sender {
    NSString *dateString = [[_dateTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
    NSTimeZone *tz;
    NSDate *date = [formatter dateFromString:dateString timeZone:&tz];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];

    if (tz) {
        [gregorian setTimeZone:tz];
    }

    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSTimeZoneCalendarUnit;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:date];

    [_labelYear setText:[@([components year]) stringValue]];
    [_labelMonth setText:[@([components month]) stringValue]];
    [_labelDay setText:[@([components day]) stringValue]];
    [_labelHour setText:[@([components hour]) stringValue]];
    [_labelMinute setText:[@([components minute]) stringValue]];
    [_labelSecond  setText:[@([components second]) stringValue]];

    tz = [components timeZone];
    [_labelTZ setText:[[tz name] stringByAppendingFormat:@"(%@)", [tz abbreviation]]];
}
@end
