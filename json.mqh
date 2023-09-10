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
   bool              operator=(CJsonBase *json) { return SetJson(json); }
   bool              operator=(const string parse) { return (bool)Parse(parse); }
   CJson*            operator[](const int i) { return m_json.At(i); }
   CJson*            operator[](const string key) { return Key(key); }
   bool              operator==(ENUM_JSON_TYPE type)const { return JsonType() == type; }
   bool              operator!=(ENUM_JSON_TYPE type)const { return JsonType() != type; }
   virtual CJsonBase* Key(const string key) { return m_json.Key(key); }
   int               Parse(const string parse);
   virtual string    Stringfy(void)const { return Type() == JSON_TYPE_UNDEFINED ? "" : m_json.Stringfy(); }
   virtual int       Type(void)const { return CheckPointer(m_json) == POINTER_INVALID ? JSON_TYPE_UNDEFINED : m_json.Type(); }
   virtual int       Total(void)const { return m_json.Total(); }
   virtual string    Value(void)const { return m_json.Value(); }
   virtual bool      Value(const string value) { return m_json.Value(value); }
   string            Key(void)const { return m_json.Key(); }
   virtual bool      KeyExist(const string key)const { return m_json.KeyExist(key); }
   virtual CJsonBase *ValuePointer(void) { return m_json.ValuePointer(); }
protected:
   virtual bool      SetJson(CJsonBase *json);
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
int CJson::Parse(const string parse)
  {
   int charReads;
   if(SetJson(new CJsonArray, parse, charReads))
      return charReads;
   if(SetJson(new CJsonObject, parse, charReads))
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
   SetJson(json);
   charReads = m_json.Parse(parse);
   return (bool)charReads;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJson::SetJson(CJsonBase *json)
  {
   if(CheckPointer(m_json) == POINTER_DYNAMIC)
      delete m_json;
   m_json = json;
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CJsonBase *GetCJsonNewPointer(void)
  {
   return new CJson;
  }
//+------------------------------------------------------------------+
