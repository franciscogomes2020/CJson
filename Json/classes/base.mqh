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
   ENUM_JSON_TYPE    JsonType(void)const { return (ENUM_JSON_TYPE)Type(); }
   virtual int       Total(void)const { return CArrayObj::Total(); }
   virtual string    Value(void)const { return ""; }
   virtual  bool     Value(const string value) { return false; }
   virtual void      Value(const int value) { Value(IntegerToString(value)); }
   virtual long      ValueToInt(void)const { return NULL; }
   virtual double    ValueToDouble(void)const { return NULL; }
   virtual string    Key(void)const { return ""; }
   virtual CJsonBase* Key(const string key) { return NULL; }
   virtual CJsonBase* Key(const int i) { return this.At(i); }
   virtual bool      KeyExist(const string key)const { return false; }
   virtual string    KeyName(const int i)const { return NULL; }
   virtual bool      SetKeyName(const string keyName) { return false; }
   virtual CJsonBase *ValuePointer(void) { return NULL; }
   static void       EscapeXml(string &text);
   static void       DecodeXml(string &text);
   static string     Trim(const string text);
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
   int iChecked = -1;
   for(i=start; i<=end; i++)
     {
      c = StringGetCharacter(parse,i);
      if(IsCharToIgnore(c))
         continue;
      if(!IsMyChar(myString,c))
         break;
      else
        {
         iChecked = i;
         if(myStart == -1)
            myStart = i;
        }
      myString+= CharToString((uchar)c);
     }
   if(!IsMyString(myString))
      return 0;
   const int count = i;
   myEnd = iChecked;
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
      case '\t':
      case '\r':
      case '\n':
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
//|                                                                  |
//+------------------------------------------------------------------+
string CJsonBase::Trim(const string text)
  {
   const int total = StringLen(text);
   ushort c;
   int s = 0;
   for(int i=0; i < total; i++)
     {
      c = StringGetCharacter(text,i);
      switch(c)
        {
         case ' ':
         case '\t':
         case '\r':
         case '\n':
            continue;
        }
      s = i;
      break;
     }
   int e = total-1;
   for(int i=total-1; i>=0; i--)
     {
      c = StringGetCharacter(text,i);
      switch(c)
        {
         case ' ':
         case '\t':
         case '\r':
         case '\n':
            continue;
        }
      e = i;
      break;
     }
   return StringSubstr(text,s,e-s+1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CJsonBase::EscapeXml(string &text)
  {
   StringReplace(text,"\"","&quot;");
   StringReplace(text,"\'","&apos;");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CJsonBase::DecodeXml(string &text)
  {
   StringReplace(text,"&quot;","\"");
   StringReplace(text,"&apos;","\'");
  }
//+------------------------------------------------------------------+
