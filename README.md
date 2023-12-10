# CJson - JSON class for mql4 and mql5

[![Copyright](https://img.shields.io/badge/Copyright-2023-blue)](https://www.mql5.com/en/users/franciscogomes5)


This Json class offers an easy way to handle JSON data in MQL5 and MQL4, including functionalities for creating, manipulating, and serializing JSON objects. It has been developed under the Standard Library's coding conventions.

## Step 1. Download

You can download this project and paste the Json folder inside your `\MQL5\Include\` directory, or you can also include it directly in your project.

I will show an example of how to download it to your project in a separate branch called `json`:

```bash
git remote add json https://github.com/franciscogomes2020/CJson.git
git fetch json
git branch json json/json
git merge json --allow-unrelated-histories

```
Now you have this project tracked in the `json` branch inside your project.

## Step 2. Include

Include the file `Json\Json.mqh` in your code:

```mql5
#include "Json\Json.mqh"
```

Or if you have downloaded it to the `\MQL5\Include\` directory, it is simpler.

```mql5
#include <Json\Json.mqh>
```

## Step 3. Use

Here is a script example of usage of the CJson class:

```mql5
#include "Json\Json.mqh"

void OnStart()
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
  }
```

For more examples, you can see the file [test.mqh](Json/Test/test.mqh)
