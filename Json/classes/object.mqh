//+------------------------------------------------------------------+
//|                                                       object.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"
#property strict

#include <Arrays\ArrayString.mqh>
#include "array.mqh"
#include "string.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJsonObject : public CJsonArray
  {
protected:
   CArrayString      m_keys;
public:
   virtual int       Type(void)const { return JSON_TYPE_OBJECT; }
   virtual string    Stringfy(const int i)const;
   virtual bool      KeyExist(const string key)const { return IndexOfKey(key) >= 0; }
   virtual string    KeyName(const int i)const { return m_keys.At(i); }
   virtual int       IndexOfKey(const string key)const;
   virtual CJsonBase *Key(const string key);
   virtual bool      Add(const string key, const string value, int &reads);
   static bool       GetKey(const string text, string &key, int &reads);
   static bool       GetValue(const string text, string &value, int &reads);
   static  string    NormalizeKey(string text);
   void              Clear(void) { m_keys.Clear(); CJsonArray::Clear(); }
protected:
   virtual ushort    CharToOpen(void)const { return '{'; }
   virtual ushort    CharToClose(void)const { return '}'; }
   virtual bool      ProcessChildren(const string parse, const int start, const int end, const string myString, const int myStart, const int myEnd);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CJsonObject::Stringfy(const int i)const
  {
   const string key = StringFormat("\"%s\"",m_keys.At(i));
   const string separator = ":";
   const string value = CJsonArray::Stringfy(i);
   return key + separator + value;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CJsonObject::IndexOfKey(const string key)const
  {
   string k;
   const int total = Total();
   for(int i=0; i<total; i++)
     {
      k = m_keys.At(i);
      if(k == key)
         return i;
     }
   return -1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CJsonBase *CJsonObject::Key(const string key)
  {
   const int i = IndexOfKey(key);
   CJsonBase *b;
   if(i>=0)
     {
      b = At(i);
      return b;
     }
   b = GetCJsonNewPointer();
   if(m_keys.Add(key))
      Add(b);
   return b;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonObject::ProcessChildren(const string parse, const int start, const int end, const string myString, const int myStart, const int myEnd)
  {
   Clear();
   if(myString == "{}")
      return true;
   const string content = GetContent(parse,myStart+1,myEnd-1);

   string tempValue;
   int tempLenght;
   string rightText;
   string key, value;
   int valueReaded;
   int reads;
   const int total = StringLen(content);
   for(int i=0; i<total; i++)
     {
      rightText = StringSubstr(content,i,total-1);
      if(!GetKey(rightText,key,reads))
         return false;

      i += reads +1; //jump ":"
      rightText = StringSubstr(content,i,total-1);
      if(!GetValue(rightText,value,reads))
         return false;

      i += reads;
      rightText = StringSubstr(content,i,total-1);

      //remove last coma
      tempValue = Trim(rightText);
      if(tempValue == "")
        {
         tempValue = Trim(value);
         tempLenght = StringLen(tempValue);
         const ushort c = StringGetCharacter(tempValue,tempLenght-1);
         if(c == ',')
            value = StringSubstr(tempValue,0,tempLenght-1);
        }

      if(!Add(key,value,valueReaded))
         return false;

      i -= StringLen(value) - valueReaded;
      rightText = StringSubstr(content,i,total-1);

      StringTrimLeft(rightText);
      StringTrimRight(rightText);
      if(rightText == "")
         return true;

      if(StringGetCharacter(rightText,0) != ',')
         return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonObject::Add(const string key, const string value, int &valueReaded)
  {
   CJsonBase *json = GetCJsonNewPointer();
   valueReaded = json.Parse(value);
   if(valueReaded == 0 && json.JsonType() != JSON_TYPE_STRING)
     {
      delete json;
      return false;
     }
   Add(json);
   m_keys.Add(key);
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonObject::GetKey(const string text, string &key, int &reads)
  {
   const int indexOfSeprator = StringFind(text,":");
   if(indexOfSeprator < 0)
      return false;
   string temp = StringSubstr(text,0,indexOfSeprator);
   StringTrimLeft(temp);
   if(temp == "")
      return false;
   reads = indexOfSeprator;
   key = NormalizeKey(temp);
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJsonObject::GetValue(const string text, string &value, int &reads)
  {
   ushort c = 0;
// set start
   int start = 0;
   const int total = StringLen(text);
   for(int i=0; i<total; i++)
     {
      c = StringGetCharacter(text,i);
      switch(c)
        {
         case ' ':
            continue;
         case '\r':
            continue;
         case '\n':
            continue;
         case '\t':
            continue;
        }
      start = i;
      break;
     }
// set end
   int end = 0;
   if(c == '\'' || c == '"') //this value is a string find the end....
     {
      const ushort firstChar = c;
      ushort last = c;
      for(int i=start+1; i<total; i++)
        {
         c = StringGetCharacter(text,i);
         if(c == firstChar && last != '\\')
           {
            end = i;
            break;
           }
         last = c;
        }
      // remove aspos
      value = StringSubstr(text,start+1,end-start-1);
      reads = end+1;
      return true;
     }
   value = text;
   reads = total;
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CJsonObject::NormalizeKey(string text)
  {
   StringTrimLeft(text);
   StringTrimRight(text);
   CJsonString::RemoveStringAspos(text);
   return text;
  }
//+------------------------------------------------------------------+
