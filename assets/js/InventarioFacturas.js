class InventarioFacturas {
    // Constructor
    constructor(facturas, tb_facturas, tb_facturasExternas, factDetalle, tb_prdXFact, fechaInicial, fechaFinal, respuesta, dataFactura) {
        this.facturas = facturas || new Array();
        this.factDetalle = factDetalle || new Array();
        this.tb_facturas = tb_facturas || null;
        this.tb_facturasExternas = tb_facturasExternas || null;
        this.fechaInicial = fechaInicial || "";
        this.fechaFinal = fechaFinal || "";
        this.respuesta = respuesta || "";
        this.dataFactura = dataFactura || new Array();
    };

    CargaFacturas() {
        $.ajax({
            beforeSend: function () { $("body").addClass("loading"); },
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadAllbyRange",
                obj: JSON.stringify(inventarioFacturas)
            },
            complete: function () { $("body").removeClass("loading"); }
        })
            .done(function (e) {
                //                 if(JSON.parse(e).msg=='NOCONTRIB'){
                //                 swal({
                //                     type: 'warning',
                //                     title: 'Contribuyente',
                //                     text: 'Contribuyente no registrado para Facturación Electrónica',
                //                     footer: '<a href="clienteFE.html">Agregar Contribuyente</a>',
                //                     }).then((result) => {
                //                         if (result.value) 
                //                             location.href = "Dashboard.html";
                //                     })                
                //                 }
                //                 else 
                inventarioFacturas.drawFac(e)
            });
    };

    CargaFacturasXUsuario() {
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadAllById"
            }
        })
            .done(function (e) {
                if (JSON.parse(e).msg == 'NOCONTRIB') {
                    swal({
                        type: 'warning',
                        title: 'Contribuyente',
                        text: 'Contribuyente no registrado para Facturación Electrónica',
                        footer: '<a href="clienteFE.html">Agregar Contribuyente</a>',
                    }).then((result) => {
                        if (result.value)
                            location.href = "Dashboard.html";
                    })
                }
                else inventarioFacturas.drawFacUser(e)
            });
    };

    drawFac(e) {
        var facturas = JSON.parse(e);
        this.tb_facturas = $('#tb_facturas').DataTable({
            responsive: true,
            destroy: true,
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    footer: true,
                    exportOptions: {columns: [ 1, 2, 3, 4, 5, 6, 7]},
                    messageTop:'Lista de facturas'
                },
                {
                    extend: 'pdfHtml5',
                    footer: true,
                    messageTop:'Lista de facturas',
                    exportOptions: {columns: [ 1, 2, 3, 4, 5, 6, 7]}
                }
            ],
            language: {
                "infoEmpty": "Sin Facturas Registradas",
                "emptyTable": "Sin Facturas Registradas",
                "search": "Buscar",
                "zeroRecords": "No hay resultados",
                "lengthMenu": "Mostrar _MENU_ registros",
                "paginate": {
                    "first": "Primera",
                    "last": "Ultima",
                    "next": "Siguiente",
                    "previous": "Anterior"
                }
            },
            data: facturas,
            order: [[2, "desc"]],
            columns: [
                {
                    title: "ID FACTURA",
                    data: "id",
                    visible: false
                },
                {
                    title: "#FACTURA",
                    data: "consecutivo"
                },
                {
                    title: "FECHA",
                    data: "fechaCreacion"
                },
                {
                    title: "ALMACEN",
                    data: "bodega"
                },
                {
                    title: "VENDEDOR",
                    data: "vendedor"
                },
                {
                    title: "TOTAL",
                    data: "totalComprobante",
                    mRender: function (e) {
                        return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "MONTO EFECTIVO",
                    data: "montoEfectivo",
                    visible: false,
                    mRender: function (e) {
                        if (e == null)
                            return '¢0';
                        else
                            return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "MONTO TARJETA",
                    data: "montoTarjeta",
                    visible: false,
                    mRender: function (e) {
                        if (e == null)
                            return '¢0';
                        else
                            return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "ESTADO",
                    data: "idEstadoComprobante",
                    mRender: function (e) {
                        switch (e) {
                            case "1":
                                return '<i class="fa fa-paper-plane" aria-hidden="true" style="color:red"> Sin Enviar</i>';
                                break;
                            case "2":
                                return '<i class="fa fa-paper-plane" aria-hidden="true" style="color:green"> Enviado</i>';
                                break;
                            case "3":
                                return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green"> Aceptado</i>';
                                break;
                            case "4":
                                return '<i class="fa fa-times-circle" aria-hidden="true" style="color:red"> Rechazado</i>';
                                break;
                            case "5":
                                return '<i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:#FF6F00"> Otro</i>';
                                break;
                            case "6":
                                return '<i class="fa fa-stopwatch" aria-hidden="true" style="color:#FF6F00"> TimedOut</i>';
                                break;
                            case "7":
                                return '<i class="fa fa-angle-double-up" aria-hidden="true" style="color:#FF6F00"> Repetido</i>';
                                break;
                            case "8":
                                return '<i class="fa fa-minus-circle" aria-hidden="true" style="color:#FF6F00"> Firma Invalida(1)</i>';
                                break;
                            case "9":
                                return '<i class="fa fa-minus-circle" aria-hidden="true" style="color:#FF6F00"> Firma Invalida(2)</i>';
                                break;
                            case "10":
                                return '<i class="fa fa-minus-circle" aria-hidden="true" style="color:#FF6F00"> Firma Invalida(3)</i>';
                                break;
                            default:
                                return 'Desconocido';
                                break;

                        }
                    }
                },
                {
                    title: "ACCION",
                    className: "buttons",
                    data: "claveNC",
                    render: function (data, type, row, meta) {
                        if (data == null)
                            switch (row['idEstadoComprobante']) {
                                case "1":
                                    return '<button class=btnEnviarFactura>&nbsp Enviar</button>'; // Sin enviar // No se envio en el momento, no salio del sistema local No llego a MH //Envio en Contingencia
                                    break;
                                case "2":
                                    return '<i class="fa fa-check-square-o">&nbsp Enviada</i>'; // Enviado //Quitar Boton y que diga enviado
                                    break;
                                case "3":
                                    return '<button class=btnCancelaFactura>&nbsp Cancelar Factura</button>'; // Aceptado  //Solo cancelar // NC 
                                    break;
                                case "4":
                                    return '<button class=btnNC_CreateFact_Ref>&nbsp Reenviar</button>'; // Rechazado //NC //Nueva con referencia Confeccion de Factura  // BTNCancelar y enviar
                                    break;
                                case "5":
                                    return '<i class="fa fa-cloud-upload" aria-hidden="true">&nbsp Enviar Contingencia</i>'; // Error (Otros) //Envio en Contingencia
                                    break;
                                default:
                                    return '<button>Soporte</button>';
                                    break;
                            }
                        else
                            return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green">&nbsp Factura Cancelada!</i>';
                    }
                }
            ],
            footerCallback: function (row, data, start, end, display) {
                var api = this.api();
                // Remueve el formato de la columna
                var intVal = function (i) {
                    return typeof i === 'string' ?
                        parseFloat(i.replace(/[\¢,]/g, '')) :
                        typeof i === 'number' ?
                            i : 0;
                };
                // Total de todas las paginas filtradas
                var subTotal = display.map(el => data[el]['totalComprobante']).reduce((a, b) => intVal(a) + intVal(b), 0);

                // Actualiza el footer
                $(api.column(1).footer()).html("TOTALES");
                $(api.column(5).footer()).html('¢' + parseFloat(Number(subTotal)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            }
        });
    };

    drawFacExternas(e) {
        var facturas = JSON.parse(e);
        this.tb_facturasExternas = $('#tb_facturasExternas').DataTable({
            responsive: true,
            destroy: true,
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    footer: true,
                    exportOptions: { columns: [1, 2, 3, 4, 5, 6] },
                    messageTop: 'Lista de facturas'
                },
                {
                    extend: 'pdfHtml5',
                    footer: true,
                    messageTop: 'Lista de facturas',
                    exportOptions: {
                        columns: [1, 2, 3, 4, 5, 6]
                    }
                }
            ],
            language: {
                "infoEmpty": "Sin Facturas Registradas",
                "emptyTable": "Sin Facturas Registradas",
                "search": "Buscar",
                "zeroRecords": "No hay resultados",
                "lengthMenu": "Mostrar _MENU_ registros",
                "paginate": {
                    "first": "Primera",
                    "last": "Ultima",
                    "next": "Siguiente",
                    "previous": "Anterior"
                }
            },
            data: facturas,
            order: [[1, "desc"]],
            columns: [
                {
                    title: "ID FACTURA",
                    data: "id",
                    visible: false
                },
                {
                    title: "#FACTURA",
                    data: "consecutivo"
                },
                {
                    title: "FECHA",
                    data: "fechaCreacion"
                },
                {
                    title: "ALMACEN",
                    data: "bodega"
                },
                {
                    title: "VENDEDOR",
                    data: "vendedor"
                },
                {
                    title: "TOTAL",
                    data: "totalComprobante",
                    mRender: function (e) {
                        return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "MONTO EFECTIVO",
                    data: "montoEfectivo",
                    visible: false,
                    mRender: function (e) {
                        if (e == null)
                            return '¢0';
                        else
                            return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "MONTO TARJETA",
                    data: "montoTarjeta",
                    visible: false,
                    mRender: function (e) {
                        if (e == null)
                            return '¢0';
                        else
                            return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "ESTADO",
                    data: "idEstadoComprobante",
                    mRender: function (e) {
                        switch (e) {
                            case "1":
                                return '<i class="fa fa-paper-plane" aria-hidden="true" style="color:red"> Sin Enviar</i>';
                                break;
                            case "2":
                                return '<i class="fa fa-paper-plane" aria-hidden="true" style="color:green"> Enviado</i>';
                                break;
                            case "3":
                                return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green"> Aceptado</i>';
                                break;
                            case "4":
                                return '<i class="fa fa-times-circle" aria-hidden="true" style="color:red"> Rechazado</i>';
                                break;
                            case "5":
                                return '<i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:#FF6F00"> Otro</i>';
                                break;
                            case "6":
                                return '<i class="fa fa-stopwatch" aria-hidden="true" style="color:#FF6F00"> TimedOut</i>';
                                break;
                            case "7":
                                return '<i class="fa fa-angle-double-up" aria-hidden="true" style="color:#FF6F00"> Repetido</i>';
                                break;
                            case "8":
                                return '<i class="fa fa-minus-circle" aria-hidden="true" style="color:#FF6F00"> Firma Invalida(1)</i>';
                                break;
                            case "9":
                                return '<i class="fa fa-minus-circle" aria-hidden="true" style="color:#FF6F00"> Firma Invalida(2)</i>';
                                break;
                            case "10":
                                return '<i class="fa fa-minus-circle" aria-hidden="true" style="color:#FF6F00"> Firma Invalida(3)</i>';
                                break;
                            default:
                                return 'Desconocido';
                                break;

                        }
                    }
                },
                {
                    title: "ACCION",
                    className: "buttons",
                    data: "claveNC",
                    render: function (data, type, row, meta) {
                        if (data == null)
                            switch (row['idEstadoComprobante']) {
                                case "1":
                                    return '<button class=btnEnviarFactura>&nbsp Enviar</button>'; // Sin enviar // No se envio en el momento, no salio del sistema local No llego a MH //Envio en Contingencia
                                    break;
                                case "2":
                                    return '<i class="fa fa-check-square-o">&nbsp Enviada</i>'; // Enviado //Quitar Boton y que diga enviado
                                    break;
                                case "3":
                                    return '<button class=btnCancelaFactura>&nbsp Cancelar Factura</button>'; // Aceptado  //Solo cancelar // NC 
                                    break;
                                case "4":
                                    return '<button class=btnNC_CreateFact_Ref>&nbsp Reenviar</button>'; // Rechazado //NC //Nueva con referencia Confeccion de Factura  // BTNCancelar y enviar
                                    break;
                                case "5":
                                    return '<i class="fa fa-cloud-upload" aria-hidden="true">&nbsp Enviar Contingencia</i>'; // Error (Otros) //Envio en Contingencia
                                    break;
                                default:
                                    return '<button>Soporte</button>';
                                    break;
                            }
                        else
                            return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green">&nbsp Factura Cancelada!</i>';
                    }
                }
            ],
            footerCallback: function (row, data, start, end, display) {
                var api = this.api();
                // Remueve el formato de la columna
                var intVal = function (i) {
                    return typeof i === 'string' ?
                        parseFloat(i.replace(/[\¢,]/g, '')) :
                        typeof i === 'number' ?
                            i : 0;
                };
                // Total de todas las paginas filtradas
                var subTotal = display.map(el => data[el]['totalComprobante']).reduce((a, b) => intVal(a) + intVal(b), 0);

                // Actualiza el footer
                $(api.column(1).footer()).html("TOTALES");
                $(api.column(5).footer()).html('¢' + parseFloat(Number(subTotal)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            }
        });
    };

    drawFacUser(e) {
        var facturas = JSON.parse(e);
        this.tb_facturas = $('#tb_facturas').DataTable({
            responsive: true,
            destroy: true,
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    footer: true,
                    exportOptions: {columns: [ 1, 2, 3, 4, 5, 6, 7]},
                    messageTop:'Lista de facturas'
                },
                {
                    extend: 'pdfHtml5',
                    footer: true,
                    messageTop:'Lista de facturas',
                    exportOptions: { columns: [ 1, 2, 3, 4, 5, 6, 7] }
                }
            ],
            language: {
                "infoEmpty": "Sin Facturas Registradas",
                "emptyTable": "Sin Facturas Registradas",
                "search": "Buscar",
                "zeroRecords": "No hay resultados",
                "lengthMenu": "Mostrar _MENU_ registros",
                "paginate": {
                    "first": "Primera",
                    "last": "Ultima",
                    "next": "Siguiente",
                    "previous": "Anterior"
                }
            },
            data: facturas,
            order: [[1, "desc"]],
            columns: [
                {
                    title: "ID FACTURA",
                    data: "id",
                    visible: false
                },
                {
                    title: "#FACTURA",
                    data: "consecutivo"
                },
                {
                    title: "FECHA",
                    data: "fechaCreacion"
                },
                {
                    title: "ALMACEN",
                    data: "bodega"
                },
                {
                    title: "VENDEDOR",
                    data: "vendedor"
                },
                {
                    title: "TOTAL",
                    data: "totalComprobante",
                    mRender: function (e) {
                        return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "MONTO EFECTIVO",
                    data: "montoEfectivo",
                    visible: false,
                    mRender: function (e) {
                        if (e == null)
                            return '¢0';
                        else
                            return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "MONTO TARJETA",
                    data: "montoTarjeta",
                    visible: false,
                    mRender: function (e) {
                        if (e == null)
                            return '¢0';
                        else
                            return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "ESTADO",
                    data: "idEstadoComprobante",
                    mRender: function (e) {
                        switch (e) {
                            case "1":
                                return '<i class="fa fa-paper-plane" aria-hidden="true" style="color:red"> Sin Enviar</i>';
                                break;
                            case "2":
                                return '<i class="fa fa-paper-plane" aria-hidden="true" style="color:green"> Enviado</i>';
                                break;
                            case "3":
                                return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green"> Aceptado</i>';
                                break;
                            case "4":
                                return '<i class="fa fa-times-circle" aria-hidden="true" style="color:red"> Rechazado</i>';
                                break;
                            case "5":
                                return '<i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:#FF6F00"> Otro</i>';
                                break;
                            case "99":
                                return '<i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:green"> Reportado</i>';
                                break;
                            default:
                                return 'Desconocido';
                                break;

                        }
                    }
                },
                {
                    title: "ACCION",
                    className: "buttons",
                    data: "claveNC",
                    render: function (data, type, row, meta) {
                        if (data == null)
                            switch (row['idEstadoComprobante']) {
                                case "1":
                                    return '<button class=btnEnviarFactura>&nbsp Enviar</button>'; // Sin enviar // No se envio en el momento, no salio del sistema local No llego a MH //Envio en Contingencia
                                    break;
                                case "2":
                                    return '<i class="fa fa-check-square-o">&nbsp Enviada</i>'; // Enviado //Quitar Boton y que diga enviado
                                    break;
                                case "3":
                                    return '<button class=btnCancelaFactura>&nbsp Cancelar Factura</button>'; // Aceptado  //Solo cancelar // NC 
                                    break;
                                case "4":
                                    return '<button class=btnNC_CreateFact_Ref>&nbsp Reenviar</button>'; // Rechazado //NC //Nueva con referencia Confeccion de Factura  // BTNCancelar y enviar
                                    break;
                                case "5":
                                    return '<i class="fa fa-cloud-upload" aria-hidden="true">&nbsp Enviar Contingencia</i>'; // Error (Otros) //Envio en Contingencia
                                    break;
                                default:
                                    return '<button>Soporte</button>';
                                    break;
                            }
                        else
                            return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green">&nbsp Factura Cancelada!</i>';
                    }
                }
            ],
            footerCallback: function (row, data, start, end, display) {
                var api = this.api();
                // Remueve el formato de la columna
                var intVal = function (i) {
                    return typeof i === 'string' ?
                        parseFloat(i.replace(/[\¢,]/g, '')) :
                        typeof i === 'number' ?
                            i : 0;
                };
                // Total de todas las paginas filtradas
                var subTotal = display.map(el => data[el]['totalComprobante']).reduce((a, b) => intVal(a) + intVal(b), 0);

                // Actualiza el footer
                $(api.column(1).footer()).html("TOTALES");
                $(api.column(5).footer()).html('¢' + parseFloat(Number(subTotal)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            }
        });
    };

    ReadbyID(data) {
        $("#mensajeRechazo").text("");
        $("#detalleFac").empty();
        var detalleFac = null;
        //FACTURA NORMAL
        if (data.idReferencia == null) {
            detalleFac =
            `<button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">x</span>
            </button>
            <h4 class="modal-title">Factura #</h4>
            <h4 class="modal-title" id="consecutivo">${data.consecutivo}.</h4>
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <label>Fecha:</label>
                    <label id='fecha'>${data.fechaCreacion}</label>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <label>Cajero:</label>
                    <label id='cajero'>${data.vendedor}</label>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <label>Bodega:</label>
                    <label id='bodega'>${data.bodega}</label>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <label>Clave Factura:</label>
                    <label id='clave'>${data.clave}</label>
                </div>
            </div>`;                        
        }
        else{
            //NOTA DE CREDITO
            if (data.consecutivo == data.idReferencia) {
                detalleFac =
                `<button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">x</span>
                </button>
                <h4 class="modal-title">Factura Cancelada #</h4>
                <h4 class="modal-title" id="consecutivo">${data.consecutivo}.</h4>
                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <label>Fecha:</label>
                        <label id='fecha'>${data.fechaCreacion}</label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <label>Cajero:</label>
                        <label id='cajero'>${data.vendedor}</label>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <label>Bodega:</label>
                        <label id='bodega'>${data.bodega}</label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <label>Clave Factura NC:</label>
                        <label id='clave'>${data.claveNC}</label>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <label>Referencia Factura:</label>
                        </br><label id='claveNC'>${data.idReferencia}</label>
                    </div>
                </div>`;                        
            }
            //REENVIO DE FACTURA
            else{
                if (data.idReferencia == '1') {
                    detalleFac =
                    `<button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">x</span>
                    </button>
                    <h4 class="modal-title">Factura #</h4>
                    <h4 class="modal-title" id="consecutivo">${data.consecutivo}.</h4>
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label>Fecha:</label>
                            <label id='fecha'>${data.fechaCreacion}</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label>Cajero:</label>
                            <label id='cajero'>${data.vendedor}</label>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label>Bodega:</label>
                            <label id='bodega'>${data.bodega}</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label>Clave Factura NC:</label>
                            <label id='claveNC'>${data.claveNC}</label>
                        </div>
                    </div>`;                        
                }
                else{
                    detalleFac =
                    `<button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">x</span>
                    </button>
                    <h4 class="modal-title">Factura #</h4>
                    <h4 class="modal-title" id="consecutivo">${data.consecutivo}.</h4>
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label>Fecha:</label>
                            <label id='fecha'>${data.fechaCreacion}</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label>Cajero:</label>
                            <label id='cajero'>${data.vendedor}</label>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label>Bodega:</label>
                            <label id='bodega'>${data.bodega}</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-6">
                            <label>Clave Factura:</label>
                            <label id='clave'>${data.clave}</label>
                        </div>
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <label>Referencia Factura:</label>
                        <label id='idReferencia'>${data.idReferencia}</label>
                    </div>
                    </div>`;
                }                 
            }
        }
        $("#detalleFac").append(detalleFac);
        $("#totalFact").empty();

        $.ajax({
            type: "POST",
            url: "class/productoXFactura.php",
            data: {
                action: "ReadByIdFactura",
                id: data.id
            }
        })
            .done(function (e) {
                inventarioFacturas.drawFactDetail(e);
            });
        if (data.idEstadoComprobante=="4")
            inventarioFacturas.ReadRespuestaRachazo(data.id);  
    };

    ReadRespuestaRachazo(idFactura) {
        var resultado = "";
        var referenciaCircular = inventarioFacturas.tb_facturas;
        inventarioFacturas.tb_facturas = [];
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadRespuestaRachazo",
                id: idFactura
            }
        })
            .done(function (e) {
                if (e != " []") {
                    inventarioFacturas.tb_facturas = referenciaCircular;
                    resultado = JSON.parse(e);
                    $("#mensajeRechazo").text("");
                    $("#mensajeRechazo").append('</br><label class="control-label">FACTURA RECHAZADA - Respuesta Ministerio de Hacienda</label></br>');
                    $("#mensajeRechazo").append(resultado[0].respuesta);
                }
                else
                    return false;
            });
    };

    CargaListaFacturasRango() {
        var referenciaCircular = inventarioFacturas.tb_facturas;
        inventarioFacturas.tb_facturas = [];
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadAllbyRange",
                obj: JSON.stringify(inventarioFacturas)
            }
        })
            .done(function (e) {
                if (e != " ") {
                    inventarioFacturas.tb_facturas = referenciaCircular;
                    inventarioFacturas.drawFac(e);
                } else {
                    swal({
                        type: 'success',
                        title: 'Listo, no hay facturas que cargar!',
                        showConfirmButton: false,
                        timer: 2000
                    });
                }


            });
    };

    CargaListaFacturasRangoExternas() {
        var referenciaCircular = inventarioFacturas.tb_facturasExternas;
        inventarioFacturas.tb_facturasExternas = [];
        // var referenciaCircular2 = inventarioFacturas.tb_facturas;
        // inventarioFacturas.tb_facturas = [];
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadAllbyRangeExterna",
                obj: JSON.stringify(inventarioFacturas)
            }
        })
            .done(function (e) {
                if (e != " ") {
                    inventarioFacturas.tb_facturasExternas = referenciaCircular;
                    // inventarioFacturas.tb_facturas = referenciaCircular2;        
                    inventarioFacturas.drawFacExternas(e);
                } else {
                    swal({
                        type: 'success',
                        title: 'Listo, no hay facturas que cargar!',
                        showConfirmButton: false,
                        timer: 2000
                    });
                }


            });
    };

    CargaListaFacturasRangoUser() {
        var referenciaCircular = inventarioFacturas.tb_facturas;
        inventarioFacturas.tb_facturas = [];
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadAllbyRange",
                obj: JSON.stringify(inventarioFacturas)
            }
        })
            .done(function (e) {
                inventarioFacturas.tb_facturas = referenciaCircular;
                inventarioFacturas.drawFac(e);
            });
    };

    sendContingenciaMasiva() {
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "sendContingenciaMasiva"
            }
        })
            .done(function (e) {
                inventarioFacturas.CargaListaFacturasRango();
            });
    };

    sendContingenciaMasivaExterna() {
        $.ajax({
            type: "POST",
            url: "class/Distribucion.php",
            data: {
                action: "sendContingenciaMasiva"
            }
        })
            .done(function (e) {
                inventarioFacturas.CargaListaFacturasRangoExternas();
            });
    };

    sendMasiva() {
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "sendMasiva"
            }
        })
            .done(function (e) {
                inventarioFacturas.CargaListaFacturasRango();
            });
    };

    CargaMisFacturasRango() {
        var referenciaCircular = inventarioFacturas.tb_facturas;
        inventarioFacturas.tb_facturas = [];
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadAllbyRangeUser",
                obj: JSON.stringify(inventarioFacturas)
            }
        })
            .done(function (e) {
                if (e != " ") {
                    inventarioFacturas.tb_facturas = referenciaCircular;
                    inventarioFacturas.drawFacUser(e);
                } else {
                    swal({
                        type: 'success',
                        title: 'Listo, no hay facturas que cargar!',
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            });
    };

    drawFactDetail(e) {
        this.factDetalle = JSON.parse(e);

        this.tb_prdXFact = $('#tb_detalle_fact').DataTable({
            data: this.factDetalle,
            destroy: true,
            "searching": false,
            "paging": false,
            "info": false,
            "ordering": false,
            // "retrieve": true,
            "order": [[0, "desc"]],
            columns: [
                {
                    title: "PRODUCTO",
                    data: "detalle"
                },
                {
                    title: "CANTIDAD",
                    data: "cantidad",
                    type: 'formatted-num',
                    mRender: function (e) {
                        return parseFloat(e).toFixed(2)
                    }
                },
                {
                    title: "PRECIO",
                    data: "montoTotalLinea",
                    type: 'formatted-num',
                    mRender: function (e) {
                        return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                }
            ]
        });

        $('#modalFac').modal('toggle');
        //Activar el boton para imprimir facturas canceladas

    };

    ticketPrint() {
        localStorage.setItem("lsFactura", $('#consecutivo').text());
        // localStorage.setItem("lsFecha",moment().format("YYYY-MM-DD HH:mm"));
        localStorage.setItem("lsBodega", $('#bodega').text());
        localStorage.setItem("lsUsuario", $("#call_username").text());
        localStorage.setItem("lsListaProducto", JSON.stringify(this.factDetalle));
        location.href = "/TicketFacturacion.html";
    };

    ticketPrintCancelada(data) {
        localStorage.setItem("lsTipoPrint", "LISTAFACTURAS");
        localStorage.setItem("lsFactura", data.consecutivo);
        localStorage.setItem("lsBodega", data.bodega);
        localStorage.setItem("lsUsuario", $("#call_username").text());
        localStorage.setItem("lsEfectivo", data.montoEfectivo);
        localStorage.setItem("lsVuelto", parseFloat(data.montoEfectivo) - parseFloat(data.totalComprobante));
        localStorage.setItem("lsTotal", data.totalComprobante);
        localStorage.setItem("lsClave", data.clave);

        $.ajax({
            type: "POST",
            url: "class/productoXFactura.php",
            data: {
                action: "ReadByIdFactura",
                id: data.id
            }
        })
            .done(function (e) {
                inventarioFacturas.factDetalle = JSON.parse(e);
                localStorage.setItem("lsListaProducto", JSON.stringify(inventarioFacturas.factDetalle));
                location.href = "/TicketFacturacion.html";
            });
    }


    ReadbyID(id) {
        $("#mensajeRechazo").text("");
        $("#detalleFac").empty();
        var detalleFac =
            `<button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">x</span>
            </button>
            <h4 class="modal-title">Factura #</h4>
            <h4 class="modal-title" id="consecutivo">${id.consecutivo}.</h4>
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <label>Fecha:</label>
                    <label id='fecha'>${id.fechaCreacion}</label>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <label>Cajero:</label>
                    <label id='cajero'>${id.vendedor}</label>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <label>Bodega:</label>
                    <label id='bodega'>${id.bodega}</label>
                </div>
            </div>`;
        $("#detalleFac").append(detalleFac);

        $("#totalFact").empty();

        // var totalFact =
        //     `<h4>Total: ¢${Math.round(id.totalVenta)}</h4>`;
        // $("#totalFact").append(totalFact);
        // 

        $.ajax({
            type: "POST",
            url: "class/productoXFactura.php",
            data: {
                action: "ReadByIdFactura",
                id: id.id
            }
        })
            .done(function (e) {
                inventarioFacturas.drawFactDetail(e);
            });
        if (id.idEstadoComprobante == "4")
            inventarioFacturas.ReadRespuestaRachazo(id.id);
    };
}
//Class Instance
let inventarioFacturas = new InventarioFacturas();



$('#tb_facturasExternas tbody').on('click', 'td', function () {
    inventarioFacturas.ReadbyID(inventarioFacturas.tb_facturasExternas.row(this).data());
});

$('#tb_facturas tbody').on('click', 'td', function () {
    if (localStorage.getItem("lsPrintFacturaOpcion") != "BTN") {
        if ($(this).parents('tr').find('td:eq(6) i').html() == "&nbsp; Factura Cancelada!")
            localStorage.setItem("lsPrintFacturaOpcion", "CANCEL");
        else
            localStorage.setItem("lsPrintFacturaOpcion", "LIST");
    }
    if ($.trim(this.textContent) == ("Enviar")
        // ||$.trim(this.textContent) == ("Enviada")
        || $.trim(this.textContent) == ("Cancelar Factura")
        || $.trim(this.textContent) == ("Cancelar & Reenviar")
        // ||$.trim(this.textContent) == ("Enviar Contingencia")
    )
        return false;

    inventarioFacturas.ReadbyID(inventarioFacturas.tb_facturas.row(this).data());
    var dtTable = $('#tb_facturas').DataTable();
    var efectivo = 0;
    var total = 0;
    var fecha;
    efectivo = parseFloat(dtTable.row(this).data()[8]);
    total = parseFloat(dtTable.row(this).data()[11]);
    fecha = dtTable.row(this).data()[3];
    if (dtTable.cells().data()[5] == null)
        efectivo = 0;
    if (dtTable.cells().data()[6] == null)
        tarjeta = 0;

    if (efectivo == "0") {
        localStorage.setItem("lsVuelto", "0");
        localStorage.setItem("lsTarjetaCredito", String(total));
    }
    else {
        localStorage.setItem("lsVuelto", String(efectivo - total));
        localStorage.setItem("lsTarjetaCredito", "0");
    }
    localStorage.setItem("lsFecha", fecha);
    localStorage.setItem("lsEfectivo", String(efectivo));
    localStorage.setItem("lsTotal", String(total));
    localStorage.setItem("lsDif", "0");
    localStorage.setItem("lsReimpresion", "OK");
});

