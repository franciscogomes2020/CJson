//+------------------------------------------------------------------+
//|                                                         null.mqh |
//|                         Copyright 2025, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"
#property version   "1.00"

#include "base.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJsonNull : public CJsonBase
  {
public:
   virtual int       Type(void)const { return JSON_TYPE_NULL; }
   virtual string    Value(void)const { return "null"; }
   virtual string    Stringfy(void)const { return Value(); }
protected:
   virtual bool      IsMyChar(const string processed, const ushort c);
   virtual bool      IsMyString(const string text);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonNull::IsMyChar(string base, ushort c)
  {
   switch(c)
     {
      case 'n':
         if(base == "")
            return true;
      case 'u':
         if(base == "n")
            return true;
      case 'l':
         if(base == "nu")
            return true;
         if(base == "nul")
            return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonNull::IsMyString(const string text)
  {
   return text == "null";
  }
//+------------------------------------------------------------------+
