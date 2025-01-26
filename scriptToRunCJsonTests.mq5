//+------------------------------------------------------------------+
//|                                        scriptToRunCJsonTests.mq5 |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"
#property version   "1.00"
#property description "This script runs tests for CJson class"
/*+------------------------------------------------------------------+
//| how to run:                                                      |
//|+-----------------------------------------------------------------+
copy and past the folder CJson to your MQL5/Scripts folder
open this file 'scriptToRunCJsonTests.mq5' in your MetaEditor and press F5
your MetaEditor will stop at the line of there is any error
if it does not stop it is because your test has passed


/*+-----------------------------------------------------------------*/
//| include to run auto test for CJson                               |
//|+----------------------------------------------------------------*/
#include "Json/Test/test.mqh"
//++------------------------------------------------------------------+
//| Function needed to any script                                    |
//+------------------------------------------------------------------+
void OnStart(void)
  {
   CJson json;
   Print( json==UNDEFINED                           );  //true
   Print( json="123"                                );  //true
   Print( json==INT                                 );  //true
   Print( EnumToString(json.JsonType())             );  //JSON_TYPE_INT
   Print( json="hello world"                        );  //true
   Print( json==STRING                              );  //true
   Print( json.Value()                              );  //hello world
   Print( json="{}"                                 );  //true
   Print( json==OBJECT                              );  //true
   Print( json="{a:123, b:\"hello world\"}"         );  //true
   Print( json["a"].Value()                         );  //"123"
   Print( json["a"].ValueToInt()                    );  //123
   Print( json["b"].Value()                         );  //hello world
   Print( json["c"].Value()                         );  //""
   Print( json["d"]==UNDEFINED                      );  //true
   Print( json["e"]="value of key e is ok"          );  //true
   Print( json["e"].Value()                         );  //"value of key e is ok"
   Print( json["e"]==STRING                         );  //true
   Print( json["e"].KeyExist("a")                   );  //false
   Print( json["e"]["a"]="value of key [e][a] is ok");  //true
   Print( json["e"]==STRING                         );  //false
   Print( json["e"]==OBJECT                         );  //true
   Print( json["e"]["a"].Value()                    );  //"value of key [e][a] is ok"
   Print( json["e"]["b"]="[3,2,1,\"thank you\"]"    );  //true
   Print( json["e"]["b"]==ARRAY                     );  //true
   Print( json["e"]["b"][0].ValueToInt()            );  //3
   Print( json["e"]["b"][1].ValueToInt()            );  //2
   Print( json["e"]["b"][2].ValueToInt()            );  //1
   Print( json["e"]["b"][3].Value()                 );  //thank you
   Print( json.Stringfy()                           );  //{"a":123,"b":"hello world","c":,"d":,"e":{"a":"value of key [e][a] is ok","b":[3,2,1,"thank you"]}}
   Print( json[0].Value()                           );  //"123"
   Print( json[1].Value()                           );  //"hello world"
   Print( json="now I am a String"                  );  //true
   Print( json.Value()                              );  //"now I am a String"
   Print( json==STRING                              );  //true
   Print( json[1]="now I am a array"                );  //true
   Print( json==ARRAY                               );  //true
   Print( json[1]==STRING                           );  //true
   Print( json[1].Value()                           );  //"now I am a array"
   Print( json[0]==UNDEFINED                        );  //true
   Print( json[0]=1                                 );  //true
   Print( json[0]==INT                              );  //true
   Print( json.Total()                              );  //2
   Print( json[2]==UNDEFINED                        );  //true
   Print( json.Total()                              );  //3
  }
//+------------------------------------------------------------------+
