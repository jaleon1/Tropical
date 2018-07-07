var selector = "#txt_pago";

function sendVal(a){
    // a=parseInt(a);
    switch (a) {
        case ((a>=0 && a<=9)?a:-1):
           addNumber(a);
            break;
        case ("enter"):
            enter();
            break;
        case ("left"):
            left();
            break;
        default:
            return false
    };    
};

function sendRef(a){
    // a=parseInt(a);
    switch (a) {
        case ((a>=0 && a<=9)?a:-1):
           addRef(a);
            break;
        case ("enter"):
            enter();
            break;
        case ("left"):
            left();
            break;
        default:
            return false
    };    
};

function addNumber(a){
        //21 numeros maximo
        $('.valPago').val($('.valPago').val()+a)   
        validarMonto (); 
};

function addRef(a){
    //21 numeros maximo
    $('.valPago').val($('.valPago').val()+a)   
    validarRef (); 
};

function left(){
    precio=$('.valPago').val();
    $('.valPago').val(precio.substring(0,precio.length-1)); 
    validarMonto (); 
};


function validarMonto (){
    totalXPagar = parseFloat($('#total')["0"].textContent.replace("¢", ""));
    // parseFloat($('#total').val());
    if (( $('.valPago').val() ) >= totalXPagar) {
        var element = document.getElementsByClassName("Nosend")[0];
        element.classList.add("green", "letter", "send");        
        // element.classList.add("letter");
        element.classList.remove("Nosend");
    }
    else {
        var element2 = document.getElementsByClassName("send")[0];
        element2.classList.add("Nosend");
        element2.classList.remove("letter", "send", "green");
    }
};

function validarRef (){
    if (( $('.valPago').length() ) >= 5) {
        var element = document.getElementsByClassName("Nosend")[0];
        element.classList.add("green", "letter", "send");        
        // element.classList.add("letter");
        element.classList.remove("Nosend");
    }
    else {
        var element2 = document.getElementsByClassName("send")[0];
        element2.classList.add("Nosend");
        element2.classList.remove("letter", "send", "green");
    }
};
function enter(){

    var prdVenta = new Object();

    $(t.columns().data()[0]).each(function (ic, c) {
        factura.producto[ic] = $(t.rows().data()[ic]);
        prdVenta =1;
    });
    //
    // $('#btnDistribucion').attr("disabled", "disabled");
    // var miAccion = distr.id == null ? 'Create' : 'Update';        
    // distr.orden = $("#orden").val();
    // distr.idBodega = bodega.id;
    // distr.porcentajeDescuento = $("#desc_100").val();
    // distr.porcentajeIva=$("#iv_100").val();
    // //
    // distr.lista = [];

    // $('#productos tr').each(function(i, item) {
    //     var objlista = new Object();
    //     objlista.idProducto= $('#dsitems').dataTable().fnGetData(item)[0]; // id del item.
    //     objlista.cantidad= $(this).find('td:eq(3) input').val();
    //     objlista.valor= $(this).find('td:eq(4) input').val(); // valor: precio de venta para distrcion bodega externa. 
    //     distr.lista.push(objlista);
    // });

    // $.ajax({
    //     type: "POST",
    //     url: "class/Distribucion.php",
    //     data: {
    //         action: miAccion,
    //         obj: JSON.stringify(this)
    //     }
    // })
    //     .done(function(e){
    //         // muestra el numero de orden: IMPRIMIR.
    //         var data = JSON.parse(e)[0];
    //         swal({
    //             type: 'success',
    //             title: 'Número de Orden:' + data.orden,
    //             text: 'Número de orden de Distribución:',
    //             showConfirmButton: true
    //         });
    //     })
    //     .fail(function (e) {
    //         distr.showError(e);
    //     })
    //     .always(function () {
    //         setTimeout('$("#btnDistribucion").removeAttr("disabled")', 1000);
    //         distr = new Distribucion();
    //         distr.CleanCtls();
    //         $("#p_searh").focus();
    //     });
};

