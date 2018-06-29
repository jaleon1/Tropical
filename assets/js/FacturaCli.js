class FacturaCli {
    // Constructor
    constructor(id, cajero, producto, descuento, total, fechaCreacion, importe, t, idusuario, idcliente) {
        this.id = id || null;
        this.cajero = cajero || '';
        this.idusuario = idusuario || '';
        this.idcliente = idcliente || '';
        this.descuento = descuento || 0;
        this.producto = producto || new Array(new Array());
        this.total = total || '';
        this.fechaCreacion = fechaCreacion || null;
        this.importe = importe || 0;
        this.t = t || null;
    }
}

let facturaCli = new FacturaCli();
var t; //se usa para la tabla
sabores = 2; //cantidad maxima de sabores a elegir
toppings = 1; //cantidad maxima de toppings a elegir

sel_sabores = new Array(); //almacena los sabores seleccionados

sel_tamano = "Grande"; //almacena el tamaño seleccionados

sel_toppings = new Array(); //almacena los toppings seleccionados

prd_x_fac = new Array(); // almacena los productos y a su vez los detalles de cada uno

indice_prd = 0;

$(document).ready(function () {
    // Recarga la página para limpiar todo
    $('#btn_limpia').click(function () {
        location.reload();
    });

    sel_tamano = "Grande";

    LoadAllPrdVenta();

    t = $('#prd').DataTable( {
            "paging":   false,
            "ordering": false,
            "info":     false,
            "searching": false,
            "language": {
                "infoEmpty": "No hay productos agregados",
                "emptyTable": "No hay productos agregados",
                "search": "Buscar En Factura" //Cambia el texto de Search
            },
            "columnDefs": [ 
                {
                    "visible": false,
                    "targets": 0,
                    "searchable": false
                },
                { 
                    // "width": "2%", 
                    "targets": 1,
                    "searchable": false
                },
                { 
                    "width": "8%", "targets": 2
                }
            ]
    });


    $('#prd').on( 'click', 'tr', function () {     
        prd_row = this;
        borraPRD(prd_row);
    } );



});


$("#btngrande").click(function () {
    $("#btngrande").addClass("selected");
    $("#btnmediano").removeClass("selected");
    sel_tamano = "Grande";
});


$("#btnmediano").click(function () {
    $("#btnmediano").addClass("selected");
    $("#btngrande").removeClass("selected");
    sel_tamano = "Mediano";
});


function LoadAllPrdVenta() {
    $.ajax({
        type: "POST",
        url: "class/Producto.php",
        data: {
            action: "ReadAll"
        }
    })
        .done(function (e) {
            DrawPrd(e);
        })
        .fail(function (e) {
            showError(e);
        });

};


function DrawPrd(e) {
    productos = JSON.parse(e);
    $.each(productos, function (item, value) {
        switch (productos[item].esventa) {
            case "1":
               DrawSabor(productos[item]);
                break;
            case "2":
                DrawTopping(productos[item]);
                break;
            default:
                return false
        };
    });
};



function DrawSabor(sabores){
    var prd = `
    <button id="btn_${sabores.id}" class="btn_sabor btn_venta" style="background-color:${sabores.bgcolor};" onclick="agregaSabor('${sabores.id}', '${sabores.nombre}')">
        <div class="btn_prd" style="color:${sabores.txtcolor}";>
            <h5>${sabores.nombre}</h5>
            <p id="cant_sabor_${sabores.id}"></p>
        </div>
    </button>`;
    $('#prdXbdg').append(prd);
};


function DrawTopping(toppings){
    var prd = `
        <button id="btn_${toppings.id}" style="background-color:${toppings.bgcolor};" class="btn_topping btn_venta" onclick="agrega_toppings('${toppings.id}', '${toppings.nombre}')">
            <div style="color: ${toppings.txtcolor};">
                <h5>${toppings.nombre}</h5>
                <p id="cant_topping_${toppings.id}">\xa0</p>
            </div>
        </button>`;
        $('#toppings').append(prd);
};


