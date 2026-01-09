//+------------------------------------------------------------------+
//|                                                          int.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#include "base.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJsonInt : public CJsonBase
  {
protected:
   long              m_int;
public:
   virtual int       Type(void)const { return JSON_TYPE_INT; }
   virtual string    Value(void)const { return IntegerToString(m_int); }
   virtual long      ValueToInt(void)const { return m_int; }
   virtual double    ValueToDouble(void)const { return (double)m_int; }
   virtual void      Value(const long value) { m_int = value; }
   virtual string    Stringfy(void)const { return Value(); }
protected:
   virtual bool      IsMyChar(const string processed, const ushort c);
   virtual bool      IsMyString(const string text);
   virtual bool      ProcessChildren(const string parse, const int start, const int end, const string myString, const int myStart, const int myEnd);
   static  bool      IsIntegerSeparator(const ushort c);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonInt::IsMyChar(string base, ushort c)
  {
   if(c == '-' && base == "")
      return true;
   if(c < '0' || c > '9')
      return false;
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonInt::IsMyString(const string text)
  {
   if(text == "")
      return false;
   const int total = StringLen(text);
   for(int i=0; i<total; i++)
      if(!IsMyChar("",StringGetCharacter(text,i)))
         return false;
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonInt::ProcessChildren(const string parse,const int start,const int end,const string myString,const int myStart,const int myEnd)
  {
//check if was a double
   ushort c;
   const int parseTotal = StringLen(parse);
   const int myStringTotal = StringLen(myString);
   const int myNext = myEnd + 1;
   if(myStringTotal > parseTotal)
      return false;
   c = StringGetCharacter(parse,myNext);
   if(c == '.')
     {
      return false;
     }
   if(!IsIntegerSeparator(c))
     {
      return false;
     }

   m_int = StringToInteger(myString);
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonInt::IsIntegerSeparator(const ushort c)
  {
   switch(c)
     {
      case ' ':
      case '\t':
      case '\n':
      case '\r':
      case ',':
      case 0:
         return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
