//+------------------------------------------------------------------+
//|                                                  testAsserts.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#ifndef ASSERT_EQUALS
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
#define ASSERT_EQUALS(x,y) if(!AssertEquals(x,y,NULL,NULL,false)) { DebugBreak(); AssertEquals((x),(y),__FUNCTION__,__LINE__); }
//+------------------------------------------------------------------+
//| asserts                                                          |
//+------------------------------------------------------------------+
template<typename Type1, typename Type2>
bool AssertEquals(const Type1 valueResult, const Type2 valueWaited, const string function=NULL, const int line=NULL, const int debugBreak=true)
  {
   if(valueResult == valueWaited)
      return true;
   if(debugBreak)
     {
      Comment("Test fail: ", valueResult," is not equal ", valueWaited,
              (function==NULL?"": " in "+function)," ",
              (line==NULL?"":" at line "+IntegerToString(line))
             );
      DebugBreak();
     }
   return false;
  }
#endif
//+------------------------------------------------------------------+
