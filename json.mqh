//+------------------------------------------------------------------+
//|                                                         json.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#define CJSON_CLASS

#include "classes\array.mqh"
#include "classes\object.mqh"
#include "classes\keyvalue.mqh"
#include "classes\undefined.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJson : public CJsonBase
  {
protected:
   CJsonBase         *m_json;
public:
                    ~CJson();
   bool              operator=(const string parse) { return (bool)Parse(parse); }
   CJsonBase        *operator[](const int i) { return m_json.At(i); }
   CJsonBase        *operator[](const string key);
   int               Parse(const string parse);
   string            Stringfy(void)const { return m_json.Stringfy(); }
   virtual int       Type(void)const { return m_json.Type(); }
   int               Total(void)const { return m_json.Total(); }
   virtual string    Value(void)const { return m_json.Value(); }
   string            Key(void)const { return m_json.Key(); }
   virtual bool      KeyExist(const string key)const;
   virtual CJsonBase *ValuePointer(void) { return m_json.ValuePointer(); }
private:
   bool              SetJson(CJsonBase *json, const string parse, int &charReads);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CJson::~CJson()
  {
   if(CheckPointer(m_json) == POINTER_DYNAMIC)
      delete m_json;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CJsonBase *CJson::operator[](const string key)
  {
   switch(Type())
     {
      case JSON_TYPE_OBJECT:
         return (dynamic_cast<CJsonObject *>(m_json)).Key(key);
     }
   Comment("Wrong call to ",__FUNCTION__, "\nThis instance is not a ",EnumToString(JSON_TYPE_OBJECT));
   DebugBreak();
   return &this;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CJson::Parse(const string parse)
  {
   int charReads;
   if(SetJson(new CJsonArray, parse, charReads))
      return charReads;
   if(SetJson(new CJsonObject, parse, charReads))
      return charReads;
   if(SetJson(new CJsonKeyValue, parse, charReads))
      return charReads;
// if rearchs here so classific as string
   delete m_json;
   m_json = new CJsonString;
   return m_json.Parse(parse);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJson::SetJson(CJsonBase *json, const string parse, int &charReads)
  {
   if(CheckPointer(m_json) == POINTER_DYNAMIC)
      delete m_json;
   m_json = json;
   charReads = m_json.Parse(parse);
   return (bool)charReads;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJson::KeyExist(const string key)const
  {
   switch(Type())
     {
      case JSON_TYPE_KEY_VALUE:
         return (dynamic_cast<CJsonKeyValue *>(m_json)).KeyExist(key);
      case JSON_TYPE_OBJECT:
         return (dynamic_cast<CJsonObject *>(m_json)).KeyExist(key);
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CJsonBase *GetCJsonNewPointer(void)
  {
   return new CJson;
  }
//+------------------------------------------------------------------+
