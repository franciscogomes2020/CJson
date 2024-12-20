//+------------------------------------------------------------------+
//|                                                       double.mqh |
//|                         Copyright 2024, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#include "base.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJsonDouble : public CJsonBase
  {
protected:
   double            m_double;
public:
   virtual int       Type(void)const { return JSON_TYPE_DOUBLE; }
   virtual string    Value(void)const { return (string) m_double; }
   virtual long      ValueToInt(void)const { return (long)m_double; }
   virtual double    ValueToDouble(void)const { return m_double; }
   virtual void      Value(const double value) { m_double = value; }
   virtual string    Stringfy(void)const { return Value(); }
protected:
   virtual bool      IsMyChar(const string processed, const ushort c);
   virtual bool      IsMyString(const string text);
   virtual bool      ProcessChildren(const string parse, const int start, const int end, const string myString, const int myStart, const int myEnd);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonDouble::IsMyChar(string base, ushort c)
  {
   switch(c)
     {
      case '-':
         if(base != "")
            return false;
      case '.':
         if(0 <= StringFind(base,"."))
            return false; // return false because is there a '.' on this base already
         break;
      default:
         if(c < '0' || c > '9')
            return false;
         break;
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonDouble::IsMyString(const string text)
  {
   if(text == "")
      return false;
   const int total = StringLen(text);
   for(int i=0; i<total; i++)
      if(!IsMyChar("",StringGetCharacter(text,i)))
         return false;
   if(-1 == StringFind(text,".")) // find at least one '.'
      return false;
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonDouble::ProcessChildren(const string parse,const int start,const int end,const string myString,const int myStart,const int myEnd)
  {
   if(-1 ==  StringFind(myString,"."))
      return false; // find at least one '.'
   m_double = (double)myString;
   return true;
  }
//+------------------------------------------------------------------+
