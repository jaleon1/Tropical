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
            // "footerCallback": function ( row, ventas, start, end, display ) {
            //     var api = this.api(), ventas;
     
            //     // Remove the formatting to get integer data for summation
            //     var intVal = function ( i ) {
            //         return typeof i === 'string' ?
            //             i.replace(/[\$,]/g, '')*1 :
            //             typeof i === 'number' ?
            //                 i : 0;
            //     };
     
            //     // Total over all pages
            //     total = api
            //         .column( 5 )
            //         .data()
            //         .reduce( function (a, b) {
            //             return intVal(a) + intVal(b);
            //         }, 0 );
     
            //     // Total over this page
            //     pageTotal = api
            //         .column( 5, { page: 'current'} )
            //         .data()
            //         .reduce( function (a, b) {
            //             return intVal(a) + intVal(b);
            //         }, 0 );
     
            //     // Update footer
            //     $( api.column( 5 ).footer() ).html(
            //         '$'+pageTotal +' ( $'+ total +' total)'
            //     );
            // },
            responsive: true,
            destroy: true,
            data: ventas,                               
            order: [[1, "desc"]],
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    exportOptions: {columns: [1, 2, 3, 4, 5]},
                    messageTop:'Reporte de Ventas'
                },
                {
                    extend: 'pdfHtml5',
                    exportOptions: {columns: [1, 2, 3, 4, 5]},
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
            ]
        });
    };

}
//Class Instance
let inventarioVentas = new InventarioVentas();
