class InventarioFacturas {
    // Constructor
    constructor(facturas, tb_facturas, factDetalle, tb_prdXFact, fechaInicial, fechaFinal) {
        this.facturas = facturas || new Array();
        this.factDetalle = factDetalle || new Array();
        this.tb_facturas = tb_facturas || null;
        this.fechaInicial = fechaInicial || "";
        this.fechaFinal = fechaFinal || "";
    };

    CargaFacturas() {
        $.ajax({
            beforeSend: function() {  $("body").addClass("loading"); },
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadAllbyRange",
                obj: JSON.stringify(inventarioFacturas)
            },
            complete: function() {  $("body").removeClass("loading"); }
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
                if(JSON.parse(e).msg=='NOCONTRIB'){
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
                    exportOptions: {columns: [ 1, 2, 3, 4, 5, 6]},
                    messageTop:'Lista de facturas'
                },
                {
                    extend: 'pdfHtml5',
                    footer: true,
                    messageTop:'Lista de facturas',
                    exportOptions: {
                        columns: [ 1, 2, 3, 4, 5, 6]
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
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "MONTO EFECTIVO",
                    data: "montoEfectivo",
                    visible: false,
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'; 
                        else
                            return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "MONTO TARJETA",
                    data: "montoTarjeta",
                    visible: false,
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'; 
                        else
                            return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "ESTADO",
                    data: "idEstadoComprobante",
                    mRender: function ( e ) {
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
                    render: function ( data, type, row, meta ) {
                        if(data==null)
                            switch (row['idEstadoComprobante']) {
                                case "1":
                                    return '<button class=btnEnviarFactura>Enviar</button>';
                                    break;
                                case "2":
                                    return '<button class=btnConsultafactura>Consultar</button>';
                                    break;
                                case "3":
                                    return '<button class=btnCancelaFactura>Cancelar Factura</button>';
                                    break;
                                case "4":
                                    return '<button class=btnCancelaFactura>Cancelar Factura</button>';
                                    break;
                                case "5":
                                    return '<button class=btnReenviarFactura>Reenviar</button><button class=btnSoporte>Soporte</button>';
                                    break;
                                default:
                                    return '<button>Soporte</button>';
                                    break;
                            }    
                            else
                                return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green">Factura Cancelada!</i>';
                    }
                }
            ],
            footerCallback: function ( row, data, start, end, display ) {
                var api = this.api();
                // Remueve el formato de la columna
                var intVal = function ( i ) {
                    return typeof i === 'string' ?
                        parseFloat(i.replace(/[\¢,]/g, '')) :
                        typeof i === 'number' ?
                        i : 0;
                };
                // Total de todas las paginas filtradas
                var subTotal = display.map(el => data[el]['totalComprobante']).reduce((a, b) => intVal(a) + intVal(b), 0 );
                
                // Actualiza el footer
                $( api.column( 1 ).footer() ).html("TOTALES");
                $( api.column( 5 ).footer() ).html('¢' + parseFloat(Number(subTotal)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
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
                    exportOptions: {columns: [ 1, 2, 3, 4, 5, 6]},
                    messageTop:'Lista de facturas'
                },
                {
                    extend: 'pdfHtml5',
                    footer: true,
                    messageTop:'Lista de facturas',
                    exportOptions: {
                        columns: [ 1, 2, 3, 4, 5, 6]
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
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "MONTO EFECTIVO",
                    data: "montoEfectivo",
                    visible: false,
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'; 
                        else
                            return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "MONTO TARJETA",
                    data: "montoTarjeta",
                    visible: false,
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'; 
                        else
                            return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "ESTADO",
                    data: "idEstadoComprobante",
                    mRender: function ( e ) {
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
                }
            ],
            footerCallback: function ( row, data, start, end, display ) {
                var api = this.api();
                // Remueve el formato de la columna
                var intVal = function ( i ) {
                    return typeof i === 'string' ?
                        parseFloat(i.replace(/[\¢,]/g, '')) :
                        typeof i === 'number' ?
                        i : 0;
                };
                // Total de todas las paginas filtradas
                var subTotal = display.map(el => data[el]['totalComprobante']).reduce((a, b) => intVal(a) + intVal(b), 0 );
                
                // Actualiza el footer
                $( api.column( 1 ).footer() ).html("TOTALES");
                $( api.column( 5 ).footer() ).html('¢' + parseFloat(Number(subTotal)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            }
        });
    };

    ReadbyID(id) {
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
    };

    CargaListaFacturasRango(){
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

    CargaListaFacturasRangoUser(){
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

    sendContingenciaMasiva(){
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

    sendMasiva(){
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

    CargaMisFacturasRango(){
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
                inventarioFacturas.tb_facturas = referenciaCircular;        
                inventarioFacturas.drawFacUser(e); 
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
                    mRender: function ( e ) {
                        return parseFloat(e).toFixed(2)}
                },
                {
                    title: "PRECIO",
                    data: "montoTotalLinea",
                    type: 'formatted-num',
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")}
                }
            ]
        });

        $('#modalFac').modal('toggle');

    };

    ticketPrint() {
        localStorage.setItem("lsFactura",$('#consecutivo').text());
        localStorage.setItem("lsFecha",moment().format("YYYY-MM-DD HH:mm"));
        localStorage.setItem("lsBodega",$('#bodega').text());
        localStorage.setItem("lsUsuario",$('#cajero').text());
        localStorage.setItem("lsListaProducto",JSON.stringify(this.factDetalle));
        // location.href ="/Tropical/TicketFacturacion.html";
        location.href = "/TicketFacturacion.html";
    };
}
//Class Instance
let inventarioFacturas = new InventarioFacturas();

$('#tb_facturas tbody').on('click', 'td', function () {
    if (this.textContent == ("Cancelar Factura")
    ||this.textContent == ("Consultar")
    ||this.textContent == ("ReenviarSoporte")
    ||this.textContent == ("Enviar"))
        return false;

    inventarioFacturas.ReadbyID(inventarioFacturas.tb_facturas.row(this).data());
    var dtTable = $('#tb_facturas').DataTable();
    var efectivo=0;
    var total=0;
    efectivo = parseFloat(dtTable.row(this).data()[8]);
    total = parseFloat(dtTable.row(this).data()[11]);
    if (dtTable.cells().data()[5]==null) 
        efectivo = 0;
    if (dtTable.cells().data()[6]==null) 
        tarjeta = 0;

    if (efectivo=="0"){
        localStorage.setItem("lsVuelto","0");
        localStorage.setItem("lsTarjetaCredito",String(total));
    }
    else{
        localStorage.setItem("lsVuelto",String(efectivo-total));
        localStorage.setItem("lsTarjetaCredito","0");
    }
    
    localStorage.setItem("lsEfectivo",String(efectivo));
    localStorage.setItem("lsTotal",String(total));
    localStorage.setItem("lsDif","0");
    localStorage.setItem("lsReimpresion","OK");
});

// $('#tb_facturas tbody').on( 'click', 'button', function () {
//     var data = inventarioFacturas.tb_facturas.row( $(this).parents('tr') ).data();
//     var id = data['id'];
//     var numeroFactura = data['consecutivo'];
//     var fecha = data['fechaCreacion'];
//     var almacen = data['bodega'];
//     var vendedor = data['vendedor'];
//     var total = '¢'+ parseFloat(data['totalComprobante']).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
//     var est = data['idEstadoComprobante'];
    
//     var estado ='';
//     switch (est) {
//         case "1": estado="Sin Enviar"; 
//         break;
//         case "4": estado="Rechazada";
//         break;
//         case "5": estado="Otro";
//         break; 
//     }
//     var object = [id, numeroFactura, fecha, almacen, vendedor, total, estado];
//     $.ajax({
//         type: "POST",
//         url: "class/Factura.php",
//         data: {
//             action: "mailSoporte",
//             facturaMailSoporte: object
//         }
//     })
//     .done(function (e) {
//         var start = moment().subtract(29, 'days');
//         var end = moment();

//         function cb(start, end) {
//             $('#dp_rangoListaFacturas span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
//         }

//         $('#dp_rangoListaFacturas').daterangepicker({
//             "opens": "left",
//             "locale": {
//                 "format": "DD/MM/YYYY",
//                 "separator": " - ",
//                 "applyLabel": "Aplicar",
//                 "cancelLabel": "Cancelar",
//                 "fromLabel": "From",
//                 "toLabel": "To",
//                 "customRangeLabel": "Manual",
//                 "daysOfWeek": [
//                     "DO",
//                     "Lu",
//                     "Ma",
//                     "Mi",
//                     "Ju",
//                     "Vi",
//                     "Sa"
//                 ],
//                 "monthNames": [
//                     "Enero",
//                     "Febrero",
//                     "Marzo",
//                     "Abril",
//                     "Mayo",
//                     "Junio",
//                     "Julio",
//                     "Agosto",
//                     "Setiembre",
//                     "Octubre",
//                     "Noviembre",
//                     "Diciembre"
//                 ],
//                 "firstDay": 1
//             },
//             startDate: start,
//             endDate: end,
//             ranges: {
//                 'Hoy': [moment(), moment()],
//                 'Ayer': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
//                 'Ultimos 7 Días': [moment().subtract(6, 'days'), moment()],
//                 'Ultimos 30 Días': [moment().subtract(29, 'days'), moment()],
//                 'Este Mes': [moment().startOf('month'), moment().endOf('month')],
//                 'Ultimo Mes': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
//             }
//         }, cb);

//         cb(start, end);

//         inventarioFacturas.fechaInicial = start.format('YYYY-MM-DD') + ' 00:00';
//         inventarioFacturas.fechaFinal = end.format('YYYY-MM-DD') + ' 23:59';
//         inventarioFacturas.CargaListaFacturasRango();

//         swal({
//             type: 'success',
//             title: 'La factura con problemas fue notificada a SOPORTE!',
//             showConfirmButton: false,
//             timer: 2000
//         });
//     })
//     .always(function () {
        
//     });
// });

