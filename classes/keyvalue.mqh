//+------------------------------------------------------------------+
//|                                                     keyvalue.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#include "string.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJsonKeyValue : public CJsonBase
  {
protected:
   string            m_key;
   CJsonBase         *m_value;
public:
   virtual int       Type(void)const { return JSON_TYPE_KEY_VALUE; }
   virtual string    Key(void)const { return m_key; }
   virtual string    Value(void)const { return m_value.Value(); }
   virtual string    Stringfy(void)const { return StringFormat("\"%s\":%s", m_key, m_value.Stringfy()); }
protected:
   virtual bool      IsMyString(const string text);
   virtual bool      IsMyChar(const string base, const ushort c);
   virtual bool      ProcessChildren(const string parse, const int start, const int end, const string myString, const int myStart, const int myEnd);
   static string     NormalizeKey(const string key);
   static bool       IsKey(string key);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonKeyValue::IsMyChar(const string base, const ushort c)
  {
   if(c == ',')
      return false;
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonKeyValue::IsMyString(const string text)
  {
   string array[];
   int total = StringSplit(text,':',array);
   if(total != 2)
      return false;
   if(!IsKey(array[0]))
      return false;
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonKeyValue::IsKey(string key)
  {
   key = NormalizeKey(key);
   const int total = StringLen(key);
   ushort c;
   for(int i=0; i<total; i++)
     {
      c = StringGetCharacter(key,i);
      // if find oter aspos so is a string instead key
      if(c=='\'' || c=='"')
         return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonKeyValue::ProcessChildren(const string parse, const int start, const int end, const string myString, const int myStart, const int myEnd)
  {
   string content = GetContent(parse,start,end);
   string array[];
   const int total = StringSplit(content,':',array);
   if(total != 2)
      return false;
   string key = array[0];
   string value = array[1];
   CJsonBase *json = GetCJsonNewPointer();
   if(!(bool)json.Parse(value))
     {
      delete json;
      return false;
     }
   m_value = json;
   m_key = NormalizeKey(key);
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CJsonKeyValue::NormalizeKey(string text)
  {
   StringTrimLeft(text);
   StringTrimRight(text);
   CJsonString::RemoveStringAspos(text);
   return text;
  }
//+------------------------------------------------------------------+
