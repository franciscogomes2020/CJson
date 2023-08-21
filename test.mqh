//+------------------------------------------------------------------+
//|                                                         test.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"
/*+------------------------------------------------------------------+
//| how to run these tests:                                          |
//|+-----------------------------------------------------------------+
#include <Json\test.mqh>
int runTestCJson = TestCJson();



//+-----------------------------------------------------------------*/
//| init of tests                                                    |
//+------------------------------------------------------------------+
#include <Json\json.mqh>
#include "testAsserts.mqh"
//+------------------------------------------------------------------+
//| func main to tests                                               |
//+------------------------------------------------------------------+
int TestCJson(void)
  {
   CJson json;

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
   return 0;
  }
//+------------------------------------------------------------------+
