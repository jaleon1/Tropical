class MovimientosCaja {
    // Constructor
    constructor(estado, tb_movimientosCaja, montoApertura, montoCierre) {
        this.estado = estado || "";
        this.tb_movimientosCaja = tb_movimientosCaja || null;
        this.montoApertura = montoApertura || 0;
        this.montoCierre = montoCierre || 0;
    };

    CargaMovimientosCaja() {
        $.ajax({
            type: "POST",
            url: "class/CajaXBodega.php",
            data: {
                action: "ReadAll"
            }
        })
            .done(function (e) {
                movimientosCaja.drawMovimientosCaja(e)
            });
    };

    drawMovimientosCaja(e) {
        var movimientos = JSON.parse(e);

        this.tb_movimientosCaja = $('#tb_movimientosCaja').DataTable({
            data: movimientos,                               
            "language": {
                "infoEmpty":  "Sin Movimientos Ingresados",
                "emptyTable": "Sin Movimientos Ingresados",
                "search":     "Buscar",
                "zeroRecords": "No hay resultados",
                "lengthMenu":  "Mostar _MENU_ registros",
                "paginate": {
                    "first":   "Primera",
                    "last":    "Ultima",
                    "next":    "Siguiente",
                    "previous":"Anterior"
                }
            },
            "order": [[1, "desc"]],
            columns: [
                {
                    title: "ID Movimientos Caja",
                    data: "id",
                    visible: false
                },
                {
                    title: "IDBodega",
                    data: "idBodega",
                    "visible": false,
                    "searchable": false
                },
                {
                    title: "Bodega",
                    data: "nombreBodega"
                },
                {
                    title: "IDCajero",
                    data: "idUsuarioCajero",
                    "visible": false,
                    "searchable": false
                },
                {
                    title: "Cajero",
                    data: "cajero"
                },
                {
                    title: "Estado",
                    data: "estado"
                },
                {
                    title: "Monto Apertura",
                    data: "montoApertura",
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                },
                {
                    title: "Monto Cierre",
                    data: "montoCierre",
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                },
                {
                    title: "Total Ventas Efectivo",
                    data: "totalVentasEfectivo",
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                },
                {
                    title: "Total Ventas Tarjeta",
                    data: "totalVentasTarjeta",
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                },
                {
                    title: "Fecha Apertura",
                    data: "fechaApertura"
                },
                {
                    title: "Fecha Cierre",
                    data: "fechaCierre"
                },
            ]
        });
    };

    getStatusCashRegister(){
        $.ajax({
            type: "POST",
            url: "class/CajaXBodega.php",
            data: {
                action: "ValidarEstado"
            }
        })
        .done(function (e) {
            movimientosCaja.validarEstadoCaja(e);
        })
        .fail(function (e) {
            movimientosCaja.errorAbrirCaja("Usuario no valido", "No se puede obtener el estado de la caja!" );
        });
    };

    validarEstadoCaja(e){  
        var estado = JSON.parse(e);  
        switch(estado) {
            case "cajaCerrada": //false quiere decir que no hay cajas abiertas para el usuario logeado
                movimientosCaja.openModalAbrirCaja();
                break;
            case "aperturaCreada":
                swal({
                    text:'Validación lista.',
                    title: 'Caja habilitada!',
                    type: 'success',
                    showConfirmButton: false,
                    timer: 1500
                });
                $("#main_containerFacturaCli").removeAttr("style");
                $('.valida-caja-modal-lg').modal('hide');
                break;
            case "cajaAbierta":
                $("#main_containerFacturaCli").removeAttr("style");
                $('.valida-caja-modal-lg').modal('hide');
                break;
            default:
                movimientosCaja.errorAbrirCaja("Imposible abrir caja", "Los datos no son correctos");
        }
    };

    openModalAbrirCaja(){
    
        $('.valida-caja-modal-lg').modal('show');
    
    
        $("#abrirCaja").click(function(){
            (async function getFormValues () {
                const {value: formValues} = await swal({
                  title: 'Usuario y Contraseña del Administrador:',
                  html:
                    '<input id="swal-input1" placeholder="Usuario" class="swal2-input">' +
                    '<input id="swal-input2" placeholder="Contraseña" class="swal2-input">',
                  focusConfirm: false,
                  preConfirm: () => {
                    return [
                      document.getElementById('swal-input1').value,
                      document.getElementById('swal-input2').value
                    ]
                  }
                })
                
                if (formValues) {
                    var credenciales = JSON.stringify(formValues);            
                    $.ajax({
                        type: "POST",
                        url: "class/CajaXBodega.php",
                        data: {
                            action: "Create"
                        }
                    })
                    .done(function (e) {
                        movimientosCaja.validarEstadoCaja(e);
                    })
                    .fail(function (e) {
                        movimientosCaja.errorAbrirCaja("Usuario no valido", "Solo un administrador puede abrir Caja!" );
                    });
                }
                
                })()
        });
    };

    errorAbrirCaja(titulo, texto){
        swal({
            type: 'error',
            title: titulo,
            text: texto,
            showConfirmButton: false,
            timer: 3000
          })
    };

    loadModalCierreCaja(e){
        var data = JSON.parse(e);  
        
        $('#cierreEfectivo').text('¢'+ parseFloat(data.totalVentasEfectivo[0].efectivo).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
        $('#cierreTarjeta').text('¢'+ parseFloat(data.totalVentasTarjeta[0].tarjeta).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
        $('.cierra-caja-modal-lg').modal(
            {
                backdrop: 'static',
                keyboard: true, 
                show: true
        }
        );


        ////////////////////////////////
        $("#cierraCaja").click(function(){
            (async function getFormValues () {
                const {value: formValues} = await swal({
                  title: 'Usuario y Contraseña del Administrador:',
                  html:
                    '<input id="swal-input1" placeholder="Usuario" class="swal2-input">' +
                    '<input id="swal-input2" placeholder="Contraseña" class="swal2-input">',
                  focusConfirm: false,
                  preConfirm: () => {
                    return [
                      document.getElementById('swal-input1').value,
                      document.getElementById('swal-input2').value
                    ]
                  }
                })
                
                if (formValues) {
                    var credenciales = JSON.stringify(formValues); 
                    movimientosCaja.montoCierre = $("#saldoCaja").val();           
                    $.ajax({
                        type: "POST",
                        url: "class/CajaXBodega.php",
                        data: {
                            action: "cerrarCaja",
                            obj: JSON.stringify(movimientosCaja)
                        }
                    })
                    .done(function (e) {
                        window.location.href = 'Dashboard.html';
                    })
                    .fail(function (e) {
                        movimientosCaja.errorAbrirCaja("Usuario no valido", "Solo un administrador puede cerrar caja!" );
                    });
                }
                
                })()
        });
    };
}
//Class Instance
let movimientosCaja = new MovimientosCaja();

$(document).ready(function () {
    movimientosCaja.CargaMovimientosCaja();
});

// cierra-caja-modal-lg

$("#cerrarCaja").click(function () {
    $.ajax({
        type: "POST",
        url: "class/CajaXBodega.php",
        data: {
            action: "ValidarCierreCaja"
        }
    })
    .done(function (e) {
        movimientosCaja.loadModalCierreCaja(e);
    })
});

$('#tb_movimientosCaja tbody').on('click', 'tr', function () {
    movimientosCaja.ReadbyID(movimientosCaja.tb_movimientosCaja.row(this).data());
});




