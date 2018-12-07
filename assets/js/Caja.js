class MovimientosCaja {
    // Constructor
    constructor(estado, tb_movimientosCaja, montoAperturaDefault, montoApertura, montoCierre, cierreEfectivo, cierreTarjeta, fechaInicial, fechaFinal) {
        this.estado = estado || "";
        this.tb_movimientosCaja = tb_movimientosCaja || null;
        this.montoAperturaDefault = montoAperturaDefault || 0;
        this.montoApertura = montoApertura || 0;
        this.montoCierre = montoCierre || 0;
        this.cierreEfectivo = cierreEfectivo || 0;
        this.cierreTarjeta = cierreTarjeta || 0;
        this.fechaInicial = fechaInicial || "";
        this.fechaFinal = fechaFinal || "";
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

    CargaMovimientosCajaXUsuario() {
        $.ajax({
            type: "POST",
            url: "class/CajaXBodega.php",
            data: {
                action: "ReadByUser"
            }
        })
            .done(function (e) {
                movimientosCaja.drawMovimientosCaja(e)
            });
    };

    CargaMoviminetosCajasRango() {
        var referenciaCircular = movimientosCaja.tb_movimientosCaja;
        movimientosCaja.tb_movimientosCaja = [];
        $.ajax({
            type: "POST",
            url: "class/CajaXBodega.php",
            data: {
                action: "ReadAllbyRange",
                obj: JSON.stringify(movimientosCaja)
            }
        })
            .done(function (e) {
                movimientosCaja.tb_movimientosCaja = referenciaCircular;        
                movimientosCaja.drawMovimientosCaja(e); 
            });
    };

    CargaMoviminetosCajasUsuarioRango() {
        var referenciaCircular = movimientosCaja.tb_movimientosCaja;
        movimientosCaja.tb_movimientosCaja = [];
        $.ajax({
            type: "POST",
            url: "class/CajaXBodega.php",
            data: {
                action: "ReadAllbyRangeUser",
                obj: JSON.stringify(movimientosCaja)
            }
        })
            .done(function (e) {
                movimientosCaja.tb_movimientosCaja = referenciaCircular;        
                movimientosCaja.drawMovimientosCaja(e); 
            });
    };

    drawMovimientosCaja(e) {
        var movimientos = JSON.parse(e);
        // var total=0;
        // var pageTotal=0;
        this.tb_movimientosCaja = $('#tb_movimientosCaja').DataTable({
            data: movimientos,
            footerCallback: function ( row, data, start, end, display ) {
                var api = this.api();
                // Remueve el formato de la columna
                var intVal = function ( i ) {
                    return typeof i === 'string' ?
                        i.replace(/[\¢,]/g, '')*1 :
                        typeof i === 'number' ?
                        i : 0;
                };
                // Total de todas las paginas filtradas
                var totalApertura = display.map(el => data[el][6]).reduce((a, b) => intVal(a) + intVal(b), 0 );
                var totalCierre = display.map(el => data[el][7]).reduce((a, b) => intVal(a) + intVal(b), 0 );
                var totalEfectivo = display.map(el => data[el][8]).reduce((a, b) => intVal(a) + intVal(b), 0 );
                var totalTarjeta = display.map(el => data[el][9]).reduce((a, b) => intVal(a) + intVal(b), 0 );
                var totalVenta = totalEfectivo+totalTarjeta;
                var totalNeto = display.map(el => data[el][12]).reduce((a, b) => intVal(a) + intVal(b), 0 );

                // Actualiza el footer
                $( api.column( 2 ).footer() ).html("TOTALES");
                $( api.column( 6 ).footer() ).html('¢' + parseFloat(Number(totalApertura)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                $( api.column( 7 ).footer() ).html('¢' + parseFloat(Number(totalCierre)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                $( api.column( 8 ).footer() ).html('¢' + parseFloat(Number(totalEfectivo)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                $( api.column( 9 ).footer() ).html('¢' + parseFloat(Number(totalTarjeta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                $( api.column( 10 ).footer() ).html('¢' + parseFloat(Number(totalVenta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                $( api.column( 13 ).footer() ).html('¢' + parseFloat(Number(totalNeto)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            },
            responsive: true,
            destroy: true,
            order: [11, "desc"],
            dom: 'Bfrtip',
            bLengthChange : false,
            buttons: [
                {
                    extend: 'excelHtml5',
                    messageTop:'Movimientos de Cajas',
                    footer: true,
                    exportOptions: {
                        columns: [2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
                    }
                },
                {
                    extend: 'pdfHtml5',
                    messageTop:'Movimientos de Cajas',
                    orientation : 'landscape',
                    footer: true,
                    exportOptions: {
                        columns: [2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
                    }
                }
            ],
            ///////////////// 
            language: {
                "infoEmpty": "Sin Movimientos de Cierres de Caja",
                "emptyTable": "Sin Movimientos  de Cierres de Caja",
                "search": "Buscar",
                "zeroRecords": "No hay resultados",
                "lengthMenu": "Mostar _MENU_ registros",
                "paginate": {
                    "first": "Primera",
                    "last": "Ultima",
                    "next": "Siguiente",
                    "previous": "Anterior"
                }
            },
            columnDefs: [{ className: "text-right", "targets": [6] }, 
                         { className: "text-right", "targets": [7] }, 
                         { className: "text-right", "targets": [8] }, 
                         { className: "text-right", "targets": [9] }, 
                         { className: "text-right", "targets": [12] }],
            columns: [
                {
                    title: "ID MOVIMIENTOS CAJA",
                    data: "id",
                    visible: false
                },
                {
                    title: "IDBODEGA",
                    data: "idBodega",
                    "visible": false,
                    "searchable": false
                },
                {
                    title: "BODEGA",
                    data: "nombreBodega"
                },
                {
                    title: "IDCAJERO",
                    data: "idUsuarioCajero",
                    "visible": false,
                    "searchable": false
                },
                {
                    title: "CAJERO",
                    data: "cajero"
                },
                {
                    title: "ESTADO",
                    data: "estado"
                },
                {
                    title: "MONTO APERTURA",
                    data: "montoApertura",
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "MONTO CIERRE",
                    data: "montoCierre",
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "TOTAL VENTAS EFECTIVO",
                    data: "totalVentasEfectivo",
                    footer: true,
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "TOTAL VENTAS TARJETA",
                    data: "totalVentasTarjeta",
                    footer: true,
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "TOTAL VENTAS",
                    footer: true,
                    render: function (data, type, row, meta) {
                        var efectivo = 0;
                        var tarjeta = 0;
                        if(row['totalVentasEfectivo']==null)
                            efectivo = 0;
                        else
                            efectivo = parseFloat(row['totalVentasEfectivo']);
                        if(row['totalVentasTarjeta']==null)
                            tarjeta=0;
                        else
                            tarjeta = parseFloat(row['totalVentasTarjeta']);
                        return '¢' + parseFloat(Number(efectivo + tarjeta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "FECHA APERTURA",
                    data: "fechaApertura"
                },
                {
                    title: "FECHA CIERRE",
                    data: "fechaCierre"
                },
                {
                    title: "TOTAL NETO",
                    data: "totalNeto",
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                }
            ]
        });

    };

    getStatusCashRegister() {
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
                movimientosCaja.errorAbrirCaja("Usuario no valido", "No se puede Validar el estado de la caja!");
            });
    };

    validarEstadoCaja(e) {
        var estado = JSON.parse(e);
        switch (estado) {
            case "cajaCerrada": //false quiere decir que no hay cajas abiertas para el usuario logeado
                movimientosCaja.openModalAbrirCaja();
                break;
            case "aperturaCreada":
                swal({
                    text: 'Validación lista.',
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

    openModalAbrirCaja() {
        //Trae el monto de apertura de caja
        $.ajax({
            type: "POST",
            url: "class/CajaXBodega.php",
            data: {
                action: "GetMontoDefaultApertura"
            }
        })
            .done(function (e) {
                movimientosCaja.montoAperturaDefault = parseFloat(JSON.parse(e).montoDefaultApertura);
                $(".txtMontoDefaultApertura").text((movimientosCaja.montoAperturaDefault).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
                $('.valida-caja-modal-lg').modal({ backdrop: 'static', keyboard: false });
                $('.valida-caja-modal-lg').modal('show');

            })
            .fail(function (e) {
                movimientosCaja.errorAbrirCaja("Error", "No se pudo cargar el monto de apertura establecido!");
            });

        $("#abrirCaja").click(function () {
            movimientosCaja.montoApertura = movimientosCaja.montoAperturaDefault;
            $.ajax({
                type: "POST",
                url: "class/CajaXBodega.php",
                data: {
                    action: "Create",
                    obj: JSON.stringify(movimientosCaja)
                }
            })
                .done(function (e) {
                    movimientosCaja.validarEstadoCaja(e);
                })
                .fail(function (e) {
                    movimientosCaja.errorAbrirCaja("Usuario no valido", "Solo un administrador puede abrir Caja!");
                });

        });
    };

    errorAbrirCaja(titulo, texto) {
        swal({
            type: 'error',
            title: titulo,
            text: texto,
            showConfirmButton: false,
            timer: 3000
        })
    };

    loadModalCierreCaja(e) {

        var data = JSON.parse(e);

        if (Number(data.montoAperturaDefault[0].montoDefaultApertura) == 0)
            data.montoAperturaDefault[0].montoDefaultApertura = 0;

        if (Number(data.totalVentasEfectivo[0].efectivo) == 0)
            data.totalVentasEfectivo[0].efectivo = 0;

        if (Number(data.totalVentasTarjeta[0].tarjeta) == 0)
            data.totalVentasTarjeta[0].tarjeta = 0;

        $(".txtMontoDefaultApertura").text('¢' + parseFloat(data.montoAperturaDefault[0].montoDefaultApertura).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
        $('#cierreEfectivo').text('¢' + parseFloat(data.totalVentasEfectivo[0].efectivo).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
        $('#cierreTarjeta').text('¢' + parseFloat(data.totalVentasTarjeta[0].tarjeta).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));


        $('#lblTotalVentas').text('¢' + (parseFloat(data.totalVentasEfectivo[0].efectivo) + parseFloat(data.totalVentasTarjeta[0].tarjeta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
        var totalCierre = (parseFloat(data.montoAperturaDefault[0].montoDefaultApertura) + parseFloat(data.totalVentasEfectivo[0].efectivo) + parseFloat(data.totalVentasTarjeta[0].tarjeta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        $('#cierreCajaTotal').text('¢' + totalCierre.toString());


        $('.cierra-caja-modal-lg').modal('show');

        $("#btn_ModalCierreCaja").click(function () {
            movimientosCaja.montoCierre = data.montoAperturaDefault[0].montoDefaultApertura;
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
                    movimientosCaja.errorAbrirCaja("Operación invalida", "Imposible cerrar caja!");
                });
        });
    };

    loadModalCajaCierreDiario(e) {

        var data = JSON.parse(e);

        if (Number(data.montoAperturaDefault[0].montoDefaultApertura) == 0)
            data.montoAperturaDefault[0].montoDefaultApertura = 0;

        if (Number(data.totalVentasEfectivo[0].efectivo) == 0)
            data.totalVentasEfectivo[0].efectivo = 0;

        if (Number(data.totalVentasTarjeta[0].tarjeta) == 0)
            data.totalVentasTarjeta[0].tarjeta = 0;

        this.montoApertura = '¢' + parseFloat(data.montoAperturaDefault[0].montoDefaultApertura).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".");

        $(".txtMontoDefaultApertura").text('¢' + parseFloat(data.montoAperturaDefault[0].montoDefaultApertura).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
        $('#cierreEfectivo').text('¢' + parseFloat(data.totalVentasEfectivo[0].efectivo).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
        $('#cierreTarjeta').text('¢' + parseFloat(data.totalVentasTarjeta[0].tarjeta).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));


        $('#lblTotalVentas').text('¢' + (parseFloat(data.totalVentasEfectivo[0].efectivo) + parseFloat(data.totalVentasTarjeta[0].tarjeta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
        var totalCierre = (parseFloat(data.montoAperturaDefault[0].montoDefaultApertura) + parseFloat(data.totalVentasEfectivo[0].efectivo) + parseFloat(data.totalVentasTarjeta[0].tarjeta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        $('#cierreCajaTotal').text('¢' + totalCierre.toString());


        $('.cierra-caja-modal-lg').modal('show');

        $("#btn_ModalCierreCajaReporte").click(function(){
            var nombre = $('#call_name').text();
            movimientosCaja.montoCierre = data.montoAperturaDefault[0].montoDefaultApertura;           

            $.ajax({
                type: "POST",
                url: "class/CajaXBodega.php",
                data: {
                    action: "cerrarCaja",
                    obj: JSON.stringify(movimientosCaja)
                }
            })
                .done(function (e) {
                    movimientosCaja.ticketPrint();
                    // window.location.href = 'Dashboard.html';
                })
                .fail(function (e) {
                    movimientosCaja.errorAbrirCaja("Operación invalida", "Imposible cerrar caja!");
                });
        });
    };

    ReadbyID() {
        // alert("En construcción");
    };

    ticketPrint(){
        // var data = JSON.parse(e);
        localStorage.setItem("lsUsuario",$("#call_name").text());
        localStorage.setItem("lsBodega", $('.call_Bodega').html());
        localStorage.setItem("lsFecha",moment().format("YYYY-MM-DD HH:mm"));
        localStorage.setItem("lsApertura",this.montoApertura);
        localStorage.setItem("lsEfectivo",$('#cierreEfectivo').text());
        localStorage.setItem("lsTarjeta",$('#cierreTarjeta').text());
        localStorage.setItem("lsTotalVentas",$('#lblTotalVentas').text());
        localStorage.setItem("lsTotalNeto",$('#cierreCajaTotal').text());
        location.href ="/TicketCierreCaja.html";
        // location.href ="/Tropical/TicketCierreCaja.html";
    }

    ticketPrintRePrint(lsRowCierre){
        var row = JSON.parse(lsRowCierre);
        var apertura = row.montoApertura;
        var efectivo = row.totalVentasEfectivo;
        if(efectivo==null)efectivo=0;
        var tarjeta = row.totalVentasTarjeta;
        if(tarjeta==null)tarjeta=0;
        var totalventas = parseFloat(efectivo) + parseFloat(tarjeta);
        var totalneto = parseFloat(efectivo) + parseFloat(tarjeta) + parseFloat(apertura);
        localStorage.setItem("lsUsuario",row.cajero);
        localStorage.setItem("lsBodega", bodega.nombre);
        localStorage.setItem("lsFecha",row.fechaApertura);
        localStorage.setItem("lsApertura",'¢' + parseFloat(Number(apertura)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        localStorage.setItem("lsEfectivo",'¢' + parseFloat(Number(efectivo)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        localStorage.setItem("lsTarjeta",'¢' + parseFloat(Number(tarjeta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        localStorage.setItem("lsTotalVentas",'¢' + parseFloat(Number(totalventas)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        localStorage.setItem("lsTotalNeto",'¢' + parseFloat(Number(totalneto)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        location.href ="/TicketCierreCaja.html";
        // location.href ="/Tropical/TicketCierreCaja.html";
    }
}
//Class Instance
let movimientosCaja = new MovimientosCaja();




$("#menu_CerrarCaja").click(function () {

    $('.btn_ModalCierreCaja').attr('id', "btn_ModalCierreCaja");
    $('.btn_ModalCierreCaja').text("Cerrar Caja");


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

//Aplica para cerrar caja y generar el reporte
$("#menu_CerrarCajaReporte").click(function () {

    $('.btn_ModalCierreCaja').attr('id', "btn_ModalCierreCajaReporte");
    $('.btn_ModalCierreCaja').text("Cerrar Caja y General Reporte");


    $.ajax({
        type: "POST",
        url: "class/CajaXBodega.php",
        data: {
            action: "ValidarCajaCierreDiario"
        }
    })
        .done(function (e) {
            movimientosCaja.loadModalCajaCierreDiario(e);
        })
});


$('#tb_movimientosCaja tbody').on('click', 'tr', function () {
    movimientosCaja.ReadbyID(movimientosCaja.tb_movimientosCaja.row(this).data());
});

$("#btnMontoCajas").click(function () {
    movimientosCaja.montoAperturaDefault = $("#inpMontoAperturaDefault").val();
    // No se puede enviar el objeto tabla xq provoca una recursividad 
    // Entonces la tabla se guarda en z y luego se recupera cuando finaliza el ajax
    var z = movimientosCaja.tb_movimientosCaja;
    movimientosCaja.tb_movimientosCaja = 0;
    $.ajax({
        type: "POST",
        url: "class/CajaXBodega.php",
        data: {
            action: "UpdateMontoApertura",
            obj: JSON.stringify(movimientosCaja)
        }
    })
        .done(function (e) {
            movimientosCaja.tb_movimientosCaja = z;
            swal({
                text: 'Monto establecido correctamente.',
                title: 'Monto Actualizado!',
                type: 'success',
                showConfirmButton: false,
                timer: 1500
            });
        })
});










// (async function getFormValues () {
            //     const {value: formValues} = await swal({
            //       title: 'Usuario y Contraseña del Administrador:',
            //       html:
            //         '<input id="swal-input1" placeholder="Usuario" class="swal2-input">' +
            //         '<input id="swal-input2" placeholder="Contraseña" class="swal2-input">',
            //       focusConfirm: false,
            //       preConfirm: () => {
            //         return [
            //           document.getElementById('swal-input1').value,
            //           document.getElementById('swal-input2').value
            //         ]
            //       }
            //     })

            //     if (formValues) {
            //         var credenciales = JSON.stringify(formValues);            
                //     $.ajax({
                //         type: "POST",
                //         url: "class/CajaXBodega.php",
                //         data: {
                //             action: "Create"
                //         }
                //     })
                //     .done(function (e) {
                //         movimientosCaja.validarEstadoCaja(e);
                //     })
                //     .fail(function (e) {
                //         movimientosCaja.errorAbrirCaja("Usuario no valido", "Solo un administrador puede abrir Caja!" );
                //     });
                // }

                // })()