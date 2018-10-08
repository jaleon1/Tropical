class InventarioFacturas {
    // Constructor
    constructor(facturas, tb_facturas, factDetalle, tb_prdXFact) {
        this.facturas = facturas || new Array();
        this.factDetalle = factDetalle || new Array();
        this.tb_facturas = tb_facturas || null;
    };

    CargaFacturas() {
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadAll"
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
                else inventarioFacturas.drawFac(e)
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
                else inventarioFacturas.drawFac(e)
            });
    };

    drawFac(e) {
        var facturas = JSON.parse(e);
        this.tb_facturas = $('#tb_facturas').DataTable({
            data: facturas,                               
            "language": {
                "infoEmpty":  "Sin Facturas",
                "emptyTable": "Sin Facturas",
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
                    title: "ID Factura",
                    data: "id",
                    visible: false
                },
                {
                    title: "#Factura",
                    data: "consecutivo"
                },
                {
                    title: "Fecha",
                    data: "fechaCreacion"
                },
                {
                    title: "Almacen",
                    data: "nombre"
                },
                {
                    title: "Vendedor",
                    data: "userName"
                },
                {
                    title: "Monto Efectivo",
                    data: "montoEfectivo",
                    visible: false,
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'; 
                        else
                            return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                },
                {
                    title: "Monto Tarjeta",
                    data: "montoTarjeta",
                    visible: false,
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'; 
                        else
                            return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                },
                {
                    title: "Total",
                    data: "totalComprobante",
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
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
                    <label id='cajero'>${id.userName}</label>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <label>Bodega:</label>
                    <label id='bodega'>${id.nombre}</label>
                </div>
            </div>`;
        $("#detalleFac").append(detalleFac);


        $("#totalFact").empty();

        // var totalFact =
        //     `<h4>Total: ¢${Math.round(id.totalVenta)}</h4>`;
        // $("#totalFact").append(totalFact);


        $.ajax({
            type: "POST",
            url: "class/ProductoXFactura.php",
            data: {
                action: "ReadByIdFactura",
                id: id.id
            }
        })
            .done(function (e) {
                inventarioFacturas.drawFactDetail(e);
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
                    title: "Producto",
                    data: "detalle"
                },
                {
                    title: "Cantidad",
                    data: "cantidad"
                },
                {
                    title: "Precio",
                    data: "montoTotalLinea"
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

$('#tb_facturas tbody').on('click', 'tr', function () {
    inventarioFacturas.ReadbyID(inventarioFacturas.tb_facturas.row(this).data());
    var dtTable = $('#tb_facturas').DataTable();
    var efectivo=0;
    var total=0;
    efectivo = parseFloat(dtTable.row(this).data()[4]);
    total = parseFloat(dtTable.row(this).data()[3]);
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


