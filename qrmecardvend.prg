// Programa   : QRMECARDVEND
// Fecha/Hora : 01/12/2018 18:50:09
// Propósito  : Generar QR del Vendedor
// Creado Por : Juan Navas
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN(cCodVen,lView)
   LOCAL cText,oTable,cFile

   DEFAULT cCodVen:=SQLGET("DPVENDEDOR","VEN_CODIGO")

   oTable:=OpenTable("SELECT * FROM DPVENDEDOR WHERE VEN_CODIGO"+GetWhere("=",cCodVen),.T.)
   oTable:End()
   
   cText:="BEGIN:VCARD"+CRLF+;
          "N:"           +ALLTRIM(oTable:VEN_NOMBRE)+CRLF+;
          "TEL;CELL:"    +ALLTRIM(oTable:VEN_CELULA  )+CRLF+;
          "TEL;WORK:"    +ALLTRIM(oTable:VEN_TELEFO  )+CRLF+;
          "TEL;WORK;FAX:"+ALLTRIM(oTable:VEN_CONTEL  )+CRLF+;
          "TEL;HOME:"    +ALLTRIM("" )+CRLF+;
          "ADR;HOME:;;"  +ALLTRIM("" )+CRLF+;
          "EMAIL:"       +ALLTRIM(oTable:VEN_EMAIL   )+CRLF+;
          "URL:http:"    +ALLTRIM(""      )+CRLF+;
          "NOTE:"        +"CODIGO="+ALLTRIM(oTable:VEN_CODIGO)+" RIF="+ALLTRIM(oTable:VEN_CEDULA)+CRLF+;
          "END:VCARD"

   cFile:="QRCODE\DPVEND_"+ALLTRIM(oTable:VEN_CODIGO)+".BMP"
/*
cText:="BEGIN:VCARD"+CRLF+"N:Reinaldo Zambrano"+CRLF+;
"TEL;CELL:600555555"+CRLF+"TEL;WORK:915555555"+CRLF+;
"TEL;WORK;FAX:915555555"+CRLF+;
"TEL;HOME:915555555"+CRLF+;
"TEL;HOME;FAX:915555555"+CRLF+;
"ADR;HOME:;;C/ calle, 12, 2º Derecha;Ciudad;Estado;28001;País"+CRLF+;
"ORG:empresa;departamento"+CRLF+;
"TITLE:Mr"+CRLF+;
"EMAIL:email@ejemplo.com"+CRLF+;
"URL:http://www.adaptaproerp.com"+CRLF+;
"EMAIL;IM:email@hotmail.com"+CRLF+;
"NOTE:Anotación del contacto"+CRLF+;
"BDAY:19800101"+;
"END:VCARD"
*/

 
  EJECUTAR("QRCODE", cText, cFile ,lView )

RETURN
// EOF
