//+------------------------------------------------------------------+
//|                                                       object.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#include "array.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJsonObject : public CJsonArray
  {
public:
   virtual int       Type(void)const { return JSON_TYPE_OBJECT; }
protected:
   virtual ushort    CharToOpen(void)const { return '{'; }
   virtual ushort    CharToClose(void)const { return '}'; }
  };
//+------------------------------------------------------------------+