function verificaCantidad(tipo) {
    switch (tipo) {
        case "sabor":
            if (sabores > 0) {
                sabores = sabores - 1;
                return true
            }
            break;
        case "topping":
            if (toppings > 0) {
                toppings = toppings - 1;
                return true
            }
            break;
        default:
            return false
    }
};


function agregaSabor(id, nombre) {
    if (verificaCantidad("sabor")) {
        if (($("#cant_sabor_" + id).text()) != "1" && ($("#cant_sabor_" + id).text()) != "2") {
            $("#cant_sabor_" + id).text("1");
        }
        else {
            $("#cant_sabor_" + id).text((parseInt($("#cant_sabor_" + id)[0].textContent) + 1));
        }

        sabo = new Object();
        sabo.id = id;
        sabo.nombre = nombre;

        sel_sabores.push(sabo);

        $("#btn_" + id).addClass("selected");

        var prd =
            `<strong id="eleccion_${id}" class="saborelegido" onclick="quitaSabor('${id}')">
            ${nombre} 
            <spam class="glyphicon glyphicon-remove"</spam>  
        </strong>`;

        $('#sabores_elegidos').append(prd);

        $("#sabores_elegidos" + id).addClass("selected");
    }
};

function quitaSabor(id) {
    if (($("#cant_sabor_" + id).text()) == "2") {
        $("#cant_sabor_" + id).text("1");
    }
    else {
        $("#btn_" + id).removeClass("selected");
        // $("#eleccion_" + id).remove();
        $("#cant_sabor_" + id).text("");
    }
    sabores = sabores + 1
    $("#eleccion_" + id).remove();

    if (sel_sabores[0].id == id) {
        sel_sabores.splice(0, 1); //array.splice(index, howmany, item1, ....., itemX)
    };

    if (sel_sabores.length == 2) {

        if (sel_sabores[1].id == id) {
            sel_sabores.splice(1, 1); //array.splice(index, howmany, item1, ....., itemX)
        };
    };

};

function agrega_toppings(id_topping, nombre_topping) {
    if (verificaCantidad("topping")) {
        if (($("#cant_topping_" + id_topping).text()) != "1" && ($("#cant_topping_" + id_topping).text()) != "2") {
            $("#cant_topping_" + id_topping).text("1");
        }
        else {
            $("#cant_topping_" + id_topping).text((parseInt($("#cant_topping_" + id_topping).text()) + 1));
        }
        topp = new Object();
        topp.id = id_topping;
        topp.nombre = nombre_topping;
        sel_toppings.push(topp);
        
        $("#btn_" + id_topping).addClass("selected");

        var prd =
            `<strong id="eleccion_${id_topping}" class="saborelegido" onclick="quitaTopping('${id_topping}')">
            ${nombre_topping} 
            <spam class="glyphicon glyphicon-remove"</spam>  
        </strong>`;

        $('#toppings_elegidos').append(prd);

        $("#toppings_elegidos" + id_topping).addClass("selected");
    }
};

function quitaTopping(id) {
    if (($("#cant_topping_" + id).text()) == "2") {
        $("#cant_topping_" + id).text("1");
    }
    else {
        $("#btn_" + id).removeClass("selected");
        $("#cant_topping_" + id).text("\xa0");
    }
    toppings = toppings + 1

    $("#eleccion_" + id).remove();

    if (sel_toppings[0].id == id) {
        sel_toppings.splice(0, 1);
    };
    
    if (sel_toppings.length == 2) {
        if (sel_toppings[1].id == id) {
            sel_toppings.splice(1, 1);
        };
    };
};


$("#btn_agrega_prd").click(function () {    

    indice_prd = indice_prd+1;
    prd = new Array();
    prd.push(indice_prd, sel_tamano, sel_sabores, sel_toppings);
    prd_x_fac.push(prd); // se usa para el manejo del datatable (borar elementos)
    // detalle_x_fac.push(prd_x_fac);

    var rowNode = t   //t es la tabla de productos
    .row.add([indice_prd,[sel_tamano +", "+ sel_sabores[0].nombre +" y "+ sel_sabores[1].nombre +", "+ sel_toppings[0].nombre], "<spam class='glyphicon glyphicon-trash btn_borrar'></spam>"])
    .draw() //dibuja la tabla con el nuevo producto
    .node();
    
    // $('td:eq(1)', rowNode).attr({id: ("prec")});
    t.columns.adjust().draw();

    calcTotal();

    resetDash();


});

