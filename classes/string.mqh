//+------------------------------------------------------------------+
//|                                                       string.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#include "base.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJsonString : public CJsonBase
  {
protected:
   string            m_string;
public:
   virtual int       Type(void)const { return JSON_TYPE_STRING; }
   virtual string    Value(void)const { return m_string; }
   virtual string    Stringfy(void)const { return StringFormat("\"%s\"",m_string); }
   virtual int       Parse(const string parse);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CJsonString::Parse(const string parse)
  {
   m_string = parse;
   return StringLen(parse);
  }
//+------------------------------------------------------------------+
