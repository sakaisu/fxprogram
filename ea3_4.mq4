//本サイトライブラリ
#include "LibEA4.mqh"

input int BBPeriod = 10;  //ボリンジャーバンドの期間
input double BBDev = 2.0; //標準偏差の倍率
input double Lots = 0.1; //売買ロット数

//ティック時実行関数
void OnTick()
{
   int sig_entry = EntrySignal(); //仕掛けシグナル
   //成行売買
   MyOrderSendMarket(sig_entry, sig_entry, Lots);
}

//仕掛けシグナル関数
int EntrySignal()
{
   //１本前と２本前のボリンジャーバンド
   double BBUpper1 = iBands(_Symbol, 0, BBPeriod, BBDev, 0, PRICE_CLOSE, MODE_UPPER, 1);
   double BBLower1 = iBands(_Symbol, 0, BBPeriod, BBDev, 0, PRICE_CLOSE, MODE_LOWER, 1);
   double BBUpper2 = iBands(_Symbol, 0, BBPeriod, BBDev, 0, PRICE_CLOSE, MODE_UPPER, 2);
   double BBLower2 = iBands(_Symbol, 0, BBPeriod, BBDev, 0, PRICE_CLOSE, MODE_LOWER, 2);

   int ret = 0; //シグナルの初期化

   //買いシグナル
   if(Close[2] >= BBLower2 && Close[1] < BBLower1) ret = 1;
   //売りシグナル
   if(Close[2] <= BBUpper2 && Close[1] > BBUpper1) ret = -1;

   return ret; //シグナルの出力
}
