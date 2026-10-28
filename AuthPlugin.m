#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <dlfcn.h>

static NSString * const kKeyActiveCode = @"ActiveAuthCode";
static NSString * const kKeyActiveDevice = @"ActiveAuthDevice";
static NSString * const kKeyActivationTime = @"ActiveAuthTime";
static NSString * const kKeyCodeType = @"ActiveCodeType";

static NSArray *getAuthDatabase() {
    static NSArray *database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        database = @[
            // ===== 欲神幻想 日卡 (100) =====
            @{@"code": @"DAY-COCOF-XBH4D", @"type": @"日卡"}, @{@"code": @"DAY-9Y6L9-41HDN", @"type": @"日卡"}, @{@"code": @"DAY-KH9ZW-H73XU", @"type": @"日卡"}, @{@"code": @"DAY-41EF7-E8F7S", @"type": @"日卡"}, @{@"code": @"DAY-0TO6K-555YE", @"type": @"日卡"}, @{@"code": @"DAY-MSK8B-N2P31", @"type": @"日卡"}, @{@"code": @"DAY-L2PTC-RE9CA", @"type": @"日卡"}, @{@"code": @"DAY-2H7K4-6QM0G", @"type": @"日卡"}, @{@"code": @"DAY-83AIE-VKXCI", @"type": @"日卡"}, @{@"code": @"DAY-EULWH-67W6J", @"type": @"日卡"},
            @{@"code": @"DAY-ULBCJ-SZ6WB", @"type": @"日卡"}, @{@"code": @"DAY-BY0CV-LUJ4E", @"type": @"日卡"}, @{@"code": @"DAY-J4IEY-MWGOO", @"type": @"日卡"}, @{@"code": @"DAY-JKV5C-1JD0E", @"type": @"日卡"}, @{@"code": @"DAY-JH0GL-1T4VH", @"type": @"日卡"}, @{@"code": @"DAY-YB5BJ-6YGLI", @"type": @"日卡"}, @{@"code": @"DAY-O3SCL-G3BCJ", @"type": @"日卡"}, @{@"code": @"DAY-ZV4OG-C1286", @"type": @"日卡"}, @{@"code": @"DAY-UNODC-5KNFR", @"type": @"日卡"}, @{@"code": @"DAY-0EYTY-YJ48H", @"type": @"日卡"},
            @{@"code": @"DAY-87GE4-FVX86", @"type": @"日卡"}, @{@"code": @"DAY-FQ1TZ-AIN35", @"type": @"日卡"}, @{@"code": @"DAY-01G12-5G83J", @"type": @"日卡"}, @{@"code": @"DAY-6F2J6-YO26Q", @"type": @"日卡"}, @{@"code": @"DAY-Q1WZD-E593X", @"type": @"日卡"}, @{@"code": @"DAY-31DQZ-6MW8U", @"type": @"日卡"}, @{@"code": @"DAY-4BB9M-HHWPK", @"type": @"日卡"}, @{@"code": @"DAY-ZXGJD-1VAEE", @"type": @"日卡"}, @{@"code": @"DAY-0LB8T-F92VH", @"type": @"日卡"}, @{@"code": @"DAY-3WFDJ-S9QY9", @"type": @"日卡"},
            @{@"code": @"DAY-LQ5V3-1GXVK", @"type": @"日卡"}, @{@"code": @"DAY-PX4HN-ULGTB", @"type": @"日卡"}, @{@"code": @"DAY-4O7PA-NJEOG", @"type": @"日卡"}, @{@"code": @"DAY-FB6PO-YU5AG", @"type": @"日卡"}, @{@"code": @"DAY-6MBW0-QGY7V", @"type": @"日卡"}, @{@"code": @"DAY-8H43F-6JYSX", @"type": @"日卡"}, @{@"code": @"DAY-TMZHK-RHY3I", @"type": @"日卡"}, @{@"code": @"DAY-T6JZS-JKWU3", @"type": @"日卡"}, @{@"code": @"DAY-R7ZAE-NZ9M3", @"type": @"日卡"}, @{@"code": @"DAY-4PHOW-WC543", @"type": @"日卡"},
            @{@"code": @"DAY-NJDX8-6C3JX", @"type": @"日卡"}, @{@"code": @"DAY-Y44X0-RAHBM", @"type": @"日卡"}, @{@"code": @"DAY-MOTIN-50VXA", @"type": @"日卡"}, @{@"code": @"DAY-M3J63-DQTPB", @"type": @"日卡"}, @{@"code": @"DAY-9GD9F-UOPJ7", @"type": @"日卡"}, @{@"code": @"DAY-LPZ7U-K3I7J", @"type": @"日卡"}, @{@"code": @"DAY-KJQMZ-8AJRN", @"type": @"日卡"}, @{@"code": @"DAY-VRWNV-LCZVT", @"type": @"日卡"}, @{@"code": @"DAY-52L0E-GV268", @"type": @"日卡"}, @{@"code": @"DAY-OCW79-NVWMC", @"type": @"日卡"},
            @{@"code": @"DAY-R96GO-DI2N0", @"type": @"日卡"}, @{@"code": @"DAY-U62FD-85IIF", @"type": @"日卡"}, @{@"code": @"DAY-WIIU3-ZBUXJ", @"type": @"日卡"}, @{@"code": @"DAY-SSV58-GD4ZM", @"type": @"日卡"}, @{@"code": @"DAY-NS52Q-A2VT9", @"type": @"日卡"}, @{@"code": @"DAY-NZBQD-YCGEJ", @"type": @"日卡"}, @{@"code": @"DAY-PN6JN-VW01Q", @"type": @"日卡"}, @{@"code": @"DAY-0Z5TJ-B87P3", @"type": @"日卡"}, @{@"code": @"DAY-HD0OO-D2X0T", @"type": @"日卡"}, @{@"code": @"DAY-KVRV5-K29T2", @"type": @"日卡"},
            @{@"code": @"DAY-DUK1W-H817V", @"type": @"日卡"}, @{@"code": @"DAY-TMUF9-EYXA8", @"type": @"日卡"}, @{@"code": @"DAY-ZVP5Z-1LRI0", @"type": @"日卡"}, @{@"code": @"DAY-7313B-7SMN9", @"type": @"日卡"}, @{@"code": @"DAY-265JL-JOJNO", @"type": @"日卡"}, @{@"code": @"DAY-6DSBR-IBZUV", @"type": @"日卡"}, @{@"code": @"DAY-549L2-HJUV0", @"type": @"日卡"}, @{@"code": @"DAY-HRPHD-BSBJZ", @"type": @"日卡"}, @{@"code": @"DAY-QNFA3-FS77L", @"type": @"日卡"}, @{@"code": @"DAY-31XAY-6BMAX", @"type": @"日卡"},
            @{@"code": @"DAY-GN8TG-W6GJI", @"type": @"日卡"}, @{@"code": @"DAY-7TFQ5-8URLP", @"type": @"日卡"}, @{@"code": @"DAY-KPXZS-UFO51", @"type": @"日卡"}, @{@"code": @"DAY-64JL7-Q4RIY", @"type": @"日卡"}, @{@"code": @"DAY-6JNCM-Y5GDH", @"type": @"日卡"}, @{@"code": @"DAY-ADOC2-715M6", @"type": @"日卡"}, @{@"code": @"DAY-PFNK9-2RJD4", @"type": @"日卡"}, @{@"code": @"DAY-09AG1-173YK", @"type": @"日卡"}, @{@"code": @"DAY-8A4C2-O0YEB", @"type": @"日卡"}, @{@"code": @"DAY-ZAEFY-RDTRQ", @"type": @"日卡"},
            @{@"code": @"DAY-QFNYI-J7Q14", @"type": @"日卡"}, @{@"code": @"DAY-HA7X7-REC3G", @"type": @"日卡"}, @{@"code": @"DAY-PF9QE-B6CNN", @"type": @"日卡"}, @{@"code": @"DAY-NT1CI-3NP5K", @"type": @"日卡"}, @{@"code": @"DAY-KE3HO-UNFTZ", @"type": @"日卡"}, @{@"code": @"DAY-G6DNP-WSA05", @"type": @"日卡"}, @{@"code": @"DAY-SJ02M-FU5SL", @"type": @"日卡"}, @{@"code": @"DAY-OCTZQ-O06UU", @"type": @"日卡"}, @{@"code": @"DAY-UPCWT-3EVCO", @"type": @"日卡"}, @{@"code": @"DAY-1MGCJ-6P3J9", @"type": @"日卡"},
            @{@"code": @"DAY-S5GN9-C889L", @"type": @"日卡"}, @{@"code": @"DAY-I1G8D-YHG6Q", @"type": @"日卡"}, @{@"code": @"DAY-ABRKY-1FQAP", @"type": @"日卡"}, @{@"code": @"DAY-7YBCC-U5C22", @"type": @"日卡"}, @{@"code": @"DAY-UUL8W-TV85Z", @"type": @"日卡"}, @{@"code": @"DAY-KKJ6W-8EYJ1", @"type": @"日卡"}, @{@"code": @"DAY-KJEMU-N52E1", @"type": @"日卡"}, @{@"code": @"DAY-JMPN2-D034K", @"type": @"日卡"}, @{@"code": @"DAY-OGOG1-C8NLA", @"type": @"日卡"}, @{@"code": @"DAY-7B0UY-HRJCZ", @"type": @"日卡"},

            // ===== 欲神幻想 月卡 (100) =====
            @{@"code": @"MON-R1DB1-DEN8R", @"type": @"月卡"}, @{@"code": @"MON-MNF58-8QPU8", @"type": @"月卡"}, @{@"code": @"MON-K5DI7-5YOG0", @"type": @"月卡"}, @{@"code": @"MON-1HYCN-9KPW9", @"type": @"月卡"}, @{@"code": @"MON-RUMHF-A3D92", @"type": @"月卡"}, @{@"code": @"MON-QDEC4-91U6D", @"type": @"月卡"}, @{@"code": @"MON-2RPVX-35UJ2", @"type": @"月卡"}, @{@"code": @"MON-3AMZH-P7OOK", @"type": @"月卡"}, @{@"code": @"MON-N4HCV-L2K99", @"type": @"月卡"}, @{@"code": @"MON-R126W-WZEID", @"type": @"月卡"},
            @{@"code": @"MON-MH0KT-XOW33", @"type": @"月卡"}, @{@"code": @"MON-HQD83-D4WDC", @"type": @"月卡"}, @{@"code": @"MON-LRLF2-6IH6A", @"type": @"月卡"}, @{@"code": @"MON-U7XLY-K777U", @"type": @"月卡"}, @{@"code": @"MON-JTKMG-EHPSW", @"type": @"月卡"}, @{@"code": @"MON-9TNP5-S0WRL", @"type": @"月卡"}, @{@"code": @"MON-TDOZL-JEHIX", @"type": @"月卡"}, @{@"code": @"MON-CRA5B-4KA3H", @"type": @"月卡"}, @{@"code": @"MON-RQC7Z-9PEZC", @"type": @"月卡"}, @{@"code": @"MON-BXDAM-NQ0N9", @"type": @"月卡"},
            @{@"code": @"MON-Y3TDB-78DSQ", @"type": @"月卡"}, @{@"code": @"MON-2W1XA-OPP4S", @"type": @"月卡"}, @{@"code": @"MON-TNRA4-6QRDI", @"type": @"月卡"}, @{@"code": @"MON-PNYLE-GQG6E", @"type": @"月卡"}, @{@"code": @"MON-PK4FJ-Y2J16", @"type": @"月卡"}, @{@"code": @"MON-1U0PS-GP7I7", @"type": @"月卡"}, @{@"code": @"MON-H92CI-MQSI6", @"type": @"月卡"}, @{@"code": @"MON-GY3UE-2PS34", @"type": @"月卡"}, @{@"code": @"MON-86R7V-0KD80", @"type": @"月卡"}, @{@"code": @"MON-SBFC4-MZLDL", @"type": @"月卡"},
            @{@"code": @"MON-UAEYU-V41NG", @"type": @"月卡"}, @{@"code": @"MON-ELQOR-UZ2BC", @"type": @"月卡"}, @{@"code": @"MON-I7TCR-A7KF3", @"type": @"月卡"}, @{@"code": @"MON-ZKETV-1Y2N9", @"type": @"月卡"}, @{@"code": @"MON-2J65E-P5SA7", @"type": @"月卡"}, @{@"code": @"MON-PLH6Y-4F6AL", @"type": @"月卡"}, @{@"code": @"MON-4UZXR-DYG5R", @"type": @"月卡"}, @{@"code": @"MON-XLOGO-2IJQG", @"type": @"月卡"}, @{@"code": @"MON-UZB35-HGOZ9", @"type": @"月卡"}, @{@"code": @"MON-6KGRR-9OZCP", @"type": @"月卡"},
            @{@"code": @"MON-G5PEL-WGVGO", @"type": @"月卡"}, @{@"code": @"MON-ITMMJ-FFK3X", @"type": @"月卡"}, @{@"code": @"MON-ICURI-7HJ40", @"type": @"月卡"}, @{@"code": @"MON-NFH2U-96SS2", @"type": @"月卡"}, @{@"code": @"MON-G288U-LI0N7", @"type": @"月卡"}, @{@"code": @"MON-W2WKU-R1DIJ", @"type": @"月卡"}, @{@"code": @"MON-UV47M-N3C54", @"type": @"月卡"}, @{@"code": @"MON-XT2TZ-VS768", @"type": @"月卡"}, @{@"code": @"MON-7YBWG-EJFRJ", @"type": @"月卡"}, @{@"code": @"MON-KODKP-76DBQ", @"type": @"月卡"},
            @{@"code": @"MON-V88KB-9YSCA", @"type": @"月卡"}, @{@"code": @"MON-KQQJQ-NFBIU", @"type": @"月卡"}, @{@"code": @"MON-WPA8S-6J3HV", @"type": @"月卡"}, @{@"code": @"MON-JH2SF-2QWAV", @"type": @"月卡"}, @{@"code": @"MON-G6D7J-4ZUU1", @"type": @"月卡"}, @{@"code": @"MON-XIN05-NRE5F", @"type": @"月卡"}, @{@"code": @"MON-N3KZ1-BKFLE", @"type": @"月卡"}, @{@"code": @"MON-WZDH7-IE31N", @"type": @"月卡"}, @{@"code": @"MON-ORO04-K79XB", @"type": @"月卡"}, @{@"code": @"MON-LWDQN-83SRA", @"type": @"月卡"},
            @{@"code": @"MON-5Y87M-S8IRL", @"type": @"月卡"}, @{@"code": @"MON-PD2PV-NEOXN", @"type": @"月卡"}, @{@"code": @"MON-VG538-KQHZV", @"type": @"月卡"}, @{@"code": @"MON-TJIIL-1VIKQ", @"type": @"月卡"}, @{@"code": @"MON-STXFY-I5XJM", @"type": @"月卡"}, @{@"code": @"MON-X88TZ-1RBZC", @"type": @"月卡"}, @{@"code": @"MON-NCIJ3-RUNZP", @"type": @"月卡"}, @{@"code": @"MON-OWYE7-EOAMA", @"type": @"月卡"}, @{@"code": @"MON-IO8U2-5O2F1", @"type": @"月卡"}, @{@"code": @"MON-1P36L-KWY7V", @"type": @"月卡"},
            @{@"code": @"MON-CE1F4-BOISJ", @"type": @"月卡"}, @{@"code": @"MON-LHYR6-VHODO", @"type": @"月卡"}, @{@"code": @"MON-CJE94-6TJUP", @"type": @"月卡"}, @{@"code": @"MON-HF64Q-7G5OW", @"type": @"月卡"}, @{@"code": @"MON-WGR71-N0HXZ", @"type": @"月卡"}, @{@"code": @"MON-YPWZB-CMSDE", @"type": @"月卡"}, @{@"code": @"MON-UTB2C-F5IC2", @"type": @"月卡"}, @{@"code": @"MON-HILPA-6LSCR", @"type": @"月卡"}, @{@"code": @"MON-VFVDU-RD71M", @"type": @"月卡"}, @{@"code": @"MON-DKIGU-BVM8Q", @"type": @"月卡"},
            @{@"code": @"MON-U8E49-TJQHU", @"type": @"月卡"}, @{@"code": @"MON-5141Y-2AF7O", @"type": @"月卡"}, @{@"code": @"MON-F0ZYP-UL7S8", @"type": @"月卡"}, @{@"code": @"MON-3OAF6-JJKBN", @"type": @"月卡"}, @{@"code": @"MON-IPR20-8LNFO", @"type": @"月卡"}, @{@"code": @"MON-BC6EO-R4GTZ", @"type": @"月卡"}, @{@"code": @"MON-BC0IK-PWHPL", @"type": @"月卡"}, @{@"code": @"MON-KN13L-26Q3A", @"type": @"月卡"}, @{@"code": @"MON-CESXK-LHH7H", @"type": @"月卡"}, @{@"code": @"MON-BRHKZ-HT85H", @"type": @"月卡"},
            @{@"code": @"MON-NZKLA-MP6W0", @"type": @"月卡"}, @{@"code": @"MON-NHJZN-ZG2EV", @"type": @"月卡"}, @{@"code": @"MON-YFKZX-18K6V", @"type": @"月卡"}, @{@"code": @"MON-6RZPI-OCQMN", @"type": @"月卡"}, @{@"code": @"MON-XBU58-2R1LV", @"type": @"月卡"}, @{@"code": @"MON-MOOMG-8ZXFD", @"type": @"月卡"}, @{@"code": @"MON-29OC5-H8B9Y", @"type": @"月卡"}, @{@"code": @"MON-XGBMG-NAGOL", @"type": @"月卡"}, @{@"code": @"MON-B6KDO-3G4GA", @"type": @"月卡"}, @{@"code": @"MON-FBZNV-SXCBD", @"type": @"月卡"},

            // ===== 欲神幻想 永久卡 (100) =====
            @{@"code": @"PER-SUA7H-MFPZ6", @"type": @"永久卡"}, @{@"code": @"PER-GKOJT-E808I", @"type": @"永久卡"}, @{@"code": @"PER-3VZVD-4NJW2", @"type": @"永久卡"}, @{@"code": @"PER-JBBUS-QCKKQ", @"type": @"永久卡"}, @{@"code": @"PER-X5ITK-E80KE", @"type": @"永久卡"}, @{@"code": @"PER-J29SK-SLW8P", @"type": @"永久卡"}, @{@"code": @"PER-2PQCT-TSRT6", @"type": @"永久卡"}, @{@"code": @"PER-4A8CG-TLV84", @"type": @"永久卡"}, @{@"code": @"PER-RZRYY-S4G8J", @"type": @"永久卡"}, @{@"code": @"PER-V6X3B-FNAM0", @"type": @"永久卡"},
            @{@"code": @"PER-PFCF0-IHM4T", @"type": @"永久卡"}, @{@"code": @"PER-KI7JE-41P1G", @"type": @"永久卡"}, @{@"code": @"PER-M0IYT-V2QPO", @"type": @"永久卡"}, @{@"code": @"PER-VTQ4K-DECH0", @"type": @"永久卡"}, @{@"code": @"PER-6RBJM-RV2RX", @"type": @"永久卡"}, @{@"code": @"PER-GB3CQ-77PMP", @"type": @"永久卡"}, @{@"code": @"PER-6N28M-1GOJN", @"type": @"永久卡"}, @{@"code": @"PER-BZEFQ-WLX7P", @"type": @"永久卡"}, @{@"code": @"PER-E4KYR-NCLSA", @"type": @"永久卡"}, @{@"code": @"PER-GQSK3-BBC6C", @"type": @"永久卡"},
            @{@"code": @"PER-PT142-UWQH7", @"type": @"永久卡"}, @{@"code": @"PER-EFN7S-RVP8P", @"type": @"永久卡"}, @{@"code": @"PER-4R44V-2KZ5V", @"type": @"永久卡"}, @{@"code": @"PER-M24G8-4E5DH", @"type": @"永久卡"}, @{@"code": @"PER-9OBPD-BK2MC", @"type": @"永久卡"}, @{@"code": @"PER-PO16K-3O1T9", @"type": @"永久卡"}, @{@"code": @"PER-B4VQL-U5CTI", @"type": @"永久卡"}, @{@"code": @"PER-QRNLA-6J2LU", @"type": @"永久卡"}, @{@"code": @"PER-GE4NS-YV0C3", @"type": @"永久卡"}, @{@"code": @"PER-HP03J-23IK3", @"type": @"永久卡"},
            @{@"code": @"PER-H8JTY-XB8HA", @"type": @"永久卡"}, @{@"code": @"PER-CUKHI-M33LR", @"type": @"永久卡"}, @{@"code": @"PER-C04X1-LNYAV", @"type": @"永久卡"}, @{@"code": @"PER-3C7A3-OX968", @"type": @"永久卡"}, @{@"code": @"PER-1S3YE-U54R3", @"type": @"永久卡"}, @{@"code": @"PER-1UTG2-NCKGS", @"type": @"永久卡"}, @{@"code": @"PER-OSR8X-7IKOK", @"type": @"永久卡"}, @{@"code": @"PER-HSOSD-X4A7Q", @"type": @"永久卡"}, @{@"code": @"PER-40EQC-1FS1S", @"type": @"永久卡"}, @{@"code": @"PER-84EO3-UMCXR", @"type": @"永久卡"},
            @{@"code": @"PER-AO9OV-X2P10", @"type": @"永久卡"}, @{@"code": @"PER-S5SG6-6W30H", @"type": @"永久卡"}, @{@"code": @"PER-435Y7-3DLQ9", @"type": @"永久卡"}, @{@"code": @"PER-BG4TP-T65FB", @"type": @"永久卡"}, @{@"code": @"PER-9VL3V-EBG9V", @"type": @"永久卡"}, @{@"code": @"PER-8IW2J-OR2L8", @"type": @"永久卡"}, @{@"code": @"PER-WX4OG-W8YYJ", @"type": @"永久卡"}, @{@"code": @"PER-41SLM-DPP7K", @"type": @"永久卡"}, @{@"code": @"PER-1T4Q1-LC8E8", @"type": @"永久卡"}, @{@"code": @"PER-ME769-X8CAE", @"type": @"永久卡"},
            @{@"code": @"PER-GCEKA-QAT7F", @"type": @"永久卡"}, @{@"code": @"PER-KBLZW-BZPPN", @"type": @"永久卡"}, @{@"code": @"PER-UJGMV-0DMPW", @"type": @"永久卡"}, @{@"code": @"PER-6PR2S-4VF01", @"type": @"永久卡"}, @{@"code": @"PER-U3PLM-7CF8L", @"type": @"永久卡"}, @{@"code": @"PER-9NLYX-PB4LK", @"type": @"永久卡"}, @{@"code": @"PER-U52XL-B2O29", @"type": @"永久卡"}, @{@"code": @"PER-3U0H6-WLVJ1", @"type": @"永久卡"}, @{@"code": @"PER-XZ1OC-L751B", @"type": @"永久卡"}, @{@"code": @"PER-7ST9T-6VZFE", @"type": @"永久卡"},
            @{@"code": @"PER-QI9X0-9D0UM", @"type": @"永久卡"}, @{@"code": @"PER-OFR9N-RZ32F", @"type": @"永久卡"}, @{@"code": @"PER-6SNMR-GZZJ1", @"type": @"永久卡"}, @{@"code": @"PER-O7QFO-MRYBT", @"type": @"永久卡"}, @{@"code": @"PER-4CN86-3RWG4", @"type": @"永久卡"}, @{@"code": @"PER-FCVNP-5F4CG", @"type": @"永久卡"}, @{@"code": @"PER-QQTBN-QQV8Q", @"type": @"永久卡"}, @{@"code": @"PER-2UY7P-52BU2", @"type": @"永久卡"}, @{@"code": @"PER-QDKKO-C5JDO", @"type": @"永久卡"}, @{@"code": @"PER-0OY5M-Q34B9", @"type": @"永久卡"},
            @{@"code": @"PER-488AK-2OG5Y", @"type": @"永久卡"}, @{@"code": @"PER-TIPCR-2NKTF", @"type": @"永久卡"}, @{@"code": @"PER-HJLU9-70SCG", @"type": @"永久卡"}, @{@"code": @"PER-GYSE7-7KQSQ", @"type": @"永久卡"}, @{@"code": @"PER-3U8VS-9FOG9", @"type": @"永久卡"}, @{@"code": @"PER-96O6Y-1F4MF", @"type": @"永久卡"}, @{@"code": @"PER-VIO0L-YDVBB", @"type": @"永久卡"}, @{@"code": @"PER-19XMT-DMKSD", @"type": @"永久卡"}, @{@"code": @"PER-DMPSK-VDF60", @"type": @"永久卡"}, @{@"code": @"PER-2HK9G-VDP71", @"type": @"永久卡"},
            @{@"code": @"PER-I5L28-C3VR7", @"type": @"永久卡"}, @{@"code": @"PER-8AYZ4-7N9DQ", @"type": @"永久卡"}, @{@"code": @"PER-M9K5P-PYYKU", @"type": @"永久卡"}, @{@"code": @"PER-VBIYQ-DQ14E", @"type": @"永久卡"}, @{@"code": @"PER-6V8U9-6CU6U", @"type": @"永久卡"}, @{@"code": @"PER-HH8ZZ-KSKP8", @"type": @"永久卡"}, @{@"code": @"PER-APFD5-KGHMO", @"type": @"永久卡"}, @{@"code": @"PER-YTAAP-HTMRC", @"type": @"永久卡"}, @{@"code": @"PER-PLBCF-CH8UV", @"type": @"永久卡"}, @{@"code": @"PER-K2240-EHIPD", @"type": @"永久卡"},
            @{@"code": @"PER-5FYOR-ABE4M", @"type": @"永久卡"}, @{@"code": @"PER-3FHTI-ODSFR", @"type": @"永久卡"}, @{@"code": @"PER-6I56N-AYRAF", @"type": @"永久卡"}, @{@"code": @"PER-U41XA-4I7HR", @"type": @"永久卡"}, @{@"code": @"PER-ZUIVH-OIPUV", @"type": @"永久卡"}, @{@"code": @"PER-TN429-LHJCZ", @"type": @"永久卡"}, @{@"code": @"PER-WFH1O-VN0KK", @"type": @"永久卡"}, @{@"code": @"PER-0I2ZZ-4PI74", @"type": @"永久卡"}, @{@"code": @"PER-RMHHC-ZG61L", @"type": @"永久卡"}, @{@"code": @"PER-I8VT5-8M98P", @"type": @"永久卡"}
        ];
    });
    return database;
}

