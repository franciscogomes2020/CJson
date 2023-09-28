//+------------------------------------------------------------------+
//|                                                    undefined.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#include "base.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJsonUndefined : public CJsonBase
  {
public:
   virtual int       Type(void)const { return JSON_TYPE_UNDEFINED; }
   virtual string    Stringfy(void)const { return ""; }
  };
CJsonUndefined GlobalJsonUndefinedInstance;
#define JSON_UNDEFINED_INSTANCE (&GlobalJsonUndefinedInstance)
//+------------------------------------------------------------------+
