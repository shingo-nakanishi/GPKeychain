GPKeychain
==========

ENGLISH
=========
This is wrapper of LKKeychain(https://github.com/lakesoft/LKKeychain).
You use this like the Core DATA.

This mean, when you write property, automaticaly making setter and getter.
Keychain use NSString for Key, but GPKeychain use setter and getter.
So, You use complement. Compailer check your keychain code!

install
-----
Put GPkeychain.h and GPKeychain.m to your project.
include LKKeychain(https://github.com/lakesoft/LKKeychain).
include Security.framework.

Change SERVICE_KEY in GPKeychain.m to your service name.
```
#define SERVICE_KEY @"YOUR_SERVICE_KEY"
```

inheritance GPKeychain.
in inheritance Class header file
```
@property(nonatomic, strong) NSString *bar;
@property(nonatomic, strong) NSString *piyo;
```

in inheritance Class body file
```
@dynamic bar;
@dynamic piyo;
```

that's all. you can use setter and getter.
```
[[YourKeychain sharedManager] setBar:@"BBB"];
[[YourKeychain sharedManager] setPiyo:@"PPP"];
    
NSLog(@"bar:%@", [YourKeychain sharedManager].bar);
NSLog(@"piyo:%@", [YourKeychain sharedManager].piyo);
```

use nil, you can delete key.
```
[YourKeychain sharedManager].piyo = nil;
```



JAPANESE
=========
LKKeychain(https://github.com/lakesoft/LKKeychain)のラッパーです。
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
