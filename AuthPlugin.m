//
//  AuthPlugin.m
//  欲神幻想 - 激活码验证插件 (最终完美版)
//

#import <UIKit/UIKit.h>
#import <stdlib.h>

// 全局强引用验证窗口，防止被系统自动释放导致界面消失
static UIWindow *authWindow = nil;

#pragma mark - 声明

@interface AuthPlugin : NSObject
+ (instancetype)sharedInstance;
- (void)showActivationUI;
@end

#pragma mark - UI 控制器实现

@interface AuthPluginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton    *activateButton;
@property (nonatomic, strong) UIButton    *quitButton;
@property (nonatomic, strong) UILabel     *statusLabel;

@property (nonatomic, strong) NSDictionary<NSString *, NSNumber *> *codeTable;
@property (nonatomic, strong) NSTimer *countdownTimer;

@end

@implementation AuthPluginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.055 green:0.063 blue:0.098 alpha:1.0];
    
    [self buildActivationCodeTable];
    [self setupUI];
    [self restoreActivationState];
}

- (void)dealloc {
    [_countdownTimer invalidate];
    _countdownTimer = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - 内置50个激活码

- (void)buildActivationCodeTable {
    // 试用卡 (8小时)
    NSArray *trialCodes = @[
        @"TRY-0UL27-ARROI", @"TRY-36DAT-WRKWR", @"TRY-4IXDV-KXQ3W", @"TRY-71L34-2S8AS", @"TRY-9UY70-Q4EJX",
        @"TRY-BC9EO-YOB7D", @"TRY-E1TY6-N3W7M", @"TRY-KK6CM-5S51K", @"TRY-PAYQ1-1G5Y4", @"TRY-ZKEZH-8UAXB"
    ];
    // 天卡 (24小时)
    NSArray *dayCodes = @[
        @"DAY-24BQ4-INER1", @"DAY-48KDJ-1XERS", @"DAY-4VF7G-CKP87", @"DAY-8SHHF-AU8L1", @"DAY-HN4KD-AWY9V",
        @"DAY-J8MHS-A8RA5", @"DAY-MHSXJ-E3MFQ", @"DAY-PHMAM-R0IFI", @"DAY-S9W98-PKYSQ", @"DAY-VGG1B-YU7XX"
    ];
    // 周卡 (7天)
    NSArray *weekCodes = @[
        @"WEK-0SHOK-TH005", @"WEK-2RJG9-212UL", @"WEK-4EU40-OIW0S", @"WEK-C4HLW-3BJWG", @"WEK-DZM9Q-ECOPN",
        @"WEK-PJBZJ-A8TKH", @"WEK-RKI4B-UTJH5", @"WEK-TPKT9-PXNZC", @"WEK-U2F8R-VOI7M", @"WEK-V1PGT-YSBIC"
    ];
    // 月卡 (30天)
    NSArray *monthCodes = @[
        @"MON-37I07-8NN3A", @"MON-8ZMLS-LWFK1", @"MON-ADQU3-MG8NM", @"MON-CN1H4-GHBO9", @"MON-GXOTG-0ONH4",
        @"MON-H95B9-2R8UB", @"MON-N5R5Y-4QMGK", @"MON-PGPET-P5G07", @"MON-VGHO5-F09XZ", @"MON-WW0NC-YVNE9"
    ];
    // 季卡 (90天)
    NSArray *quarterCodes = @[
        @"QTR-3VK2Q-NBEH4", @"QTR-89F86-4DYNQ", @"QTR-92SMS-2ZG4X", @"QTR-BC34Y-8K0C9", @"QTR-HQ2U4-JZQMZ",
        @"QTR-JGR0V-WE6UJ", @"QTR-NZSEW-H3DJC", @"QTR-PB34S-1KSTX", @"QTR-RGH4Q-KEIN2", @"QTR-YGTBR-YJ20Q"
    ];
    
    NSMutableDictionary *table = [NSMutableDictionary dictionary];
    
    for (NSString *code in trialCodes)   { table[code] = @(8 * 60 * 60); }
    for (NSString *code in dayCodes)     { table[code] = @(24 * 60 * 60); }
    for (NSString *code in weekCodes)    { table[code] = @(7 * 24 * 60 * 60); }
    for (NSString *code in monthCodes)   { table[code] = @(30 * 24 * 60 * 60); }
    for (NSString *code in quarterCodes) { table[code] = @(90 * 24 * 60 * 60); }
    
    self.codeTable = [table copy];
}

#pragma mark - UI 搭建

- (void)setupUI {
    UIColor *goldColor = [UIColor colorWithRed:0.93 green:0.78 blue:0.42 alpha:1.0];
    UIColor *darkBgColor = [UIColor colorWithRed:0.11 green:0.12 blue:0.17 alpha:1.0];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"欲神幻想";
    titleLabel.textColor = goldColor;
    titleLabel.font = [UIFont boldSystemFontOfSize:34];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];

    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.text = @"—— 激活码验证 ——";
    subTitleLabel.textColor = [UIColor colorWithWhite:0.62 alpha:1.0];
    subTitleLabel.font = [UIFont systemFontOfSize:14];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:subTitleLabel];

    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = darkBgColor;
    textField.textColor = [UIColor whiteColor];
    textField.tintColor = goldColor;
    textField.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.returnKeyType = UIReturnKeyGo;
    textField.delegate = self;
    textField.layer.cornerRadius = 12.0;
    textField.layer.borderWidth = 1.0;
    textField.layer.borderColor = [UIColor colorWithWhite:0.28 alpha:1.0].CGColor;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入激活码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.45 alpha:1.0]}];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textField];
    self.codeTextField = textField;

    UIButton *activateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [activateBtn setTitle:@"激  活" forState:UIControlStateNormal];
    [activateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    activateBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    activateBtn.backgroundColor = goldColor;
    activateBtn.layer.cornerRadius = 12.0;
    activateBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [activateBtn addTarget:self action:@selector(activateButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activateBtn];
    self.activateButton = activateBtn;

    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [quitBtn setTitle:@"退出游戏" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor colorWithWhite:0.85 alpha:1.0] forState:UIControlStateNormal];
    quitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    quitBtn.backgroundColor = darkBgColor;
    quitBtn.layer.cornerRadius = 12.0;
    quitBtn.layer.borderWidth = 1.0;
    quitBtn.layer.borderColor = [UIColor colorWithWhite:0.28 alpha:1.0].CGColor;
    quitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [quitBtn addTarget:self action:@selector(quitGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitBtn];
    self.quitButton = quitBtn;

    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.textColor = [UIColor systemGreenColor];
    statusLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.numberOfLines = 0;
    statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:statusLabel];
    self.statusLabel = statusLabel;

    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"试用卡 8 小时 · 天卡 1 天 · 周卡 7 天\n月卡 30 天 · 季卡 90 天\n有效期自首次激活起计算";
    tipLabel.textColor = [UIColor colorWithWhite:0.42 alpha:1.0];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.numberOfLines = 0;
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tipLabel];

    UILayoutGuide *safe = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.centerXAnchor constraintEqualToAnchor:safe.centerXAnchor],
        [titleLabel.topAnchor constraintEqualToAnchor:safe.topAnchor constant:70],
        [subTitleLabel.centerXAnchor constraintEqualToAnchor:safe.centerXAnchor],
        [subTitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:10],
        [textField.centerXAnchor constraintEqualToAnchor:safe.centerXAnchor],
        [textField.topAnchor constraintEqualToAnchor:subTitleLabel.bottomAnchor constant:50],
        [textField.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor constant:36],
        [textField.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor constant:-36],
        [textField.heightAnchor constraintEqualToConstant:54],
        [activateBtn.centerXAnchor constraintEqualToAnchor:safe.centerXAnchor],
        [activateBtn.topAnchor constraintEqualToAnchor:textField.bottomAnchor constant:26],
        [activateBtn.leadingAnchor constraintEqualToAnchor:textField.leadingAnchor],
        [activateBtn.trailingAnchor constraintEqualToAnchor:textField.trailingAnchor],
        [activateBtn.heightAnchor constraintEqualToConstant:52],
        [quitBtn.centerXAnchor constraintEqualToAnchor:safe.centerXAnchor],
        [quitBtn.topAnchor constraintEqualToAnchor:activateBtn.bottomAnchor constant:16],
        [quitBtn.leadingAnchor constraintEqualToAnchor:textField.leadingAnchor],
        [quitBtn.trailingAnchor constraintEqualToAnchor:textField.trailingAnchor],
        [quitBtn.heightAnchor constraintEqualToConstant:52],
        [statusLabel.centerXAnchor constraintEqualToAnchor:safe.centerXAnchor],
        [statusLabel.topAnchor constraintEqualToAnchor:quitBtn.bottomAnchor constant:26],
        [statusLabel.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor constant:30],
        [statusLabel.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor constant:-30],
        [tipLabel.centerXAnchor constraintEqualToAnchor:safe.centerXAnchor],
        [tipLabel.bottomAnchor constraintEqualToAnchor:safe.bottomAnchor constant:-24]
    ]];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard { [self.view endEditing:YES]; }