function borraPRD(row_prd) {
    indx=null; //Indice a borrar, se usa de esta forma xq al modificar el contenido del arreglo falla el each

    $(row_prd).addClass('borrar'); 

    $(prd_x_fac).each(function(i,item){
        if (t.row(row_prd).data()[0] == item[0]) {
            prd_x_fac.splice(i, 1);
        }
        //alert("I: "+i+" | "+"item: "+item+"var_INDEX: "+indx);
    });
    t.row('.borrar').remove().draw( false );
    // prd_x_fac.splice(indx, 1); //array.splice(index, howmany, item1, ....., itemX)

};


function resetDash(){
    $('#toppings_elegidos').empty();
    $('#sabores_elegidos').empty();
    // $("#" + id).removeClass("selected");
    $("#prdXbdg").find(".selected").removeClass("selected");
    $("#prdXbdg").find("p").text("\xa0");

    
    $("#toppings").find(".selected").removeClass("selected");
    $("#toppings").find("p").text("\xa0");


    sel_sabores=[];
    sel_toppings=[];
    sabores=2;
    toppings =2;
};


//Calcula los totales cada vez que un producto es modificado
function calcTotal() {
    var total = 0;
    if (prd_x_fac.length > 0) {

        $(prd_x_fac).each(function (i, item) {
            if (item[1] == "Grande") {
                total=total+2000;
            }else if (item[1] == "Mediano") {
                total=total+1000;    
            }
        });
        $("#total").html("¢"+total);
    }
    else {
        $('#open_modal_fac').attr("disabled", true);
        $("#subtotal")[0].textContent = "¢0";
        $("#iv_val")[0].textContent = "¢0";
        $("#total")[0].textContent = "¢0";

    }
};
































//VALIDAR SI SE NECESITA
// Carga el producto a la lista de la factura
// function LoadProducto() {
//     if ($("#p_searh").val() != ""){
//         producto.codigoRapido = $("#p_searh").val();  //Columna 0 de la fila seleccionda= ID.
//         producto.scancode = $("#p_searh").val();  //Columna 0 de la fila seleccionda= ID.
//         $.ajax({
//             type: "POST",
//             url: "class/Producto.php",
//             data: {
//                 action: "ReadByCode",
//                 obj: JSON.stringify(producto)
//             }
//         })
//         .done(function (e) {
//             CleanCtls();
//             ValidateProductFac(e);
//         })
//         .fail(function (e) {
//             showError(e);
//         });
//     }
// };

// valida que el producto nuevo a ingresar no este en la lista
// si esta en la lista lo suma a la cantidad
// si es nuevo lo agrega a la lista
function ValidateProductFac(e) {
    //compara si el articulo ya existe
    // carga lista con datos.
    if (e != "false") {
        producto = JSON.parse(e)[0];
        producto.UltPrd = producto.codigoRapido;
        var repetido = false;

        if (document.getElementById("productos").rows.length != 0 && producto != null) {
            $(document.getElementById("productos").rows).each(function (i, item) {
                if (item.childNodes[0].innerText == producto.codigoRapido) {
                    item.childNodes[3].childNodes["0"].attributes[3].value = producto.cantidad;
                    var CantAct = parseInt(item.childNodes[3].firstElementChild.value);
                    if (parseInt(producto.cantidad) > CantAct) {
                        item.childNodes[3].firstElementChild.value = parseFloat(item.childNodes[3].firstElementChild.value) + 1;
                        item.childNodes[04].firstChild.textContent = "¢" + parseFloat((item.childNodes[2].firstChild.textContent).replace("¢", "")) * parseFloat(item.childNodes[3].firstElementChild.value);
                        calcTotal();
                    }
                    else {
                        // alert("No hay mas de este producto");
                        alertSwal(producto.cantidad)
                        // $("#cant_"+ producto.UltPrd).val($("#cant_"+ producto.UltPrd)[0].attributes[3].value); 
                        $("#cant_" + producto.UltPrd).val(producto.cantidad);
                    }
                    repetido = true;
                    calcTotal();
                }
            });
        }
        if (repetido == false) {
            // showDataProducto(e);
            AgregaPrd();
        }
    }
    else {
        CleanCtls();
    }
};

