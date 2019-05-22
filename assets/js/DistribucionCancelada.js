class DistribucionCancelada {
    // Constructor
    constructor(facturas, tb_distribucionCanceladas, factDetalle, tb_prdXFact, fechaInicial, fechaFinal) {
        this.facturas = facturas || new Array();
        this.factDetalle = factDetalle || new Array();
        this.tb_distribucionCanceladas = tb_distribucionCanceladas || null;
        this.fechaInicial = fechaInicial || "";
        this.fechaFinal = fechaFinal || "";
    };

    CargaDistribuciones() {
        $.ajax({
            beforeSend: function() {  $("body").addClass("loading"); },
            type: "POST",
            url: "class/Distribucion.php",
            data: {
                action: "ReadCancelada",
                obj: JSON.stringify(distribucionCancelada)
            },
            complete: function() {  $("body").removeClass("loading"); }
        })
            .done(function (e) {
                distribucionCancelada.drawFac(e)
            });
    };

    setTableVista(buttons = true) {
        $('#tDistribucion').DataTable({
            responsive: true,
            destroy: true,
            order: [[1, "desc"]],
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    exportOptions: {columns: [ 1, 2, 3, 4, 5, 6]},
                    messageTop:'Traslados y facturación'
                },
                {
                    extend: 'pdfHtml5',
                    messageTop:'Traslados y facturación',
                    exportOptions: {
                        columns: [ 1, 2, 3, 4, 5, 6]
                    }
                }
            ],
            "language": {
                "infoEmpty": "Sin Traslados Registrados",
                "emptyTable": "Sin Traslados Registrados",
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
            columns: [{
                    title: "ID",
                    data: "id",
                    className: "itemId",
                    searchable: false
                },
                {
                    title: "FECHA",
                    data: "fecha"
                },
                {
                    title: "ORDEN",
                    data: "orden"
                },
                {
                    title: "USUARIO",
                    data: "userName"
                },
                {
                    title: "BODEGA",
                    data: "bodega"
                },
                {
                    title: "TOTAL",
                    data: "total",
                    className: "text-right",
                    // className: "total",
                    mRender: function (e) {
                        return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                },
                {
                    title: "ESTADO",
                    data: "idEstadoComprobante",
                    render: function ( data, type, row, meta ) {
                        if(row['tipoBodega']!='Interna')
                            switch (data) {
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
                        else
                            return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green"> Aceptado</i>';
                        
                    }
                },
                {
                    title: "TIPO BODEGA",
                    data: "tipoBodega"
                },
                {
                    title: "ACCION",
                    className: "buttons",
                    data: "claveNC",
                    render: function ( data, type, row, meta ) {
                        if(row['tipoBodega']!='Interna')
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
                        else
                            return '<button class=btnCancelaFactura>Cancelar Factura</button>'
                    }
                }
            ]
        });
    };

    CargaDistribucionesXUsuario() {
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadCanceladaUsuario"
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
                else distribucionCancelada.drawFac(e)
            });
    };

    drawFac(e) {
        var facturas = JSON.parse(e);
        this.tb_distribucionCanceladas = $('#tb_distribucionCanceladas').DataTable({
            responsive: true,
            destroy: true,
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    footer: true,
                    exportOptions: {columns: [ 1, 2, 3, 4, 5, 6]},
                    messageTop:'Lista de facturas Canceladas'
                },
                {
                    extend: 'pdfHtml5',
                    footer: true,
                    messageTop:'Lista de facturas Canceladas',
                    exportOptions: {
                        columns: [ 1, 2, 3, 4, 5, 6]
                    }
                }
            ],
            language: {
                "infoEmpty": "Sin Distribuciones Canceladas",
                "emptyTable": "Sin Distribuciones Canceladas",
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
            columns: [{
                title: "ID",
                data: "id",
                className: "itemId",
                searchable: false
            },
            {
                title: "FECHA",
                data: "fecha"
            },
            {
                title: "ORDEN",
                data: "orden"
            },
            {
                title: "USUARIO",
                data: "userName"
            },
            {
                title: "BODEGA",
                data: "bodega"
            },
            {
                title: "TOTAL",
                data: "total",
                className: "text-right",
                // className: "total",
                mRender: function (e) {
                    return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                }
            },
            {
                title: "TIPO BODEGA",
                data: "tipoBodega"
            },
            {
                title: "ESTADO",
                data: "idEstadoComprobante",
                render: function ( data, type, row, meta ) {
                    if(row['tipoBodega']!='Interna')
                        switch (data) {
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
                    else
                        return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green"> Aceptado</i>';
                    
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
                                return '<button class=btnEnviarFactura>&nbsp Enviar</button>'; // Sin enviar // No se envio en el momento No llego a MH //Envio en Contingencia
                                break;
                            case "2":
                                return '<i class="fa fa-check-square-o">&nbsp Enviada</i>'; // Enviado //Quitar Boton y que diga enviado
                                break;
                            case "3":
                                return '<button class=btnCancelaFactura>&nbsp Cancelar Factura</button>'; // Aceptado  //Solo cancelar // NC 
                                break;
                            case "4":
                                return '<button class=btnNC_CreateFact_Ref>&nbsp Cancelar & Reenviar</button>'; // Rechazado //NC //Nueva con referencia Confeccion de Factura  // BTNCancelar y enviar
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
        ]
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


        $.ajax({
            type: "POST",
            url: "class/productoXFactura.php",
            data: {
                action: "ReadByIdFactura",
                id: id.id
            }
        })
            .done(function (e) {
                distribucionCancelada.drawFactDetail(e);
            });
    };

    CargaListaDistribucionRango(){
        var referenciaCircular = distribucionCancelada.tb_distribucionCanceladas;
        distribucionCancelada.tb_distribucionCanceladas = [];
        $.ajax({
            type: "POST",
            url: "class/Distribucion.php",
            data: {
                action: "ReadCancelada",
                obj: JSON.stringify(distribucionCancelada)
            }
        })
            .done(function (e) {
                distribucionCancelada.tb_distribucionCanceladas = referenciaCircular;        
                distribucionCancelada.drawFac(e); 
            });
    };

    CargaMisFacturasRango(){
        var referenciaCircular = distribucionCancelada.tb_distribucionCanceladas;
        distribucionCancelada.tb_distribucionCanceladas = [];
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadAllbyRangeUser",
                obj: JSON.stringify(distribucionCancelada)
            }
        })
            .done(function (e) {
                distribucionCancelada.tb_distribucionCanceladas = referenciaCircular;        
                distribucionCancelada.drawFac(e); 
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
        location.href = "/TicketFacturacion.html";
    };
}
//Class Instance
let distribucionCancelada = new DistribucionCancelada();

$('#tb_distribucionCanceladas tbody').on('click', 'td', function () {
    if (this.textContent == ("Cancelar Factura"))
        return false;
    distribucionCancelada.ReadbyID(distribucionCancelada.tb_distribucionCanceladas.row(this).data());
    var dtTable = $('#tb_distribucionCanceladas').DataTable();
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