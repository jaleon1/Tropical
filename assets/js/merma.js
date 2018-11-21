class Merma {
    // Constructor
    constructor(id, idItem, cantidad, descripcion, fecha, fechaInicial, fechaFinal) {
        this.id = id || null;
        this.idItem = idItem || null;
        this.cantidad = cantidad || 0;
        this.descripcion = descripcion || '';
        this.fecha = fecha || null;
        this.fechaInicial = fechaInicial || "";
        this.fechaFinal = fechaFinal || "";        
    }

    get Read() {
        NProgress.start();
        var miAccion = this.id == null ?  'ReadAll'  : 'Read';
        if(miAccion=='ReadAll' && $('#tMerma tbody').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/merma.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                merma.Reload(e);
            })
            .fail(function (e) {
                merma.showError(e);
            })
            .always(NProgress.done()); 
    };

    CargaListaMermaRango(){
        // var referenciaCircular = ordenSalida.tb_OrdenProduccion;
        // ordenSalida.tb_OrdenProduccion = [];
        $.ajax({
            type: "POST",
            url: "class/merma.php",
            data: {
                action: "ReadAllbyRange",
                obj: JSON.stringify(merma)
            }
        })
            .done(function (e) {
                // ordenSalida.tb_OrdenProduccion = referenciaCircular;        
                merma.ShowAll(e); 
            });
    };

    ReadbyCodeConsumible(cod) {
        if (cod != ""){
            merma.codigo = cod;  //Columna 0 de la fila seleccionda= ID.
            //
            $.ajax({
                type: "POST",
                url: "class/Producto.php",
                data: {
                    action: "ReadByCode",
                    obj: JSON.stringif(merma)
                }
            })
            .done(function (e) {
                merma.ValidatePrdMerma(e);
            })
            .fail(function (e) {
                merma.showError(e);
            });
        }
    };

    showError(e) {
        //$(".modal").css({ display: "none" });  
        var data = JSON.parse(e.responseText);
        swal({
            type: 'error',
            title: 'Oops...',
            text: 'Algo no está bien (' + data.code + '): ' + data.msg,
            footer: '<a href>Contacte a Soporte Técnico</a>',
        })
    };

    DeleteMerma(e){
        swal({
            title: 'Devolver Merma?',
            text: "Esta acción es irreversible!",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, eliminar!',
            cancelButtonText: 'No, cancelar!',
            confirmButtonClass: 'btn btn-success',
            cancelButtonClass: 'btn btn-danger'
        }).then((result) => {
            if (result.value) {
                merma.id = $(e).parents("tr").find("td:eq(0)").text();
                merma.idRel = $(e).parents("tr").find("td:eq(1)").text();
                merma.consecutivo = $(e).parents("tr").find("td:eq(3)").text();
                merma.cantidad = $(e).parents("tr").find("td:eq(6)").text();
                // merma.costo = $(e).find('td:eq(7) input').val();
                $.ajax({
                    type: "POST",
                    url: "class/merma.php",
                    data: {
                        action: 'rollback',
                        id: merma.id,
                        idRel: merma.idRel,
                        consecutivo: merma.consecutivo,
                        // costo: merma.costo,
                        cantidad: merma.cantidad
                    }
                })
                    .done(function () {
                        merma.showInfo();
                        // tablas.
                        t.row( $(e).parents('tr') )
                            .remove()
                            .draw();
                    })
                    .fail(function (e) {
                        merma.showError(e);
                    })
                    .always(function () {
                        // $("#btnMerma").removeAttr("disabled");
                        // $("#p_searhInsumo").focus();
                    });
            }
        })
    };

    setTable(buttons=true, nPaging=10){
        t= $('#tMerma').DataTable({
            responsive: true,
            destroy: true,
            order: [[6, "desc"]],
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    exportOptions: {columns: [ 1, 2, 3, 4, 5, 6, 7]},
                    messageTop:'Lista de Mermas'
                },
                {
                    extend: 'pdfHtml5',
                    messageTop:'Lista de Mermas',
                    exportOptions: {
                        columns: [ 1, 2, 3, 4, 5, 6, 7]
                    }
                }
            ],
            language: {
                "infoEmpty": "Sin Mermas Registradas",
                "emptyTable": "Sin Mermas Registradas",
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
            columnDefs: [{ className: "text-right", "targets": [5] }],
            columns: [
                {
                    title: "ID",
                    data: "id",
                    className: "itemId",
                    searchable: false
                },
                {
                    title: "IdRel",
                    data: "idRel",
                    className: "itemId",
                    searchable: false,
                    width: "auto"
                },
                { title: "CODIGO", data: "codigo" },
                { title: "CONSECUTIVO", data: "consecutivo" },
                { title: "NOMBRE", data: "nombre" },
                { title: "DESCRIPCION", data: "descripcion" },
                { 
                    title: "CANTIDAD", 
                    data: "cantidad"
//                     mRender: function () {
//                         return '<input class="cantidad form-control" type="number" min="1" max="9999999999" step="1" style="text-align:right;" >'
//                     }
                },
                { title: "OBSERVACIONES", data: "descripcion" },
                { 
                    title: "FECHA", 
                    data: "fecha"
                },
                {
                    title: "Acción",
                    orderable: false,
                    searchable: false,
                    mRender: function () {
                        return '<a class="delete" style="cursor: pointer;" onclick="merma.DeleteMerma(this)" > <i class="glyphicon glyphicon-trash"> </i></a>'
                    },
                    visible: true
                }
            ]
        });
    };

    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    ShowAll(e) {
        var t= $('#tMerma').DataTable();
        t.clear();
        t.rows.add(JSON.parse(e));
        $('td:eq(5)').attr({ align: "right" });   
        t.order([1, 'desc']).draw();
        //$('.delete').click(merma.DeleteEventHandler);
        //$( "#tMerma tbody tr" ).live("click", merma.viewType==undefined || merma.viewType==merma.tUpdate ? merma.UpdateEventHandler : merma.SelectEventHandler);
        //
        //$( document ).on( 'click', '.update', merma.UpdateEventHandler);
        //$( document ).on( 'click', '#tMerma tbody tr td:not(.buttons)', merma.viewType==undefined || merma.viewType==merma.tUpdate ? merma.UpdateEventHandler : merma.SelectEventHandler);
        // $( document ).on( 'click', '.delete', merma.DeleteEventHandler);
        // $( document ).on( 'click', '.open', merma.OpenEventHandler);
    };

    showInfo() {
        //$(".modal").css({ display: "none" });   
        swal({
            type: 'success',
            title: 'Listo!',
            showConfirmButton: false,
            timer: 1000
        });
    };

    crear() {
        var miAccion = "Create";
        //
        var listaok = true;
        merma.listaInsumo = [];
        $('#tInsumo tbody tr').each(function (i, item) {
            var objlista = new Object();
            objlista.idInsumo = $(item).find('td:eq(0)')[0].textContent;
            objlista.costo = $(item).find('td:eq(3)')[0].textContent
            objlista.cantidad = $(item).find('td:eq(4) input').val();
            if ($(item).find('td:eq(5) input').val() != undefined && $(item).find('td:eq(5) input').val() == '') {
                swal({
                    type: 'warning',
                    title: 'Descripción...',
                    text: 'Debe digitar la descripción de la merma'
                });
                listaok = false;
            }
            objlista.descripcion = $(item).find('td:eq(5) input').val();
            merma.listaInsumo.push(objlista);
        });
        merma.listaProducto = [];
        $('#tProducto tbody tr').each(function (i, item) {
            var objlista = new Object();
            objlista.idProducto = $(item).find('td:eq(0)')[0].textContent;
            objlista.costo = $(item).find('td:eq(3)')[0].textContent
            objlista.cantidad = $(item).find('td:eq(4) input').val();
            if ($(item).find('td:eq(5) input').val() != undefined && $(item).find('td:eq(5) input').val() == '') {
                swal({
                    type: 'warning',
                    title: 'Descripción...',
                    text: 'Debe digitar la descripción de la merma'
                });
                listaok = false;
            }
            objlista.descripcion = $(item).find('td:eq(5) input').val();
            merma.listaProducto.push(objlista);
        });
        if (!listaok)
            return false;
        if (merma.listaInsumo[0].idInsumo == 'Sin Registros') {
            merma.listaInsumo = [];
        }
        if (merma.listaProducto[0].idProducto == 'Sin Registros') {
            merma.listaProducto = [];
        }
        if (merma.listaInsumo.length == 0 && merma.listaProducto.length == 0) {
            swal({
                type: 'warning',
                title: 'Seleccionar...',
                text: 'Debe seleccionar la materia prima o productos'
            });
            return false;
        }
        $('#btnMerma').attr("disabled", "disabled");
        //
        $.ajax({
            type: "POST",
            url: "class/merma.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function () {
                merma.showInfo();
                // tablas.
                ti.rows().remove().draw();
                tp.rows().remove().draw();
            })
            .fail(function (e) {
                insumo.showError(e);
            })
            .always(function () {
                $("#btnMerma").removeAttr("disabled");
                $("#p_searhInsumo").focus();
            });

    }
}
let merma = new Merma();
var t;