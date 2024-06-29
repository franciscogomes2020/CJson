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
   virtual bool      Value(const string value) { m_string = value; return true; }
   virtual string    Stringfy(void)const { return StringFormat("\"%s\"",m_string); }
   virtual int       Parse(const string parse);
   static bool       RemoveStringAspos(string &text);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CJsonString::Parse(const string parse)
  {
   string text = parse;
   RemoveStringAspos(text);
   m_string = text;
   return StringLen(parse);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonString::RemoveStringAspos(string &text)
  {
   int total = StringLen(text);
   if(total < 2)
      return false;
   ushort first = StringGetCharacter(text,0),
          last = StringGetCharacter(text,total-1);
   if(first != last)
      return false;
   if(first != '\'' && first != '"')
      return false;
   text = StringSubstr(text,1,total-2);
   return true;
  }
//+------------------------------------------------------------------+
