class InventarioVentas {

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
                    exportOptions: {
                        columns: [1, 2, 3, 4, 5]
                    }
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
                            return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                }
            ]
        });
    };

}
//Class Instance
let inventarioVentas = new InventarioVentas();
