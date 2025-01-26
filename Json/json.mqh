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
#include "classes\double.mqh"
#include "classes\int.mqh"
#include "classes\undefined.mqh"
#include "classes\null.mqh"
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
   bool              operator=(const int value) { return (bool)Parse((string)value); }
   bool              operator=(const long value) { return (bool)Parse((string)value); }
   bool              operator=(const double value) { return (bool)Parse((string)value); }
   CJson*            operator[](const int i) { return At(i); }
   CJson*            operator[](const string key) { return Key(key); }
   bool              operator==(ENUM_JSON_TYPE type)const { return JsonType() == type; }
   bool              operator!=(ENUM_JSON_TYPE type)const { return JsonType() != type; }
   CJson*            At(const int i);
   int               Parse(const string parse);
   virtual string    Stringfy(void)const { return Json().Stringfy(); }
   virtual int       Type(void)const { return Json().Type(); }
   virtual int       Total(void)const { return Json().Total(); }
   virtual string    Value(void)const { return Json().Value(); }
   virtual long      ValueToInt(void)const { return Json().ValueToInt(); }
   virtual double    ValueToDouble(void)const { return Json().ValueToDouble(); }
   virtual bool      Value(const string value) { return Json().Value(value); }
   string            Key(void)const { return Json().Key(); }
   virtual bool      KeyExist(const string key)const { return Json().KeyExist(key); }
   virtual string    KeyName(const int i)const { return Json().KeyName(i); }
   virtual CJsonBase* Key(const string key);
   virtual CJsonBase* Key(const int i) { return At(i); }
   virtual CJsonBase *ValuePointer(void) { return Json().ValuePointer(); }
protected:
   virtual bool      SetJson(CJsonBase *json);
   CJsonBase*        Json(void)const { return CheckPointer(m_json) == POINTER_INVALID ? JSON_UNDEFINED_INSTANCE : m_json; }
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
   if(SetJson(new CJsonDouble, parse, charReads))
      return charReads;
   if(SetJson(new CJsonInt, parse, charReads))
      return charReads;
   if(SetJson(new CJsonNull, parse, charReads))
      return charReads;
// if rearchs here so classific as string
   delete m_json;
   m_json = new CJsonString;
   return m_json.Parse(parse);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CJson *CJson::At(const int i)
  {
   CJsonBase *json = Json();
   if(json.Type()==JSON_TYPE_ARRAY || json.Type()==JSON_TYPE_OBJECT)
     {
      CJsonArray *arr = json;
      if(arr.Total() <= i)
        {
         arr.Resize(i+1);
        }
      if(!CheckPointer(arr.At(i)))
        {
         arr.Update(i,new CJson);
        }
      return dynamic_cast<CJson *>(arr.At(i));
     }
   SetJson(new CJsonArray);
   return At(i);
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
CJsonBase *CJson::Key(const string key)
  {
   if(Type() != JSON_TYPE_OBJECT)
      SetJson(new CJsonObject);
   return m_json.Key(key);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CJsonBase *GetCJsonNewPointer(void)
  {
   return new CJson;
  }
//+------------------------------------------------------------------+
