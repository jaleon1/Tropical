class MovimientosCaja {
    // Constructor
    constructor(estado, tb_movimientosCaja, montoAperturaDefault, montoApertura, montoCierre, cierreEfectivo, cierreTarjeta) {
        this.estado = estado || "";
        this.tb_movimientosCaja = tb_movimientosCaja || null;
        this.montoAperturaDefault = montoAperturaDefault || 0;
        this.montoApertura = montoApertura || 0;
        this.montoCierre = montoCierre || 0;
        this.cierreEfectivo = cierreEfectivo || 0;
        this.cierreTarjeta = cierreTarjeta || 0;
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



    drawMovimientosCaja(e) {
        jQuery.fn.dataTable.Api.register('sum()', function () {
            return this.flatten().reduce(function (a, b) {
                if (typeof a === 'string') {
                    a = a.replace(/[^\d.-]/g, '') * 1;
                }
                if (typeof b === 'string') {
                    b = b.replace(/[^\d.-]/g, '') * 1;
                }

                return a + b;
            }, 0);
        });

        var movimientos = JSON.parse(e);

        this.tb_movimientosCaja = $('#tb_movimientosCaja').DataTable({
            drawCallback: function () {
                var api = this.api();
                $(api.table().footer()).html(
                    api.column(8, { page: 'current' }).data().sum()
                );
            },
            dom: 'Blfrtip',
            buttons: [
                {
                    extend: 'pdf',
                    footer: false,
                    exportOptions: {
                        columns: [2, 4, 5, 6, 7, 8, 9, 10, 11]
                    }
                },
                {
                    extend: 'print',
                    footer: false,
                    exportOptions: {
                        columns: [2, 4, 5, 6, 7, 8, 9, 10, 11]
                    }

                },
                {
                    extend: 'excel',
                    footer: false,
                    exportOptions: {
                        columns: [2, 4, 5, 6, 7, 8, 9, 10, 11]
                    }
                }
            ],
            ///////////////// 
            data: movimientos,
            "language": {
                "infoEmpty": "Sin Movimientos Ingresados",
                "emptyTable": "Sin Movimientos Ingresados",
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
            footer: true,
            "order": [[11, "desc"]],
            columnDefs: [{className: "text-right", "targets": [9]},{className: "text-right", "targets": [8]},{className: "text-right", "targets": [7]}],
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
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                },
                {
                    title: "Monto Cierre",
                    data: "montoCierre",
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                },
                {
                    title: "Total Ventas Efectivo",
                    data: "totalVentasEfectivo",
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                },
                {
                    title: "Total Ventas Tarjeta",
                    data: "totalVentasTarjeta",
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
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


        this.tb_movimientosCaja.column(8).data().sum();


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

        $(".txtMontoDefaultApertura").text('¢' + parseFloat(data.montoAperturaDefault[0].montoDefaultApertura).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
        $('#cierreEfectivo').text('¢' + parseFloat(data.totalVentasEfectivo[0].efectivo).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
        $('#cierreTarjeta').text('¢' + parseFloat(data.totalVentasTarjeta[0].tarjeta).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));


        $('#lblTotalVentas').text('¢' + (parseFloat(data.totalVentasEfectivo[0].efectivo) + parseFloat(data.totalVentasTarjeta[0].tarjeta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, "."));
        var totalCierre = (parseFloat(data.montoAperturaDefault[0].montoDefaultApertura) + parseFloat(data.totalVentasEfectivo[0].efectivo) + parseFloat(data.totalVentasTarjeta[0].tarjeta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        $('#cierreCajaTotal').text('¢' + totalCierre.toString());


        $('.cierra-caja-modal-lg').modal('show');

        $("#btn_ModalCierreCajaReporte").click(function () {
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

    ReadbyID() {
        // alert("En construcción");
    };
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

