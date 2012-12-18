GPKeychain
==========


LKKeychainのラッパーです。
Core DATA感覚でKeychainを扱えます。
（まだ十分なテストが行われとりません。ご使用は各自の判断でお願い致します。）
 
インストール
-----
GPKeychain.hとGPKeychain.mをあなたのプロジェクトに入れる。
Security.frameworkを入れる。

GPKeychain.mの
```
#define SERVICE_KEY @"YOUR_SERVICE_KEY"
```
をあなたが使うサービス名に変更する。

GPKeychainを拡張する。
拡張したクラスで以下を追加。
```
static id gPKeychain = nil;

+(yourKeychain *)sharedManager{    // 戻り値を自分が拡張したクラス名に変更
    @synchronized(self) {
        if (gPKeychain == nil) {
            gPKeychain = [[self alloc] init];
        }
    }
    return gPKeychain;
}
```

あとは、ヘッダーに
```
@property(nonatomic, strong) NSString *bar;
@property(nonatomic, strong) NSString *piyo;
```

ボディーに
```
@dynamic bar;
@dynamic piyo;
```
といった感じで、プロパティを追加すれば、
```
[[yourKeychain sharedManager] setBar:@"BBB"];
[[yourKeychain sharedManager] setPiyo:@"PPP"];
    
NSLog(@"bar:%@", [yourKeychain sharedManager].bar);
NSLog(@"piyo:%@", [yourKeychain sharedManager].piyo);
```
でキーチェーンにアクセス可能。
