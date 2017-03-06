///<author>dev@bassetti.fr</author>
///<summary>Unit loading / unloading the dll named "TxContextVariables". This file is generated by TXUtils. Do not modify.</summary>
unit U_Abstract_TxContextVariables;
interface

uses
  Generics.Collections,Windows,SysUtils,Classes,Contnrs,Math,U_Small_Lib,U_Class,U_Abstract;

type
  {$REGION 'U_WebFunctions'}
  ///<summary>Function setting a given pair key / value and returning the value.</summary>
  TSetVariable=function(AArrInput: array of TVarRec): TArr_VarRec; stdcall;

  ///<summary>Function returning the value of a given constant stored into the file 'Context_Variables.exml'.</summary>
  TGetConstant=function(AArrInput: array of TVarRec): TArr_VarRec; stdcall;

  ///<summary>Function returning the value of a given variable. It does NOT remove the variable.</summary>
  TGetVariable=function(AArrInput: array of TVarRec): TArr_VarRec; stdcall;

  ///<summary>Function returning the value of a given variable. It DOES erase the variable.</summary>
  TExtractVariable=function(AArrInput: array of TVarRec): TArr_VarRec; stdcall;

  ///<summary>Function reading from the database the settings of a given object and tag.</summary>
  TReadObjectSettings=function(AArrInput: array of TVarRec): TArr_VarRec; stdcall;

  ///<summary>Function writting (Insert/Update/Delete) into the database the settings of a given object and tag.</summary>
  TWriteObjectSettings=function(AArrInput: array of TVarRec): TArr_VarRec; stdcall;
  {$ENDREGION}



var
  {$REGION 'U_WebFunctions'}
  SetVariable: TSetVariable;
  GetConstant: TGetConstant;
  GetVariable: TGetVariable;
  ExtractVariable: TExtractVariable;
  ReadObjectSettings: TReadObjectSettings;
  WriteObjectSettings: TWriteObjectSettings;
  {$ENDREGION}


///<summary>Procedure loading the dll named "TxContextVariables".</summary>
///<param name="AFilePath">The absolute path to the dll.</param>
procedure Load_TxContextVariables(AFilePath: string);

///<summary>Procedure unloading the dll named "TxContextVariables".</summary>
procedure Unload_TxContextVariables;

///<summary>Function returning true if the dll "TxContextVariables" was loaded.</summary>
function Get_Dll_TxContextVariables_Loaded: boolean;

implementation

var
  hDll: THandle;

procedure Load_TxContextVariables(AFilePath: string);
resourcestring
  RS_Error_Invalide_File='Le fichier %s n''est pas valide.';
begin
  if hDll <> 0 then
    exit;

  Check_FileExists(AFilePath);

  hDll := Load_Dll(AFilePath);

  {$REGION 'U_WebFunctions'}
  @SetVariable := Get_Dll_Function_Adress(hDll,'SetVariable',AFilePath);
  @GetConstant := Get_Dll_Function_Adress(hDll,'GetConstant',AFilePath);
  @GetVariable := Get_Dll_Function_Adress(hDll,'GetVariable',AFilePath);
  @ExtractVariable := Get_Dll_Function_Adress(hDll,'ExtractVariable',AFilePath);
  @ReadObjectSettings := Get_Dll_Function_Adress(hDll,'ReadObjectSettings',AFilePath);
  @WriteObjectSettings := Get_Dll_Function_Adress(hDll,'WriteObjectSettings',AFilePath);
  {$ENDREGION}


end;

procedure Unload_TxContextVariables;
begin
  if hDll <> 0 then
  begin
    try
      FreeLibrary(hDll);
      hDll := 0;
    except
    end;
  end;
end;

function Get_Dll_TxContextVariables_Loaded: boolean;
begin
  result := (hDll>0)
end;

initialization
  hDll := 0;

finalization
  Unload_TxContextVariables;

end.