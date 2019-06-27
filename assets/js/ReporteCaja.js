class ReporteCaja {
    // Constructor
    constructor(facturas, factDetalle, fechaInicial, fechaFinal, respuesta, dataFactura) {
        this.facturas = facturas || new Array();
        this.factDetalle = factDetalle || new Array();
        this.fechaInicial = fechaInicial || "";
        this.fechaFinal = fechaFinal || "";
        this.respuesta = respuesta || "";
        this.dataFactura = dataFactura || new Array();
    };

    get ReadAll() {
        $.ajax({
            type: "POST",
            url: "class/ReporteCaja.php",
            data: {
                action: "ReadAll",
                obj: JSON.stringify(reporteCaja)
            }
        })
            .done(function (e) {
                if (e != " ") {
                    reporteCaja.drawCajas(e);
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

    drawCajas(e){
        var dataCajas = JSON.parse(e);
        
        var tb_ReporteCajas = $('#tb_ReporteCajas').DataTable({
            data: dataCajas,
            responsive: true,
            destroy: true,
            order: [2, "desc"],
            dom: 'Bfrtip',
            bLengthChange : false,
            buttons: [
                {
                    extend: 'excelHtml5',
                    messageTop:'Movimientos de Cajas',
                    footer: true,
                    exportOptions: {
                        columns: [1,2, 4, 5, 6, 7, 8]
                    }
                },
                {
                    extend: 'pdfHtml5',
                    messageTop:'Movimientos de Cajas',
                    orientation : 'landscape',
                    footer: true,
                    exportOptions: {
                        columns: [1,2, 4, 5, 6, 7, 8]
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
            // columnDefs: [{ className: "text-right", "targets": [6] }, 
            //              { className: "text-right", "targets": [7] }, 
            //              { className: "text-right", "targets": [8] }, 
            //              { className: "text-right", "targets": [9] }, 
            //              { className: "text-right", "targets": [12] }],

            columns: [
                {
                    title: "ID BODEGA",
                    data: "idBodega",
                    visible: false
                },
                {
                    title: "Bodega",
                    data: "bodegaNombre",
                    "searchable": true
                },
                {
                    title: "Fecha",
                    data: "aperturaCaja",
                    "searchable": true
                },
                {
                    title: "Apertura",
                    data: "montoApertura",
                    "searchable": true,
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "Cierre",
                    data: "montoCierre",
                    "searchable": true,
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "Ventas Efectivo",
                    data: "ventasEfectivo",
                    "searchable": true,
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "Ventas Tarjeta",
                    data: "ventasTarjeta",
                    "searchable": true,
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "Total Venta",
                    data: "montoApertura",
                    mRender: function (e) {
                        return '¢' + parseFloat(Number(e)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "TOTAL VENTAS",
                    render: function (data, type, row, meta) {
                        var efectivo = 0;
                        var tarjeta = 0;
                        if(row['ventasEfectivo']==null)
                            efectivo = 0;
                        else
                            efectivo = parseFloat(row['ventasEfectivo']);
                        if(row['ventasTarjeta']==null)
                            tarjeta=0;
                        else
                            tarjeta = parseFloat(row['ventasTarjeta']);
                        return '¢' + parseFloat(Number(efectivo + tarjeta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                }
            ]
        });
    }

    ticketPrintRePrint(lsRowCierre){
        localStorage.setItem("lsTituloPrintCierre","CIERRE DE CAJA DIARIO");
        localStorage.setItem("lsCierreDiario","YES");
        var row = JSON.parse(lsRowCierre);
        var apertura = row.montoApertura;
        var efectivo = row.ventasEfectivo;
        if(efectivo==null)efectivo=0;
        var tarjeta = row.ventasTarjeta;
        if(tarjeta==null)tarjeta=0;
        var totalventas = parseFloat(efectivo) + parseFloat(tarjeta);
        var totalneto = parseFloat(efectivo) + parseFloat(tarjeta) + parseFloat(apertura);
        localStorage.setItem("lsUsuario","");
        localStorage.setItem("lsBodega", bodega.nombre);
        localStorage.setItem("lsFecha",row.fechaApertura);
        localStorage.setItem("lsApertura",'¢' + parseFloat(Number(apertura)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        localStorage.setItem("lsEfectivo",'¢' + parseFloat(Number(efectivo)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        localStorage.setItem("lsTarjeta",'¢' + parseFloat(Number(tarjeta)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        localStorage.setItem("lsTotalVentas",'¢' + parseFloat(Number(totalventas)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        localStorage.setItem("lsTotalNeto",'¢' + parseFloat(Number(totalneto)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        location.href ="/Tropical/TicketCierreCaja.html";
    }
}
//Class Instance
let reporteCaja = new ReporteCaja();