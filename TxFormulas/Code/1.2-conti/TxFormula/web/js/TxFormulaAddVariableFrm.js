﻿var wFAV;
var lFAV;

function displayVariableWindow(aVariable , aCallback) {
    if (aVariable == undefined) aVariable = new TxVariable({ "cell_id": -1, "name": "New Variable", "value": 0, "unit": "tbd" });

    if (!dhxWins) {
        dhxWins = new dhtmlXWindows("dhx_blue");
        dhxWins.setImagePath('../../../resources/theme/img/dhtmlx/windows/');
    }

    wFAV = dhxWins.createWindow("editVariable", 10, 10, 250, 300);
    wFAV.setText("Edit Variable");
    wFAV.center();
    wFAV.denyPark();
    wFAV.button("close").hide();
    wFAV.denyResize();
    wFAV.setIcon("windowIcon");

    lFAV = wFAV.attachLayout("2E");
    lFAV.setAutoSize("", "a");

    var a = lFAV.cells('a');
    a.hideHeader();

    /* Data */
    /** Big div **/
    var bigdiv = document.createElement("div");
    bigdiv.setAttribute('style', 'width: 100%; height: 100%;  background: #e7f2ff;');
    a.attachObject(bigdiv);

    /*** Div variable Name ***/
    var divVariableName = document.createElement("div");
    divVariableName.setAttribute("id", "divVariableName");
    divVariableName.setAttribute("class", 'editdiv');

    /**** Caption for Name ****/
    var sNameVariableName = document.createTextNode('Variable Name :');
    divVariableName.appendChild(sNameVariableName);

    /**** Input for Name ****/
    var inputName = document.createElement('input');
    inputName.setAttribute('id', 'efVariableName')
    inputName.setAttribute('class', 'editinput');
    inputName.value = aVariable.name;

    divVariableName.appendChild(inputName);

    bigdiv.appendChild(divVariableName);

    /*** Div variable Value ***/
    var divVariableValue = document.createElement("div");
    divVariableValue.setAttribute("id", "divVariableValue");
    divVariableValue.setAttribute("class", 'editdiv');

    /**** Caption for Value ****/
    var sNameVariableValue = document.createTextNode('Variable Value :');
    divVariableValue.appendChild(sNameVariableValue);

    /**** Input for Value ****/
    var inputValue = document.createElement('input');
    inputValue.setAttribute('id', 'efVariableValue')
    inputValue.setAttribute('class', 'editinput');
    
    if(!aVariable){
        inputValue.value = 0;
    }else{
    inputValue.value = aVariable.value;
    }
    divVariableValue.appendChild(inputValue);

    bigdiv.appendChild(divVariableValue);

    /*** Div variable Unit ***/
    var divVariableUnit = document.createElement("div");
    divVariableUnit.setAttribute("id", "divVariableUnit");
    divVariableUnit.setAttribute("class", 'editdiv');

    /**** Caption for Value ****/
    var sNameVariableUnit = document.createTextNode('Variable Unit :');
    divVariableUnit.appendChild(sNameVariableUnit);

    /**** Input for Value ****/
    var inputUnit = document.createElement('input');
    inputUnit.setAttribute('id', 'efVariableUnit')
    inputUnit.setAttribute('class', 'editinput');
    if (aVariable.unit) inputUnit.value = aVariable.unit;
    divVariableUnit.appendChild(inputUnit);

    bigdiv.appendChild(divVariableUnit);

    a.attachObject(bigdiv);

    /** ToolBar in Layout B **/
    var b = lFAV.cells('b');
    b.hideHeader();
    b.setHeight(38);
    b.fixSize(1, 1);

    var divtoolbar = document.createElement('div');
    divtoolbar.setAttribute('id', 'divEditVarToolbar');
    divtoolbar.setAttribute('style', 'margin-top: 2px; height: 30px; overflow: hidden; margin-left:0px; padding-right:6px;')
    b.attachObject(divtoolbar);

    var editformtoolbar = new dhtmlXToolbarObject('divEditVarToolbar');
    editformtoolbar.setIconsPath("/Resources/theme/img/");
    editformtoolbar.setAlign("right");

    /*--Buttons--*/
    editformtoolbar.addButton('save', 0, 'Ok', 'btn_form/16x16_true.png');
    editformtoolbar.addButton('cancel', 1, 'Cancel', 'btn_form/16x16_false.png');

    editformtoolbar.attachEvent("onClick", function (id) {

        switch (id) {
            case "save":

                var doublon = ObjFormula.variables.some(function (variable) {
                    return inputName.value === variable.name;

                });

                // alert(doublon);
                if (doublon == true) {
                    dhtmlx.message({
                        text: "this variable already exists",
                        expire: 1000,
                        type: "customCss" // 'customCss' - css class
                    });



                } else {
                    
                    //checking of names in formula
                    var i;
                    var check= getParams(math.parse(ObjFormula.formula, {}).params).filter(function (e) {
                        return typeof e === "string";
                    });
                   
                   //if (! the var you're adding is in formula ){ adding var not available 9}
                     
                    if (check.indexOf(inputName.value) >= 0) {
                        
                         aVariable.name = inputName.value;
                         aVariable.value = Number(inputValue.value);
                         aVariable.unit = inputUnit.value;
                         if (!ObjFormula.getVariable(aVariable.cell_id)) { //== undefined) {
                             ObjFormula.variables.push(aVariable);
                             ObjFormula.renumVarIds();
                         };
                         ObjFormula.calculate();
                         ObjFormula.display();
                         dhxWins.window("editVariable").close();
                    } else {
                                        
                         dhtmlx.alert({ text: "variable absente de la formule" });
                          dhxWins.window("editVariable").close();
                         break;
                     }
                }

                /* try {*/
                if (aCallback) aCallback();
                break;

            default:
                dhxWins.window("editVariable").close();
        }

    });

}

