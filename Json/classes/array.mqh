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
   virtual string    Stringfy(const int i)const;
   virtual bool      Resize(const int size) { if(CArrayObj::Reserve(size)) { m_data_total = size; return true; } return false; }
protected:
   virtual ushort    CharToOpen(void)const { return '['; }
   virtual ushort    CharToClose(void)const { return ']'; }
   virtual ushort    Separator(void)const { return ','; }
   static int        IndexToClose(const string text, const ushort charToOpen, const ushort charToClose);
   virtual bool      IsMyChar(const string processed, const ushort c);
   virtual bool      IsMyString(const string text);
   virtual bool      ProcessChildren(const string parse, const int start, const int end, const string myString, const int myStart, const int myEnd);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CJsonArray::Stringfy(void)const
  {
   string text = "";
   text += CharToString((char)CharToOpen());
   const string separator = CharToString((char)Separator());
   const int total = Total();
   const int last = total -1;
   for(int i=0; i<total; i++)
     {
      text += Stringfy(i);
      if(i < last)
         text += separator;
     }
   text += CharToString((char)CharToClose());
   return text;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CJsonArray::Stringfy(const int i)const
  {
   CJsonBase *child = At(i);
   if(!CheckPointer(child))
      return "null";
   return child.Stringfy();
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
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonArray::ProcessChildren(const string parse,const int start,const int end,const string myString,const int myStart,const int myEnd)
  {
//clear my array
   Clear();
   int total = StringLen(myString);
   if(total <= 2)
      return true;
// get normal my content without spaces
   total = end-start+1;
   string content = StringSubstr(parse,start,total);
   content = Trim(content);
   content = StringSubstr(content,start+1,total-2);
   if(content == "")
      return true;
// redefine total
   total = StringLen(content);
// create jsons
   CJsonBase *cJson;
   int reads;
   ushort c;
   string contentTrunk;
   for(int i=0; i<total; i++)
     {
      c = StringGetCharacter(content,i);
      if(IsCharToIgnore(c))
         continue;
      if(c == Separator())
         continue;
      contentTrunk = StringSubstr(content,i);
      cJson = GetCJsonNewPointer();
      reads = cJson.Parse(contentTrunk);
      if(reads == 0)
        {
         delete cJson;
         return false;
        }
      Add(cJson);
      i += reads;
     }
   return true;
  }
//+------------------------------------------------------------------+
