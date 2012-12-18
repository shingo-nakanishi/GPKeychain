GPKeychain
==========


LKKeychainのラッパーです。
Core DATA感覚でKeychainを扱えます。
（まだ十分なテストが行われとりません。ご使用は各自の判断でお願い致します。）
 
インストール
-----
GPKeychain.hとGPKeychain.mをあなたのプロジェクトに入れる。
Security.frameworkを入れる。

GPKeychainを拡張する。

static id gPKeychain = nil;

+(IdKeychain *)sharedManager{
    @synchronized(self) {
        if (gPKeychain == nil) {
            gPKeychain = [[self alloc] init];
        }
    }
    return gPKeychain;
}