//Agrega el producto a la factura
function AgregaPrd() {
    producto.UltPro = producto.codigoRapido;
    var rowNode = t   //t es la tabla de productos
        .row.add([producto.id, producto.codigoRapido, producto.descripcion, "¢" + producto.precio, "1", "¢" + producto.precio])
        .draw() //dibuja la tabla con el nuevo producto
        .node();
    $('td:eq(2)', rowNode).attr({ id: ("prec_" + producto.codigoRapido) });
    $('td:eq(4)', rowNode).attr({ id: ("impo_" + producto.codigoRapido) });
    $('td:eq(3) input', rowNode).attr({ id: ("cant_" + producto.codigoRapido), max: producto.cantidad, min: "0", step: "1", value: "1", onchage: "CalcImporte(" + producto.codigoRapido + ")" });
    $('td:eq(3) input', rowNode).change(function () {
        CalcImporte(producto.codigoRapido);
    });
    t.order([0, 'desc']).draw();
    t.columns.adjust().draw();
    calcTotal();
    $('#open_modal_fac').attr("disabled", false);
};

//Calcula el nuevo importe al cambiar la cantidad del prodcuto seleccionado de forma manual y no por producto repetido.
function CalcImporte(prd) {
    producto.UltPrd = prd;//validar
    pUnit = $(`#prec_${prd}`)[0].textContent.replace("¢", "");
    cant = parseInt($(`#cant_${prd}`)[0].value);

    if (cant <= parseInt($(`#cant_${prd}`)[0].attributes[3].value)) {
        $(`#impo_${prd}`)[0].textContent = "¢" + (parseFloat(pUnit) * parseFloat(cant)).toString();
    }
    else {
        // alert("Cantidad invalida, la cantidad maxima disponible es: "+ $(`#cant_${prd}`)[0].attributes[3].value)
        alertSwal(producto.cantidad)
        $("#cant_" + producto.UltPrd).val($(`#cant_${prd}`)[0].attributes[3].value);
    }

    $(`#impo_${prd}`)[0].textContent = "¢" + (parseFloat(pUnit) * parseInt($(`#cant_${prd}`)[0].value)).toString();
    // $(`#importe_${prd}`)[0].textContent
    $(`#cant_${prd}`).keyup(function (e) {
        if (e.which == 13) {
            if (cant == 0) {
                BorraRow(prd);
                calcTotal();
            }
            $(`#impo_${prd}`)[0].textContent = "¢" + (parseFloat(pUnit) * parseInt($(`#cant_${prd}`)[0].value)).toString();
            calcTotal();
            $("#p_searh").focus();
        }
    });
    if (cant == 0) {
        BorraRow(prd);
        calcTotal();
        $("#p_searh").focus();
    }
};



//Elimana el producto de la factura 
function BorraRow(prd) {
    $(`#prec_${prd}`)["0"].parentElement.attributes[1].value = ($(`#prec_${prd}`)["0"].parentElement.attributes[1].value) + " selected";
    t.row('.selected').remove().draw(false);
}

function facCard() {
    $("#formapago").empty();
    var DivCard =
        `<div class="row">
        <div class="col-md-4 col-md-offset-4 col-sm-offset-0 col-xs-6 col-xs-offset-0">
            <h3 class="text-left" >Ingrese Ref.:</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <input class="input-lg valPago" type="text" onkeyup="valPago(this.value)" placeholder="Ingrese Numero Referencia" required="" minlength="5" autofocus="">
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4 col-sm-offset-0 col-xs-6 col-xs-offset-0">
            <button type="button" onclick="CreateFact()" class="btn btn-primary procesarFac" disabled style="margin-top:10px;">Procesar</button>
        </div>
    </div>`;
    $("#formapago").append(DivCard);


    $("#btn-formapago").empty();
    var DivCash =
        `<button type="button" id="modalFormaPago" onclick="btnFormaPago()"class="btn btn-primary">Atras</button>`;
    $("#btn-formapago").append(DivCash);
};


