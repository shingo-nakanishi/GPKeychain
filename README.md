GPKeychain
==========


LKKeychainのラッパーです。
Core DATA感覚でKeychainを扱えます。

つまり、プロパティを書くだけで、setter, getterが生えて、 プロパティアクセスでKeychainを扱うことができます。

便利になるだけでなく、補完が効き、いままでNSStringで扱っていたものをコンパイラにチェックさせることができます。

ARCのみ対応です。
 
インストール
-----
GPKeychain.hとGPKeychain.mをあなたのプロジェクトに入れる。
LKKeychainを入れる。
Security.frameworkを入れる。

GPKeychain.mの
```
#define SERVICE_KEY @"YOUR_SERVICE_KEY"
```
をあなたが使うサービス名に変更する。

GPKeychainを拡張する（あなたのプロジェクトでひとつだけ作れば十分だと思います）。

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
[[YourKeychain sharedManager] setBar:@"BBB"];
[[YourKeychain sharedManager] setPiyo:@"PPP"];
    
NSLog(@"bar:%@", [YourKeychain sharedManager].bar);
NSLog(@"piyo:%@", [YourKeychain sharedManager].piyo);
```
でキーチェーンにアクセス可能。
```
[YourKeychain sharedManager].piyo = nil;
```
でキーを削除できます。
