class InventarioVentas {
    constructor(tb_ventas, fechaInicial, fechaFinal) {
        this.tb_ventas = tb_ventas || [];
        this.fechaInicial = fechaInicial || "";
        this.fechaFinal = fechaFinal || "";
    }

    Carga() {
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadVentas"
            }
        })
            .done(function (e) {
                inventarioVentas.drawReporteVentas(e)
            });
    };

    CargaInventarioVentasRango() {
        var referenciaCircular = inventarioVentas.tb_ventas;
        inventarioVentas.tb_ventas = [];
        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: "ReadAllbyRangeInvVentas",
                obj: JSON.stringify(inventarioVentas)
            }
        })
            .done(function (e) {
                inventarioVentas.tb_ventas = referenciaCircular;        
                inventarioVentas.drawReporteVentas(e); 
            });
    };

    drawReporteVentas(e) {
        jQuery.extend( jQuery.fn.dataTableExt.oSort, {
            "formatted-num-pre": function ( a ) {
                a = (a === "-" || a === "") ? 0 : a.replace( /[^\d\-\.]/g, "" );
                return parseFloat( a );
            }, 
            "formatted-num-asc": function ( a, b ) {
                return a - b;
            },
            "formatted-num-desc": function ( a, b ) {
                return b - a;
            }
        } );

        var ventas = JSON.parse(e);
        this.tb_ventas = $('#tb_ventas').DataTable({
            responsive: true,
            destroy: true,
            data: ventas,                               
            order: [[1, "desc"]],
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    footer: true,
                    exportOptions: {columns: [1, 2, 3, 4, 5]},
                    messageTop:'Reporte de Ventas'
                },
                {
                    extend: 'pdfHtml5',
                    footer: true,
                    exportOptions: {columns: [1, 2, 3, 4, 5]},
                    messageTop:'Reporte de Ventas',
                    customize: function(doc) {
                        doc.defaultStyle.alignment = 'right';
                        doc.styles.tableHeader.alignment = 'right';
                    } 
                }
            ],
            language: {
                "infoEmpty":  "Sin Ventas",
                "emptyTable": "Sin Ventas",
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
            columnDefs: [{ className: "text-right", "targets": [3, 4, 5] }],
            columns: [
                {
                    title: "ID VENTAS",
                    data: "id",
                    visible: false
                },
                {
                    title: "FECHA",
                    data: "fechaCreacion"
                },
                {
                    title: "CONSECUTIVO",
                    data: "consecutivo"
                },
                {
                    title: "12 OZ",
                    data: "_12oz"
                },
                {
                    title: "08 OZ",
                    data: "_08oz"
                },
                {
                    title: "TOTAL COMPROBANTE",
                    data: "totalComprobante",
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'; 
                        else
                            return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
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
                var doceOz = display.map(el => data[el]['_12oz']).reduce((a, b) => intVal(a) + intVal(b), 0 );
                var ochoOz = display.map(el => data[el]['_08oz']).reduce((a, b) => intVal(a) + intVal(b), 0 );
                var subTotal = display.map(el => data[el]['totalComprobante']).reduce((a, b) => intVal(a) + intVal(b), 0 );
                
                // Actualiza el footer
                $( api.column( 1 ).footer() ).html("TOTALES");
                $( api.column( 3 ).footer() ).html(doceOz);
                $( api.column( 4 ).footer() ).html(ochoOz);
                $( api.column( 5 ).footer() ).html('¢' + parseFloat(Number(subTotal)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            }
        });
    };

}
//Class Instance
let inventarioVentas = new InventarioVentas();