#pragma mark - 激活核心逻辑

- (void)activateButtonTapped {
    [self.view endEditing:YES];
    NSString *input = self.codeTextField.text ?: @"";
    input = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    input = [input uppercaseString];

    if (input.length == 0) { [self activationFailed]; return; }

    NSNumber *durationNum = self.codeTable[input];
    if (durationNum == nil) { [self activationFailed]; return; } 

    // 激活成功
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval expireAt = now + durationNum.doubleValue;

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:input forKey:@"YS_ActivationCode"];
    [ud setDouble:now forKey:@"YS_ActivationTime"];
    [ud setDouble:expireAt forKey:@"YS_ExpireTime"];
    [ud synchronize];

    self.activateButton.enabled = NO;
    self.codeTextField.enabled = NO;
    [self startCountdown];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *expireString = [fmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:expireAt]];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"激活成功" message:[NSString stringWithFormat:@"恭喜，激活成功！\n\n到期时间：%@", expireString] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"开始游戏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 销毁验证窗口，彻底进入游戏
        authWindow.hidden = YES;
        authWindow.rootViewController = nil;
        authWindow = nil;
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

// 激活失败直接退出游戏
- (void)activationFailed {
    self.statusLabel.textColor = [UIColor systemRedColor];
    self.statusLabel.text = @"激活码无效，游戏即将退出…";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0); // 杀进程退出游戏
    });
}

