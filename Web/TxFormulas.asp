﻿
<script type="text/javascript">

    var initCallBackMA = {};
    var rCallBack, rDummyData;

    var sID_Object = '<% = Request("var0")%>';
    var sDiv_Formula = '<% = Request("var1")%>';
    var sDisplay_Format = '<% = Request("var2")%>';
    var sEdit_Rights = '<% = Request("var3")%>';
    var sStore_Mode = '<% = Request("var4")%>';

    switch (sStore_Mode) {
        case '1':
            var sID_AS = '';
            var sID_Att_Inifile = '';
            var sTag_Formula = '<% = Request("var5")%>';
            break;

        case "0" : 
            var sID_AS = '<% = Request("var5")%>';
            var sID_Att_Inifile = '<% = Request("var6")%>';
            var sTag_Formula = '';
            break;
    } 

    var rResult = new Object();
    var rMessage = '';

    initCallBackMA['<%=request("sIdsMaAndObj")%>'] = function (aCB, aDD) {
        rCallBack = aCB;
        rDummyData = aDD;
        var jMAInput = {
            ID_Object: Number(sID_Object),
            sDiv_Formula: sDiv_Formula,
            iDisplay_Format: Number(sDisplay_Format),
            iEdit_Rights: Number(sEdit_Rights),
            iStore_Mode: Number(sStore_Mode),
            ID_AS: Number(sID_AS),
            ID_Att_Inifile: Number(sID_Att_Inifile),
            sTag_Formula: sTag_Formula
            
        };

        window.parent.Initialise_Popup("txFormula_simple", "temp_resources/models/TxFormula/WEB/TxFormulas_Popup.asp?Param1=" + JSON.stringify(jMAInput), 'Formula generator', 700, 500, 'temp_resources/models/TxFormula/web/iconFormulaForm.png', false, true, false, true);

        returnID(Number(sID_Object), rMessage);
    };

    function returnID(aID_Object, aMessage) {
        rResult.updateObject = new Object();
        rResult.updateObject.ID = aID_Object;

        rCallBack(rResult, rDummyData);

    };
       
       
  </script>
    

