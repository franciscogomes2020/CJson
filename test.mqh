//+------------------------------------------------------------------+
//|                                                         test.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"
/*+------------------------------------------------------------------+
//| how to use:                                                      |
//| past this code in some part of your code                         |
//|+-----------------------------------------------------------------+
#include <Json\test.mqh>
int runTestCJson = TestCJson();


//+-----------------------------------------------------------------*/
//| defines to make tests                                            |
//+------------------------------------------------------------------+
#define ASSERT_EQUALS(x,y) AssertEquals((x),(y),__FUNCTION__,__LINE__);

template<typename Type1, typename Type2>
bool AssertEquals(const Type1 valueResult, const Type2 valueWaited, const string function=NULL, const int line=NULL)
  {
   if(valueResult == valueWaited)
      return true;
   Comment("Test fail: ", valueResult," is not equal ", valueWaited,
           (function==NULL?"": " in "+function)," ",
           (line==NULL?"":" at line "+IntegerToString(line))
          );
   DebugBreak();
   return false;
  }

//+------------------------------------------------------------------+
//| init of tests                                                    |
//+------------------------------------------------------------------+
#include <Json\json.mqh>
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

// key --> value using simple aspo to value
   ASSERT_EQUALS((json="key:'value'"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_STRING);
   ASSERT_EQUALS(json.Stringfy(), "\"key\":\"value\"");
   ASSERT_EQUALS(json.Value(), "value");
   ASSERT_EQUALS(json.Key(), "key");

// key --> value using double aspo to value
   ASSERT_EQUALS((json="key:\"value\""), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_STRING);
   ASSERT_EQUALS(json.Stringfy(), "\"key\":\"value\"");
   ASSERT_EQUALS(json.Value(), "value");
   ASSERT_EQUALS(json.Key(), "key");

// key --> value using simple aspo to key and value
   ASSERT_EQUALS((json="'key':'value'"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_STRING);
   ASSERT_EQUALS(json.Stringfy(), "\"key\":\"value\"");
   ASSERT_EQUALS(json.Value(), "value");
   ASSERT_EQUALS(json.Key(), "key");

// key --> value using double aspo to key and simple aspo to value
   ASSERT_EQUALS((json="\"key\":'value'"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_STRING);
   ASSERT_EQUALS(json.Stringfy(), "\"key\":\"value\"");
   ASSERT_EQUALS(json.Value(), "value");
   ASSERT_EQUALS(json.Key(), "key");

// key --> value using double aspo to key and value
   ASSERT_EQUALS((json="\"key\":\"value\""), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_STRING);
   ASSERT_EQUALS(json.Stringfy(), "\"key\":\"value\"");
   ASSERT_EQUALS(json.Value(), "value");
   ASSERT_EQUALS(json.Key(), "key");

// object with 1 key
   ASSERT_EQUALS((json="{name:\"default\"}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(), "{\"name\":\"default\"}");
   ASSERT_EQUALS(json.Total(), 1);
   ASSERT_EQUALS(json.KeyExist("name"),true);
   ASSERT_EQUALS(json["name"].Value(),"default");
   ASSERT_EQUALS(json["name"].Type(),JSON_TYPE_STRING);
   ASSERT_EQUALS(json["name"].Stringfy(),"\"name\":\"default\"");

// object with 1 key without aspos and single aspos on string
   ASSERT_EQUALS((json="{name:'default'}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(), "{\"name\":\"default\"}");
   ASSERT_EQUALS(json.Total(), 1);

// object with 2 key
   ASSERT_EQUALS((json="{v1:'defaultV1',v2:'defaultV2'}"), true);
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

// operator =
   ASSERT_EQUALS(json = new CJson,true);
   return 0;
  }
//+------------------------------------------------------------------+