- (void)quitGame {
    [self.view endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0); // 杀进程退出游戏
    });
}

#pragma mark - 状态恢复与倒计时

- (void)restoreActivationState {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *savedCode = [ud stringForKey:@"YS_ActivationCode"];
    NSTimeInterval expireAt = [ud doubleForKey:@"YS_ExpireTime"];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];

    if (savedCode.length == 0) return;

    self.codeTextField.text = savedCode;
    if (expireAt > now) {
        self.codeTextField.enabled = NO;
        self.activateButton.enabled = NO;
        [self startCountdown];
    } else {
        self.statusLabel.textColor = [UIColor systemRedColor];
        self.statusLabel.text = @"激活码已过期，请重新输入激活码";
    }
}

- (void)startCountdown {
    [self.countdownTimer invalidate];
    self.countdownTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(tickCountdown) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.countdownTimer forMode:NSRunLoopCommonModes];
    [self tickCountdown];
}

- (void)tickCountdown {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSTimeInterval expireAt = [ud doubleForKey:@"YS_ExpireTime"];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval remain = expireAt - now;

    if (remain <= 0) {
        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
        self.statusLabel.textColor = [UIColor systemRedColor];
        self.statusLabel.text = @"激活已过期，请重新输入激活码";
        self.codeTextField.enabled = YES;
        self.activateButton.enabled = YES;
        return;
    }

    self.statusLabel.textColor = [UIColor systemGreenColor];
    NSInteger total = (NSInteger)remain;
    NSInteger day = total / 86400;
    NSInteger hour = (total % 86400) / 3600;
    NSInteger min = (total % 3600) / 60;
    NSInteger sec = total % 60;
    
    if (day > 0) {
        self.statusLabel.text = [NSString stringWithFormat:@"剩余时长：%ld天 %02ld:%02ld:%02ld", (long)day, (long)hour, (long)min, (long)sec];
    } else {
        self.statusLabel.text = [NSString stringWithFormat:@"剩余时长：%02ld:%02ld:%02ld", (long)hour, (long)min, (long)sec];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self activateButtonTapped];
    return YES;
}

@end


#pragma mark - AuthPlugin 入口类

@implementation AuthPlugin

+ (instancetype)sharedInstance {
    static AuthPlugin *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AuthPlugin alloc] init];
    });
    return instance;
}

- (void)showActivationUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (authWindow != nil && !authWindow.hidden) return;
        
        authWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        authWindow.windowLevel = UIWindowLevelAlert + 2000; 
        authWindow.backgroundColor = [UIColor blackColor];
        
        AuthPluginViewController *vc = [[AuthPluginViewController alloc] init];
        authWindow.rootViewController = vc;
        authWindow.hidden = NO;
        
        [authWindow makeKeyAndVisible];
    });
}

@end

#pragma mark - 插件自动启动拦截 (静默放行版)

__attribute__((constructor))
static void auto_init_auth_plugin() {
    // 1. 插件加载的第一时间，立刻读取本地存储的到期时间
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSTimeInterval expireAt = [ud doubleForKey:@"YS_ExpireTime"];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    
    // 2. 核心逻辑：如果在有效期内，直接 return，什么都不做，静默进入游戏！
    if (expireAt > now) {
        NSLog(@"[AuthPlugin] 验证通过，当前在有效期内，静默放行。剩余秒数: %f", (expireAt - now));
        return; 
    }
    
    // 3. 只有没激活，或者已过期，才执行下面的拦截逻辑
    NSLog(@"[AuthPlugin] 未激活或已过期，准备拦截并弹窗。");
    
    // 监听应用启动完成，等游戏引擎渲染出基础画面后，再进行弹窗拦截
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note) {
        
        // 延迟 1 秒，防止跟游戏的启动 Logo / 闪屏 发生 UI 冲突
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 再次防御性检查：如果在这一秒内刚好被激活了，就不弹了
            NSUserDefaults *ud2 = [NSUserDefaults standardUserDefaults];
            if ([ud2 doubleForKey:@"YS_ExpireTime"] > [[NSDate date] timeIntervalSince1970]) {
                return;
            }
            
            // 强行弹出拦截窗口
            [[AuthPlugin sharedInstance] showActivationUI];
        });
    }];
    
    // 4. 针对玩家挂后台的情况：如果切出去很久，切回来时刚好过期了，也要弹窗拦截
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note) {
        
        NSUserDefaults *ud3 = [NSUserDefaults standardUserDefaults];
        NSTimeInterval expire = [ud3 doubleForKey:@"YS_ExpireTime"];
        NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
        
        // 如果已过期，且当前没有弹窗，则强行弹出
        if (expire <= current && (authWindow == nil || authWindow.hidden)) {
            [[AuthPlugin sharedInstance] showActivationUI];
        }
    }];
}
