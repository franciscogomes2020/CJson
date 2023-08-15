//+------------------------------------------------------------------+
//|                                                        array.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#include "base.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJsonArray : public CJsonBase
  {
public:
   virtual int       Type(void)const { return JSON_TYPE_ARRAY; }
   virtual string    Stringfy(void)const;
protected:
   virtual ushort    CharToOpen(void)const { return '['; }
   virtual ushort    CharToClose(void)const { return ']'; }
   static int        IndexToClose(const string text, const ushort charToOpen, const ushort charToClose);
   virtual bool      IsMyChar(const string processed, const ushort c);
   virtual bool      IsMyString(const string text);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CJsonArray::Stringfy(void)const
  {
   string text = "";
   text += CharToString((char)CharToOpen());
   text += CharToString((char)CharToClose());
   return text;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CJsonArray::IndexToClose(const string text, const ushort charToOpen, const ushort charToClose)
  {
   const int lenght = StringLen(text);
   ushort c;
   int opened = 0;
   int closed = 0;

   for(int i=0; i<lenght; i++)
     {
      c = StringGetCharacter(text,i);
      if(c == charToOpen)
         opened++;
      else
         if(c == charToClose)
           {
            closed++;
            if(opened == closed)
               return i;
           }
     }
   return -1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonArray::IsMyChar(string base, ushort c)
  {
   if(base == "")
      return c == CharToOpen();
   const int iparenthesiclose = IndexToClose(base,CharToOpen(),CharToClose());
   if(iparenthesiclose == -1) //do not close yet
      return true;
   else
      return false; //the string is already done
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonArray::IsMyString(const string text)
  {
   if(StringFind(text,CharToString((char)CharToOpen())) != 0)
      return false;
   const int lenght = StringLen(text);
   const int last = lenght -1;
   const int indexThatClose = IndexToClose(text,CharToOpen(),CharToClose());
   const bool result = (indexThatClose == last);
   return result;
  }
//+------------------------------------------------------------------+