function facCash() {
    $("#formapago").empty();

    var DivCash =
        `<div class="row">
        <div class="col-md-4 col-md-offset-4 col-sm-offset-0 col-xs-6 col-xs-offset-0">
            <h3 class="text-left" >Paga con:</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <input id="pagocash" class="input-lg valPago" onkeyup="valPago(this.value)" type="text" placeholder="Ingrese Monto en Efectivo"  required="" minlength="5" autofocus="">
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4 col-sm-offset-0 col-xs-6 col-xs-offset-0">
            <button type="button" onclick="CreateFact()" class="btn btn-primary procesarFac" disabled style="margin-top:10px;">Procesar</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4 col-sm-offset-0 col-xs-6 col-xs-offset-0">
            <h3 class="text-left" id="vuelto">Su vuelto:</h3>
        </div>
    </div>`;
    $("#formapago").append(DivCash);


    $("#btn-formapago").empty();
    var DivCash =
        `<button type="button" id="modalFormaPago" onclick="btnFormaPago()"class="btn btn-primary">Atras</button>`;
    $("#btn-formapago").append(DivCash);
};

function btnFormaPago() {
    $("#formapago").empty();
    var DivCash =
        `<div class="col-md-2"></div>
    <div class="col-md-3" onclick="facCard()">
        <img id="fac-ccard" src="images/credit-cards.png" class="modal-img-pago">
        <p class="text-center">Tarjeta</p>
    </div>
    <div class="col-md-2"></div>
    <div class="col-md-3" onclick="facCash()">
        <img id="fac-cash" src="images/cash.png" class="modal-img-pago">
        <p class="text-center">Efectivo</p>
    </div>`;
    $("#formapago").append(DivCash);

    $("#btn-formapago").empty();
    var DivCash =
        `<button type="button" id="modalPago" class="btn btn-primary" data-dismiss="modal">Atras</button>`;
    $("#btn-formapago").append(DivCash);
};

function valPago(val) {

    xPagar = parseFloat(($("#total")[0].textContent).replace("¢", ""));
    pago = parseFloat($('.valPago').val());


    if (isNaN($('.valPago').val())) {
        // alert("numero");
        val = val.replace(/[^0-9]/g, '');
        $(".valPago").val(val);

    } else {
        if (pago >= xPagar) {
            $(".procesarFac").prop('disabled', false);
            calcVuelto(pago, xPagar);
        }
        else {
            $(".procesarFac").prop('disabled', true);
        }
    }

};

function CreateFact() {
    $(t.columns().data()[0]).each(function (ic, c) {
        factura.producto[ic] = $(t.rows().data()[ic]);
    });

    var miAccion = this.id == null ? 'Create' : 'Update';

    $.ajax({
        type: "POST",
        url: "class/Factura.php",
        data: {
            action: miAccion,
            obj: JSON.stringify(factura)
        }
    })
        .done(alertFact()

        )
        .fail(function (e) {
            producto.showError(e);
        })
        .always(function () {
            setTimeout('$("#btnProducto").removeAttr("disabled")', 1000);
            producto = new Producto();
            producto.ClearCtls();
            producto.Read;
            $("#nombre").focus();
        });
}

//informa de cantidad de producto
function alertSwal(cant) {
    swal({
        type: 'info',
        title: 'Oops...',
        text: 'Cantidad Inexistente de Producto!',
        footer: '<h3>Cantidad maxima de producto disponble es: ' + cant + '</h3>',
        // showConfirmButton: false,
        timer: 3500
    });
    // alert('La cantidad maxima de producto disponble es: '+ cant);
}

//Informa que la factura fue agregada
function alertFact() {
    swal({
        type: 'success',
        text: 'Factura Lista!',
        timer: 2000
    });
    $(".procesarFac").prop('disabled', true);
    // calcVuelto();
    setTimeout(function () { location.reload(); }, 2000);
}

