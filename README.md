# TradingApp

Trading Engine Test


###Run with default csv file
```
BUY,560.50,50,USD/EUR
BUY,560.55,50,USD/EUR
BUY,560.60,40,USD/EUR
SELL,580.60,100,USD/EUR
```

```
evgeniygutorov@Evgeniys-MacBook-pro:debug$ ./TradingApp 
USAGE: TradingApp [CSV file path]
Orders will be loaded from default inputdata.csv

OrderPlaced event:┃buy	┃560.5		┃50	┃USD/EUR┃
OrderPlaced event:┃buy	┃560.55		┃50	┃USD/EUR┃
OrderPlaced event:┃buy	┃560.6		┃40	┃USD/EUR┃
OrderPlaced event:┃sell	┃580.6		┃100	┃USD/EUR┃


Output data:

┎───────┰───────────────┰───────┰───────┒
┃SIDE	┃PRICE		┃AMOUNT	┃PAIR	┃
┠───────╂───────────────╂───────╂───────┨
┃buy	┃560.5		┃50	┃USD/EUR┃
┃buy	┃560.55		┃50	┃USD/EUR┃
┃buy	┃560.6		┃40	┃USD/EUR┃
┃sell	┃580.6		┃100	┃USD/EUR┃
┖───────┸───────────────┸───────┸───────┚
```
###Specify csv file  by argument
```
BUY,560.50,50,USD/EUR
BUY,560.55,50,USD/EUR
BUY,560.60,40,USD/EUR
SELL,580.60,100,USD/EUR
SELL,560.53,80,USD/EUR
```

```
evgeniygutorov@Evgeniys-MacBook-pro:debug$ ./TradingApp /Users/evgeniygutorov/gitprojects/Demo/TradingApp/inputdata2.csv 
OrderPlaced event:┃buy	┃560.5		┃50	┃USD/EUR┃
OrderPlaced event:┃buy	┃560.55		┃50	┃USD/EUR┃
OrderPlaced event:┃buy	┃560.6		┃40	┃USD/EUR┃
OrderPlaced event:┃sell	┃580.6		┃100	┃USD/EUR┃
OrderClosed event:┃buy	┃560.55		┃0	┃USD/EUR┃
OrderClosed event:┃sell	┃560.53		┃0	┃USD/EUR┃


Output data:

┎───────┰───────────────┰───────┰───────┒
┃SIDE	┃PRICE		┃AMOUNT	┃PAIR	┃
┠───────╂───────────────╂───────╂───────┨
┃buy	┃560.5		┃50	┃USD/EUR┃
┃buy	┃560.6		┃10	┃USD/EUR┃
┃sell	┃580.6		┃100	┃USD/EUR┃
┖───────┸───────────────┸───────┸───────┚
```