@interface AuthManager : NSObject
+ (instancetype)sharedInstance;
- (void)checkAndLoad;
@end

@implementation AuthManager
+ (instancetype)sharedInstance {
    static AuthManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ instance = [[AuthManager alloc] init]; });
    return instance;
}
- (void)checkAndLoad {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *activeCode = [defaults objectForKey:kKeyActiveCode];
    NSString *activeDevice = [defaults objectForKey:kKeyActiveDevice];
    NSTimeInterval activationTime = [defaults doubleForKey:kKeyActivationTime];
    NSString *codeType = [defaults objectForKey:kKeyCodeType];
    
    NSString *currentDevice = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    BOOL isValid = NO;
    
    if (activeCode && [activeDevice isEqualToString:currentDevice]) {
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval elapsed = now - activationTime;
        if ([codeType isEqualToString:@"永久卡"]) isValid = YES;
        else if ([codeType isEqualToString:@"日卡"]) isValid = (elapsed < 24 * 3600);
        else if ([codeType isEqualToString:@"月卡"]) isValid = (elapsed < 30 * 24 * 3600);
    }
    
    if (isValid) {
        [self loadTargetDylib];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{ [self showAuthUI]; });
    }
}

- (void)loadTargetDylib {
    // 针对欲神幻想：加载 libRiseofEros.dylib
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *dylibPath = [bundlePath stringByAppendingPathComponent:@"Frameworks/libRiseofEros.dylib"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dylibPath]) { 
        NSLog(@"[Auth] 找不到目标: %@", dylibPath);
        return; 
    }
    dlopen([dylibPath UTF8String], RTLD_NOW);
}

