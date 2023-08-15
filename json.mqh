//+------------------------------------------------------------------+
//|                                                         json.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

#include "classes\array.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CJson : public CJsonBase
  {
protected:
   CJsonBase         *m_json;
public:
                    ~CJson();
   bool              operator=(const string parse) { return Parse(parse); }
   CJsonBase        *operator[](const int i) { return m_json.At(i); }
   bool              Parse(const string parse);
   string            Stringfy(void)const { return m_json.Stringfy(); }
   virtual int       Type(void)const { return m_json.Type(); }
private:
   bool              SetJson(CJsonBase *json, const string parse);
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
bool CJson::Parse(const string parse)
  {
   if(SetJson(new CJsonArray, parse))
      return true;
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CJson::SetJson(CJsonBase *json, const string parse)
  {
   if(CheckPointer(m_json) == POINTER_DYNAMIC)
      delete m_json;
   m_json = json;
   return m_json.Parse(parse);
  }
//+------------------------------------------------------------------+
