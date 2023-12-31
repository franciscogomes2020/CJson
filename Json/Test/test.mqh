//+------------------------------------------------------------------+
//|                                                         test.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"
/*+------------------------------------------------------------------+
//| these tests auto run if you use this include into your program   |
//|+-----------------------------------------------------------------+
#include <Json\Test\test.mqh>



//+-----------------------------------------------------------------*/
//| init of tests                                                    |
//+------------------------------------------------------------------+
#include "..\Json.mqh"
#include "testAsserts.mqh"
//+------------------------------------------------------------------+
//| func main to tests                                               |
//+------------------------------------------------------------------+
int TestCJson(void)
  {
   CJson json;
// json is not defined yet
   ASSERT_EQUALS(json.Type(), JSON_TYPE_UNDEFINED);
   ASSERT_EQUALS(json.Stringfy(), "");

// int
   ASSERT_EQUALS((json="1"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_INT);
   ASSERT_EQUALS(json.Stringfy(), "1");
   ASSERT_EQUALS(json.Value(), "1");
   ASSERT_EQUALS(json.ValueToInt(), 1);

// string
   ASSERT_EQUALS((json="name"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_STRING);
   ASSERT_EQUALS(json.Stringfy(), "\"name\"");
   ASSERT_EQUALS(json.Value(), "name");

// array
   ASSERT_EQUALS((json="[]"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_ARRAY);
   ASSERT_EQUALS(json.Stringfy(), "[]");
   ASSERT_EQUALS(json.Total(), 0);

// object
   ASSERT_EQUALS((json="{}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(), "{}");
   ASSERT_EQUALS(json.Total(), 0);

   ASSERT_EQUALS((json="{Name1:\"Willian\"}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.KeyName(0),"Name1")
   ASSERT_EQUALS(json.At(0).Value(),"Willian")
   ASSERT_EQUALS(json.Key(0).Value(),"Willian")
   ASSERT_EQUALS(json.Stringfy(), "{\"Name1\":\"Willian\"}");
   ASSERT_EQUALS(json.Total(), 1);

   ASSERT_EQUALS((json="{Name1:\"Willian\",\"Name2\":\"Rose\"}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.KeyName(0),"Name1")
   ASSERT_EQUALS(json.KeyName(1),"Name2")
   ASSERT_EQUALS(json.At(0).Value(),"Willian")
   ASSERT_EQUALS(json.Key(0).Value(),"Willian")
   ASSERT_EQUALS(json.At(1).Value(),"Rose")
   ASSERT_EQUALS(json.Key(1).Value(),"Rose")
   ASSERT_EQUALS(json.Stringfy(), "{\"Name1\":\"Willian\",\"Name2\":\"Rose\"}");
   ASSERT_EQUALS(json.Total(), 2);

   ASSERT_EQUALS((json="{}"), true);
   ASSERT_EQUALS(json["undefined key"].Type(),JSON_TYPE_UNDEFINED)
   ASSERT_EQUALS(json["undefined key"].Value(),"")

   ASSERT_EQUALS((json="{\"buy\":{\"open\":{\"rule\":\"C=O\"}},\"sell\":{\"open\":{\"rule\":\"C!=O\"}}}"),true);
   ASSERT_EQUALS(json.JsonType(),JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.KeyExist("buy"),true);
   ASSERT_EQUALS(json["buy"].KeyExist("open"),true);
   ASSERT_EQUALS(json["buy"]["open"].KeyExist("rule"),true);
   ASSERT_EQUALS(json["buy"]["open"]["rule"].JsonType(),JSON_TYPE_STRING);
   ASSERT_EQUALS(json["buy"]["open"]["rule"].Value(),"C=O");

   ASSERT_EQUALS(json["sell"].KeyExist("open"),true);
   ASSERT_EQUALS(json["sell"]["open"].KeyExist("rule"),true);
   ASSERT_EQUALS(json["sell"]["open"]["rule"].JsonType(),JSON_TYPE_STRING);
   ASSERT_EQUALS(json["sell"]["open"]["rule"].Value(),"C!=O");

   ASSERT_EQUALS((json="{\"buy\":{\"open\":{\"rule\":\"C=O\"}},\"sell\":{\"open\":{\"rule\":\"C!=O\"}}} "),true);
   ASSERT_EQUALS(json.JsonType(),JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.KeyExist("buy"),true);
   ASSERT_EQUALS(json["buy"].KeyExist("open"),true);
   ASSERT_EQUALS(json["buy"]["open"].KeyExist("rule"),true);
   ASSERT_EQUALS(json["buy"]["open"]["rule"].JsonType(),JSON_TYPE_STRING);
   ASSERT_EQUALS(json["buy"]["open"]["rule"].Value(),"C=O");

   ASSERT_EQUALS(json["sell"].KeyExist("open"),true);
   ASSERT_EQUALS(json["sell"]["open"].KeyExist("rule"),true);
   ASSERT_EQUALS(json["sell"]["open"]["rule"].JsonType(),JSON_TYPE_STRING);
   ASSERT_EQUALS(json["sell"]["open"]["rule"].Value(),"C!=O");

// any json can be a object
// example convert json to string
   ASSERT_EQUALS(json = "oneString",true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_STRING);
// example convert json to object
   ASSERT_EQUALS(json["one key"] = "one value",true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(),"{\"one key\":\"one value\"}");

// array with 1 object
   ASSERT_EQUALS((json="[{}]"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_ARRAY);
   ASSERT_EQUALS(json.Stringfy(), "[{}]");
   ASSERT_EQUALS(json.Total(), 1);
   ASSERT_EQUALS(json[0].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0].Stringfy(), "{}");
   ASSERT_EQUALS(json[0].Total(), 0);

// array with 2 object
   ASSERT_EQUALS((json="[{},{}]"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_ARRAY);
   ASSERT_EQUALS(json.Stringfy(), "[{},{}]");
   ASSERT_EQUALS(json.Total(), 2);
   ASSERT_EQUALS(json[0].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0].Stringfy(), "{}");
   ASSERT_EQUALS(json[0].Total(), 0);
   ASSERT_EQUALS(json[1].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[1].Stringfy(), "{}");
   ASSERT_EQUALS(json[1].Total(), 0);

// array with 2 object with spaces
   ASSERT_EQUALS((json="[ { }  , { } ]"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_ARRAY);
   ASSERT_EQUALS(json.Stringfy(), "[{},{}]");
   ASSERT_EQUALS(json.Total(), 2);
   ASSERT_EQUALS(json[0].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0].Stringfy(), "{}");
   ASSERT_EQUALS(json[0].Total(), 0);
   ASSERT_EQUALS(json[1].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[1].Stringfy(), "{}");
   ASSERT_EQUALS(json[1].Total(), 0);

// object with 1 key
   ASSERT_EQUALS((json="{name:\"default\"}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(), "{\"name\":\"default\"}");
   ASSERT_EQUALS(json.Total(), 1);
   ASSERT_EQUALS(json.KeyExist("name"),true);
   ASSERT_EQUALS(json["name"].Value(),"default");
   ASSERT_EQUALS(json["name"].Type(),JSON_TYPE_STRING);

// object with 1 key without aspos and single aspos on string
   ASSERT_EQUALS((json="{name:'default'}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(), "{\"name\":\"default\"}");
   ASSERT_EQUALS(json.Total(), 1);

// object with 2 key
   ASSERT_EQUALS((json="{v1:'defaultV1',v2:'defaultV2'}"), true);
   ASSERT_EQUALS(json.Stringfy(), "{\"v1\":\"defaultV1\",\"v2\":\"defaultV2\"}");
   ASSERT_EQUALS(json.Total(), 2);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(), "{\"v1\":\"defaultV1\",\"v2\":\"defaultV2\"}");

// array with sequence of objects
   ASSERT_EQUALS((json="[{value1:'value1IsAString',entry:{description:'textDescription'}}]"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_ARRAY);
   ASSERT_EQUALS(json.Total(), 1);
   ASSERT_EQUALS(json.Stringfy(), "[{\"value1\":\"value1IsAString\",\"entry\":{\"description\":\"textDescription\"}}]");
   ASSERT_EQUALS(json[0].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0].Total(), 2);
   ASSERT_EQUALS(json[0].KeyExist("value1"), true);
   ASSERT_EQUALS(json[0]["value1"].Value(), "value1IsAString");
   ASSERT_EQUALS(json[0].KeyExist("value2"), false);
   ASSERT_EQUALS(json[0].KeyExist("entry"), true);
   ASSERT_EQUALS(json[0]["entry"].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0]["entry"].Total(), 1);
   ASSERT_EQUALS(json[0]["entry"].KeyExist("description"), true);
   ASSERT_EQUALS(json[0]["entry"]["description"].Value(), "textDescription");

   ASSERT_EQUALS(json = "{sell:{open:'1.67'}}",true);
   ASSERT_EQUALS(json==JSON_TYPE_OBJECT,true);
   ASSERT_EQUALS(json.Stringfy(),"{\"sell\":{\"open\":\"1.67\"}}");
   ASSERT_EQUALS(json["open"].JsonType(),JSON_TYPE_UNDEFINED);
   ASSERT_EQUALS(json["sell"]==JSON_TYPE_OBJECT,true);
   ASSERT_EQUALS(json["sell"].Stringfy(),"{\"open\":\"1.67\"}");
   ASSERT_EQUALS(json["sell"]["open"]==JSON_TYPE_STRING,true);
   ASSERT_EQUALS(json["sell"]["open"].Stringfy(),"\"1.67\"");

// operators
   ASSERT_EQUALS(json = new CJson,true);
   ASSERT_EQUALS(json == JSON_TYPE_UNDEFINED,true);
   ASSERT_EQUALS(json != JSON_TYPE_STRING,true);

// insert value directly to object string
   ASSERT_EQUALS(json = "foo",true);
   ASSERT_EQUALS(json == JSON_TYPE_STRING,true);
   ASSERT_EQUALS(json.Value(),"foo");
   ASSERT_EQUALS(json.Value("{}"),true);
   ASSERT_EQUALS(json == JSON_TYPE_STRING,true);
   ASSERT_EQUALS(json.Value(),"{}");

//scape and decode to normalize strings inside json
   string text = "\" \'";
   CJsonBase::EscapeXml(text);
   ASSERT_EQUALS(text,"&quot; &apos;")
   CJsonBase::DecodeXml(text);
   ASSERT_EQUALS(text,"\" \'")
   return 0;
  }
#ifdef _DEBUG
int autoRunTestCJson = TestCJson();
#endif
//+------------------------------------------------------------------+