function calcVuelto(pago, xPagar) {
    // $("#vuelto").val(pago-xPagar);
    vuelto = ((pago - xPagar).toFixed(2)).toString();

    // $("#vuelto").val("EJEMPLO");
    $("#vuelto")["0"].textContent = "Su cambio: " + vuelto;



}

// Muestra errores en ventana
function showError(e) {
    //$(".modal").css({ display: "none" });  
    var data = JSON.parse(e.responseText);
    alert("ERROR");
    // swal({
    //     type: 'error',
    //     title: 'Oops...',
    //     text: 'Algo no está bien (' + data.code + '): ' + data.msg, 
    //     footer: '<a href>Contacte a Soporte Técnico</a>',
    //   })
};


function CleanCtls() {
    $("#p_searh").val('');
};




//BORRAR
// function facturar(metodo){
//     alert("EFECTIVO");
//     if (metodo == "cash"){
//         alert("EFECTIVO");
//     }
//     if (metodo=="creditcard") {
//         alert ("TARJETA");
//     }
// };

// Carga lista
// function LoadAll() {
//     id=null;
//     $.ajax({
//         type: "POST",
//         url: "../../class/Producto.php",
//         data: {
//             action: "LoadAll"
//         }
//     })
//     .done(function (e) {
//         CleanCtls();
//         showData(e);
//     })
//     .fail(function (e) {
//         showError(e);
//     });
// };

// Muestra información en ventana
// function showInfo() {
//     //$(".modal").css({ display: "none" });  

//     // swal({
//     //     position: 'top-end',
//     //     type: 'success',
//     //     title: 'Good!',
//     //     showConfirmButton: false,
//     //     timer: 1500
//     // });
// };



// function showData(e) {
//     // Limpia el div que contiene la tabla.
//     $('#tableBody-Producto').html("");
//     // carga lista con datos.
//     var data = JSON.parse(e);
//     // Recorre arreglo.
//     $.each(data, function (i, item) {
//         var row =
//             '<tr>' +
//                 '<td>' + item.id + '</td>' +
//                 '<td>' + item.nombre + '</td>' +
//                 '<td>' + item.scancode + '</td>' +
//                 '<td>' + item.cantidad + '</td>' +
//                 '<td>' + item.precio + '</td>' +
//                 '<td>' + item.codigoRapido + '</td>' +
//                 '<td><img id=btnmodingreso'+ item.id + ' src=img/file_mod.png></td>'+
//                 '<td><img id=btnborraingreso'+ item.id + ' src=img/file_delete.png></td>'+
//             '</tr>';
//         $('#tableBody-Producto').append(row);
//         // evento click del boton modificar-eliminar
//         $('#btnmodingreso' + item.id).click(UpdateEventHandler);
//         $('#btnborraingreso' + item.id).click(DeleteEventHandler);
//     })
// };

// function showDataCategoria(e) {
//     // carga lista con datos.
//     var data = JSON.parse(e);
//     // Recorre arreglo.
//     $.each(data, function (i, item) {
//         var opt =
//             '<option value="'+ item.id + '">'+ item.nombre + '</option>';
//         $('#categoria').append(opt);
//         // evento click del boton modificar-eliminar
//         //$('#option' + item.id).click(event-handler);
//     })
// };

// function UpdateEventHandler() {
//     producto.id = $(this).parents("tr").find("td").eq(0).text();  //Columna 0 de la fila seleccionda= ID.
//     $.ajax({
//         type: "POST",
//         url: "class/Producto.php",
//         data: {
//             action: 'Load',
//             producto: JSON.stringify(producto)
//         }
//     })
//     .done(function (e) {
//         ShowItemData(e);
//     })
//     .fail(function (e) {
//         showError(e);
//     });
// };

