//+------------------------------------------------------------------+
//|                                                       object.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#include "array.mqh"
#include "keyvalue.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJsonObject : public CJsonArray
  {
public:
   virtual int       Type(void)const { return JSON_TYPE_OBJECT; }
   virtual bool      KeyExist(const string key)const { return IndexOfKey(key) >= 0; }
   virtual int       IndexOfKey(const string key)const;
   virtual CJsonBase *Key(const string key);
protected:
   virtual ushort    CharToOpen(void)const { return '{'; }
   virtual ushort    CharToClose(void)const { return '}'; }
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CJsonObject::IndexOfKey(const string key)const
  {
   CJsonBase *o;
   const int total = Total();
   for(int i=0; i<total; i++)
     {
      o = At(i);
      if(o.Key() == key)
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
   CJsonKeyValue *keyValue;
   CJsonBase *b;
   if(i>=0)
     {
      b = At(i);
      return b;
     }
   keyValue = new CJsonKeyValue;
   keyValue.Key(key);
   Add(keyValue);
   return keyValue;
  }
//+------------------------------------------------------------------+
