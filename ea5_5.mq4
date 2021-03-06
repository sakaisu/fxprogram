//本サイトライブラリ
#include "LibEA4.mqh"

input int RSIPeriod = 14; //RSIの期間
input int StartHour = 12; // 開始時刻（時）
input int EndHour = 20;   // 終了時刻（時）
input double Lots = 0.1; //売買ロット数

//ティック時実行関数
void OnTick()
{
   int sig_entry = EntrySignal(); //仕掛けシグナル
   int sig_filter = FilterSignal(sig_entry); //タイムフィルタ
   //成行売買
   MyOrderSendMarket(sig_filter, sig_entry, Lots);
}

//仕掛けシグナル関数
int EntrySignal()
{
   //１本前のRSI
   double RSI1 = iRSI(_Symbol, 0, RSIPeriod, PRICE_CLOSE, 1);

   int ret = 0; //シグナルの初期化

   //買いシグナル
   if(RSI1 < 30) ret = 1;
   //売りシグナル
   if(RSI1 > 70) ret = -1;

   return ret; //シグナルの出力
}

//フィルタ関数
int FilterSignal(int signal)
{
   int ret = 0; //シグナルの初期化

   //売買シグナルのフィルタ
   if(Hour() >= StartHour && Hour() < EndHour) ret = signal;

   return ret; //シグナルの出力
}
