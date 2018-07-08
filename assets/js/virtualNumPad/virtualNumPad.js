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

    var facUUID;
    var miAccion = 'Create';    
    var prdVenta = new Object();

    $.ajax({
        type: "POST",
        url: "class/ProductoXFactura.php",
        data: {
            action: "GenUUID",
        }
    })
    .done(function(e){
        // muestra el numero de orden: IMPRIMIR.
        facUUID = JSON.parse(e);
    })

   

    $(t.rows().data()).each(function (i, item) {
        prdVenta.idTamano =  item[0];
        prdVenta.idSabor1 = item[2];
        prdVenta.idSabor2 = item[4];
        prdVenta.idTopping1 = item[6];
        prdVenta.numLinea = i;
        prdVenta.cant = 1;
        prdVenta.detalle = `${item[1]}, ${item[3]}, ${item[5]}, ${item[7]}`;

        

        $.ajax({
            type: "POST",
            url: "class/ProductoXFactura.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(prdVenta)
            }
        })
        .done(function(e){
            // muestra el numero de orden: IMPRIMIR.
            var data = JSON.parse(e)[0];
            swal({
                type: 'success',
                title: 'Número de Orden:' + data.orden,
                text: 'Número de orden de Distribución:',
                showConfirmButton: true
            });
        })
        .fail(function (e) {
            distr.showError(e);
        })
        .always(function () {
            location.reload();
        });
    });
};

