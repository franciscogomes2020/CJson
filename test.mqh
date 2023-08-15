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
#define ASSERT_EQUALS(x,y) if(x!=y){ Comment("Test fail: ", (x) ," is not equal ", (y), " at LINE ", __LINE__); DebugBreak(); }

#include <Json\json.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TestCJson(void)
  {
   CJson json;
   ASSERT_EQUALS((json="[]"), true);
   return 0;
  }
//+------------------------------------------------------------------+
