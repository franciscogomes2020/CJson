//+------------------------------------------------------------------+
//|                                                     jsonBase.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#include <Arrays\ArrayObj.mqh>
#include "define.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJsonBase : public CArrayObj
  {
public:
   virtual int       Parse(const string parse);
   virtual string    Stringfy(void)const=NULL;
   virtual int       Type(void)const=NULL;
   virtual string    Value(void)const { return ""; }
   virtual string    Key(void)const { return ""; }
   virtual CJsonBase *ValuePointer(void) { return NULL; }
protected:
   static string     GetContent(const string parse, const int start, const int end);
   virtual int       ProcessParse(const string parse, const int start, const int end);
   virtual string    NormalizeString(string text) { return text; }
   virtual bool      IsCharToIgnore(const ushort c);
   virtual bool      ProcessChildren(const string parse, const int start, const int end, const string myString, const int myStart, const int myEnd) { return true; }
   virtual bool      IsMyChar(const string processed, const ushort c) { return false; }
   virtual bool      IsMyString(const string text) { return false; }
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CJsonBase::Parse(const string parse)
  {
   const string text = NormalizeString(parse);
   return ProcessParse(text,0,StringLen(text)-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CJsonBase::ProcessParse(const string parse, const int start, const int end)
  {
   int myStart = -1, myEnd;
   int i;
   ushort c;
   string myString = "";
   for(i=start; i<=end; i++)
     {
      c = StringGetCharacter(parse,i);
      if(IsCharToIgnore(c))
         continue;
      if(!IsMyChar(myString,c))
         break;
      else
         if(myStart == -1)
            myStart = i;
      myString+= CharToString((uchar)c);
     }
   if(!IsMyString(myString))
      return 0;
   const int count = i;
   myEnd = count -1;
   if(!ProcessChildren(parse,start,end,myString,myStart,myEnd))
      return 0;
   return count;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonBase::IsCharToIgnore(const ushort c)
  {
   switch(c)
     {
      case ' ':
         return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CJsonBase::GetContent(const string parse,const int start,const int end)
  {
   if(StringLen(parse) == 0)
      return "";
   const int total = end - start +1;
   return StringSubstr(parse,start,total);
  }
//+------------------------------------------------------------------+