// function DeleteEventHandler() {
//     producto.id = $(this).parents("tr").find("td").eq(0).text(); //Columna 0 de la fila seleccionda= ID.
//     // Mensaje de borrado:
//     swal({
//         title: 'Eliminar?',
//         text: "Esta acción es irreversible!",
//         type: 'warning',
//         showCancelButton: true,
//         confirmButtonColor: '#3085d6',
//         cancelButtonColor: '#d33',
//         confirmButtonText: 'Si, eliminar!',
//         cancelButtonText: 'No, cancelar!',
//         confirmButtonClass: 'btn btn-success',
//         cancelButtonClass: 'btn btn-danger'
//     }).then(function () {
//         // eliminar registro.
//         Delete();
//     })
// };

// function Delete() {
//     $.ajax({
//         type: "POST",
//         url: "class/Producto.php",
//         data: { 
//             action: 'Delete',                
//             producto:  JSON.stringify(producto)
//         }            
//     })
//     .done(function( e ) {
//         var data = JSON.parse(e);   
//         if(data.status==1)
//         {
//             swal(
//                 'Mensaje!',
//                 'El registro se encuentra  en uso, no es posible eliminar.',
//                 'error'
//             );
//         }
//         else swal(
//             'Eliminado!',
//             'El registro se ha eliminado.',
//             'success'
//         );
//     })    
//     .fail(function (e) {
//         showError(e);
//     })
//     .always(LoadAll);
// };

// function ShowItemData(e) {
//     // Limpia el controles
//     CleanCtls();    
//     // carga objeto.
//     var data = JSON.parse(e)[0];
//     producto = new Producto(data.id, data.nombre, data.scancode, data.cantidad, data.precio, data.codigoRapido, data.idcategoria, data.fechaExpiracion);
//     // Asigna objeto a controles
//     $("#id").val(producto.id);
//     $("#nombre").val(producto.nombre);
//     $("#precio").val(producto.precio);
//     $("#cantidad").val(producto.cantidad);
//     $("#codigoRapido").val(producto.codigoRapido);
//     $("#categoria").val(producto.idcategoria);
//     $("#fechaExpiracion").val(producto.fechaExpiracion);
// };

// function Save(){   
//     // Ajax: insert / Update.
//     var miAccion= producto.id==null ? 'Insert' : 'Update';
//     producto.nombre = $("#nombre").val();
//     producto.cantidad = $("#cantidad").val();
//     producto.precio = $("#precio").val();
//     producto.codigoRapido = $("#codigoRapido").val();
//     producto.idcategoria= $("#categoria").val();
//     producto.fechaExpiracion= $("#fechaExpiracion").val();
//     //
//     $.ajax({
//         type: "POST",
//         url: "../../../class/Producto.php",
//         data: { 
//             action: miAccion,  
//             producto: JSON.stringify(producto)
//         }
//     })
//     .done(showInfo)
//     .fail(function (e) {
//         showError(e);
//     })
//     .always(function() {
//         setTimeout('$("#btnProducto").removeAttr("disabled")', 1500);
//         LoadAll();   
//     });
// }; 


//Agrega el producto a la lista... NO SE ESTA USANDO
// function showDataProducto(e) {
//     // carga lista con datos.
//     var data = JSON.parse(e);
//     // Recorre arreglo.
//     $.each(data, function (i, item) {
//         var opt =
//         `<tr class="even pointer">
//             <td class="a-center ">
//                 <div class="icheckbox_flat-green" style="position: relative;">
//                     <input type="checkbox" class="flat" name="table_records" style="position: absolute; opacity: 0;">
//                     <ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
//                 </div>
//             </td>
//             <td class="codigoRapido" id="id_${item.codigoRapido}"> ${item.codigoRapido} </td>
//             <td class="descripcion">${item.descripcion}</td>
//             <td class=" " id="precio_${item.codigoRapido}">¢${item.precio}</td>
//             <td class="">
//                <input class="cantidad form-control" type="number" min="1" max="999" step="1" value="1" id="cant_${item.codigoRapido}" onchange="importe(${item.codigoRapido})">
//             </td>
//                 <td id="importe_${item.codigoRapido}">¢${item.precio}</td>
//         </tr>`;
//         //<option value="'+ item.id + '">'+ item.nombre + '</option>';
//         $('#productos').append(opt);
//         // evento click del boton modificar-eliminar
//         //$('#option' + item.id).click(event-handler);
//     })
//     calcTotal();
// };