- (void)showAuthUI {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (!rootVC) return;
    
    // 弹窗不再允许随便取消，只能输入或退出
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"授权验证" message:@"请输入您的激活码以启动游戏" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) { textField.placeholder = @"粘贴或输入激活码"; }];
    
    UIAlertAction *activateAction = [UIAlertAction actionWithTitle:@"激活" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { 
        [self verifyCode:alert.textFields.firstObject.text]; 
    }];
    
    UIAlertAction *exitAction = [UIAlertAction actionWithTitle:@"退出游戏" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) { 
        exit(0); // 直接杀进程
    }];
    
    [alert addAction:activateAction];
    [alert addAction:exitAction];
    [rootVC presentViewController:alert animated:YES completion:nil];
}

- (void)verifyCode:(NSString *)code {
    NSArray *codesArray = getAuthDatabase();
    BOOL codeFound = NO;
    NSString *cardType = nil;
    NSString *cleanCode = [[code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    for (NSDictionary *dict in codesArray) {
        if ([dict[@"code"] isEqualToString:cleanCode]) { codeFound = YES; cardType = dict[@"type"]; break; }
    }
    
    // 如果输入错误，不光是弹窗提示，而是提示后直接杀进程
    if (!codeFound) { 
        [self showErrorAndKill:@"激活码无效，请检查输入"]; 
        return; 
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *savedDevice = [defaults objectForKey:[NSString stringWithFormat:@"Device_%@", cleanCode]];
    NSString *currentDevice = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if (savedDevice && ![savedDevice isEqualToString:currentDevice]) { 
        [self showErrorAndKill:@"该激活码已在其他设备绑定，无法跨设备使用"]; 
        return; 
    }
    
    [defaults setObject:cleanCode forKey:kKeyActiveCode];
    [defaults setObject:currentDevice forKey:kKeyActiveDevice];
    [defaults setObject:@([[NSDate date] timeIntervalSince1970]) forKey:kKeyActivationTime];
    [defaults setObject:cardType forKey:kKeyCodeType];
    [defaults setObject:currentDevice forKey:[NSString stringWithFormat:@"Device_%@", cleanCode]];
    [defaults synchronize];
    
    [self loadTargetDylib];
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC dismissViewControllerAnimated:YES completion:^{ 
        UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:@"成功" message:@"授权成功，祝您游戏愉快！" preferredStyle:UIAlertControllerStyleAlert];
        [successAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [rootVC presentViewController:successAlert animated:YES completion:nil];
    }];
}

// 错误专用：弹窗提示后直接杀进程
- (void)showErrorAndKill:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootVC dismissViewControllerAnimated:YES completion:nil]; // 先关掉输入框
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) { 
            exit(0); // 点击退出直接杀进程
        }]];
        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}

@end

__attribute__((constructor)) static void initPlugin() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[AuthManager sharedInstance] checkAndLoad];
    });
}
