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

   return 0;
  }
//+------------------------------------------------------------------+
