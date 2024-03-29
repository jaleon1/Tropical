class Insumo {
    // Constructor
    constructor(id, codigo, nombre, descripcion, saldoCantidad, saldoCosto, costoPromedio, tablainsumo, fechaInicial, fechaFinal) {
        this.id = id || null;
        this.codigo = codigo || '';
        this.nombre = nombre || '';
        this.descripcion = descripcion || '';
        this.saldoCantidad = saldoCantidad || 0;
        this.saldoCosto = saldoCosto || 0;
        this.costoPromedio = costoPromedio || 0;
        this.tablainsumo = tablainsumo || [];
        this.fechaInicial = fechaInicial || "";
        this.fechaFinal = fechaFinal || "";
    }

    //Getter
    get Read() {
        var miAccion = this.id == null ? 'ReadAll' : 'Read';
        if (document.URL.indexOf("OrdenSalida.html") != -1)
            miAccion = 'ReadSaldoPositivo';
        if (miAccion == 'ReadAll' && $('#tableBody-Insumo').length == 0)
            return;
        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                insumo.Reload(e);
            })
            .fail(function (e) {
                insumo.showError(e);
            });
    }

    get Save() {
        $('#btnInsumo').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.codigo = $("#codigo").val();
        this.nombre = $("#nombre").val();
        this.descripcion = $("#descripcion").val();
        this.saldoCantidad = $("#saldoCantidad").val();
        this.saldoCosto = $("#saldoCosto").val();
        this.costoPromedio = $("#costoPromedio").val();

        var z = this.tablainsumo;
        this.tablainsumo = [];

        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function (e) {
                this.tablainsumo = z;
                insumo.showInfo();
            })
            .fail(function (e) {
                insumo.showError(e);
            })
            .always(function () {
                $("#btnInsumo").removeAttr("disabled");
                insumo = new Insumo();
                insumo.ClearCtls();
                insumo.Read;
                $("#nombre").focus();
                insumo.ValorDefault();
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
            data: {
                action: 'Delete',
                id: this.id
            }
        })
            .done(function (e) {
                var data = JSON.parse(e);
                if (data == 0)
                    swal({
                        type: 'success',
                        title: 'Eliminado!',
                        showConfirmButton: false,
                        timer: 1000
                    });
                else if (data.status == 1) {
                    swal({
                        type: 'error',
                        title: 'No es posible eliminar...',
                        text: 'El registro que intenta eliminar ya se ecnuentra liquidado'
                    });
                }
                else {
                    swal({
                        type: 'error',
                        title: 'Ha ocurrido un error...',
                        text: 'El registro no ha sido eliminado',
                        footer: '<a href>Contacte a Soporte Técnico</a>',
                    })
                }
            })
            .fail(function (e) {
                insumo.showError(e);
            })
            .always(function () {
                insumo = new Insumo();
                insumo.Read;
            });
    }

    //Getter
    get ReadInventarioInsumo() {
        var miAccion = this.id == null ? 'ReadAllInventario' : 'ReadbyInsumo';
        if (miAccion == 'ReadAll' && $('#tableBody-InsumoReporte').length == 0)
            return;
        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                insumo.ShowAllInventario(e);
            })
            .fail(function (e) {
                insumo.showError(e);
            });
    }

    CargaInsumoRango(){
        var referenciaCircular = insumo.tablainsumo;
        insumo.tablainsumo = [];
        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
            data: {
                action: "ReadAllbyRange",
                obj: JSON.stringify(insumo)
            }
        })
            .done(function (e) {
                insumo.tablainsumo = referenciaCircular;        
                insumo.ShowAllInventario(e); 
            });
    };

    // Methods    
    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    // Muestra información en ventana
    showInfo() {
        //$(".modal").css({ display: "none" });   
        $(".close").click();
        swal({

            type: 'success',
            title: 'Listo!',
            showConfirmButton: false,
            timer: 1000
        });
    };

    // Muestra errores en ventana
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

    ClearCtls() {
        $("#id").val('');
        $("#codigo").val('');
        $("#nombre").val('');
        $("#descripcion").val('');
        $("#saldoCantidad").val('0');
        $("#saldoCosto").val('0');
        $("#costoPromedio").val('0');
    };

    ShowAll(e) {
        //Crea los eventos según sea el url
        var t = $('#dsInsumo').DataTable();
        if (t.rows().count() == 0) {
            t.clear();
            t.rows.add(JSON.parse(e));
            t.draw();
            $(document).on('click', '#dsInsumo tbody tr', document.URL.indexOf("OrdenSalida.html") != -1 ? insumo.AddInsumo : insumo.UpdateEventHandler);
            $(document).on('click', '.delete', insumo.DeleteEventHandler);
        } else {
            t.clear();
            t.rows.add(JSON.parse(e));
            t.draw();
        }
    };

    ShowAllInventario(e) {
        //Crea los eventos según sea el url
        var t = $('#dsInsumoReporte').DataTable();
        if (t.rows().count() == 0) {
            t.clear();
            t.rows.add(JSON.parse(e));
            t.draw();
        } else {
            t.clear();
            t.rows.add(JSON.parse(e));
            t.draw();
        }
    };

    ReadbyCode(cod) {
        if (cod != "") {
            insumo.codigo = cod;  //Columna 0 de la fila seleccionda= ID.
            //
            $.ajax({
                type: "POST",
                url: "class/Insumo.php",
                data: {
                    action: "ReadByCode",
                    obj: JSON.stringify(insumo)
                }
            })
                .done(function (e) {
                    insumo.ValidateInsumoFac(e);
                })
                .fail(function (e) {
                    insumo.showError(e);
                });
        }
    };

    ValidateInsumoFac(e) {
        //compara si el articulo ya existe
        // carga lista con datos.
        if (e == "[]") {
            swal({
                type: 'warning',
                title: 'Orden de Compra',
                text: 'El item ' + insumo.codigo + ' No existe.',
                showConfirmButton: false,
                timer: 3000
            });
            return;
        }
        if (e != "false" && e != '') {
            var data = JSON.parse(e)[0];
            insumo.id = data.id;
            insumo.codigo = data.codigo;
            insumo.nombre = data.nombre;
            insumo.descripcion = data.descripcion;
            insumo.saldoCantidad= data.saldoCantidad;
            insumo.costoPromedio= data.costoPromedio;
            var repetido = false;
            //
            if (document.getElementById("tInsumo").rows.length != 0 && insumo != null) {
                $(document.getElementById("tInsumo").rows).each(function (i, item) {
                    if (item.childNodes[0].innerText == insumo.id) {
                        repetido = true;
                        swal({
                            type: 'warning',
                            title: 'Orden de Compra',
                            text: 'El item ' + insumo.codigo + ' ya se encuentra en la lista',
                            showConfirmButton: false,
                            timer: 3000
                        });
                    }
                });
            }
            if (repetido == false) {
                // showDataProducto(e);
                insumo.agregarItem();
                //insumo.ResetSearch();
                $("#p_searhInsumo").val('');
            }
        }
    };

    agregarItem() {
        if(insumo.saldoCantidad<=0){
            swal({
                type: 'warning',
                title: 'Merma',
                text: 'El item ' + insumo.codigo + ' no tiene cantidad disponible.',
                showConfirmButton: false,
                timer: 3000
            });
            return false;
        }
        var rowNode= ti.row.add(insumo)
            .draw() //dibuja la tabla con el nuevo insumo
            .node();
        //
        $('td:eq(3) input', rowNode).attr({id: ("prec_"+insumo.codigo), max:  insumo.saldoCantidad, min: "1", step:"1", value:"1" }).on('keyup keypress mouseup', function(e){
              if(parseFloat($(this).attr('max')) < parseFloat($(this).val())){
                 swal({
                    type: 'warning',
                    title: 'Saldo Insuficiente',
                    text: 'El producto contiene unicamente '+ producto.saldoCantidad +' unidades',
                    showConfirmButton: false,
                    timer: 3000
                });
                $(this).val(producto.saldoCantidad);
              }
        });
    };

    DeleteInsumoMerma(e){        
        ti.row( $(e).parents('tr') )
        .remove()
        .draw();  
    }

    setTableOrdenSalida() {
        this.tablainsumo = $('#dsInsumo').DataTable({
            responsive: true,
            destroy: true,
            order: [[1, "asc"]],
            columnDefs: [{ className: "text-right", "targets": [4] }],
            columns: [
                {
                    title: "ID",
                    data: "id",
                    className: "itemId",
                    searchable: false
                },
                {
                    title: "CODIGO",
                    data: "codigo"
                },
                {
                    title: "NOMBRE",
                    data: "nombre"
                },
                {
                    title: "DESCRIPCION",
                    data: "descripcion"
                },
                {
                    title: "SALDO CANTIDAD",
                    data: "saldoCantidad"
                },
                {
                    title: "SALDO COSTO",
                    data: "saldoCosto",
                    className: "oculto_saldoCosto",
                    visible: false
                },
                {
                    title: "COSTO PROMEDIO",
                    data: "costoPromedio",
                    className: "oculto_costoPromedio",
                    visible: false
                },
                {
                    title: "ACCIÓN",
                    orderable: false,
                    searchable: false,
                    mRender: function () {
                        return '<a class="update"> <i class="glyphicon glyphicon-edit" > </i> Editar </a> | ' +
                            '<a class="delete"> <i class="glyphicon glyphicon-trash"> </i> </a>'
                    },
                    visible: false
                }
            ]
        });
    };

    setTableInventarioInsumo(){
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
        
        this.tablainsumo = $('#dsInsumo').DataTable( {
            responsive: true,
            destroy: true,
            order: [[1, "asc"]],
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    exportOptions: {columns: [ 1, 2, 3, 4, 5, 6]},
                    messageTop:'Inventario Materia Prima'
                },
                {
                    extend: 'pdfHtml5',
                    messageTop:'Inventario Materia Prima',
                    exportOptions: {
                        columns: [ 1, 2, 3, 4, 5, 6]
                    }
                }
            ],
            language: {
                "infoEmpty": "Sin Insumos Registrados",
                "emptyTable": "Sin Insumos Registrados",
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
            columnDefs: [{ className: "text-right", "targets": [4, 5, 6] }],
            columns: [
                {
                    title: "ID",
                    data: "id",
                    className: "itemId",
                    width: "auto",
                    searchable: false
                },
                {
                    title: "CODIGO",
                    data: "codigo",
                    width: "auto"
                },
                {
                    title: "NOMBRE",
                    data: "nombre",
                    width: "auto"
                },
                {
                    title: "DESCRIPCION",
                    data: "descripcion",
                    width: "auto"
                },
                {
                    title: "SALDO CANTIDAD",
                    data: "saldoCantidad",
                    width: "auto"
                },
                {
                    title:"SALDO COSTO",
                    data:"saldoCosto",
                    width:"auto",
                    type: 'formatted-num',
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")}},
                {
                    title:"COSTO PROMEDIO",
                    data:"costoPromedio",
                    width:"auto",
                    type: 'formatted-num',
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")}},
                {
                    title: "ACCIÓN",
                    orderable: false,
                    searchable: false,
                    className: "buttons",
                    width: "auto",
                    mRender: function () {
                        return '<a class="delete" style="cursor: pointer;"> <i class="glyphicon glyphicon-trash"> </i> </a>'
                    },
                }
            ]
        });
    };

    setTableInventarioOrdenSalida() {
        this.tablainsumo = $('#dsInsumo').DataTable({
            responsive: true,
            destroy: true,
            order: [[1, "asc"]],
            language: {
                "infoEmpty": "Sin Ordenes de Producción Registradas",
                "emptyTable": "Sin Ordenes de Producción Registradas",
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
            columnDefs: [{ className: "text-right", "targets": [4] }],
            columns: [
                {
                    title: "ID",
                    data: "id",
                    className: "itemId",
                    searchable: false
                },
                {
                    title: "CODIGO",
                    data: "codigo"
                },
                {
                    title: "NOMBRE",
                    data: "nombre"
                },
                {
                    title: "DESCRIPCION",
                    data: "descripcion"
                },
                {
                    title: "SALDO CANTIDAD",
                    data: "saldoCantidad"
                },
                {
                    title: "SALDO COSTO",
                    data: "saldoCosto",
                    className: "oculto_saldoCosto",
                    visible: false
                },
                {
                    title: "COSTO PROMEDIO",
                    data: "costoPromedio",
                    className: "oculto_costoPromedio",
                    visible: false
                },
                {
                    title: "ACCIÓN",
                    orderable: false,
                    searchable: false,
                    mRender: function () {
                        return '<a class="update"> <i class="glyphicon glyphicon-edit" > </i> Editar </a> | ' +
                            '<a class="delete"> <i class="glyphicon glyphicon-trash"> </i> </a>'
                    },
                    visible: false
                }
            ]
        });
    }

    setTableMerma() {
        ti = $('#tInsumo').DataTable({
            responsive: true,
            destroy: true,
            order: [[1, "asc"]],
            language: {
                "infoEmpty": "Sin Registros",
                "emptyTable": "Sin Registros",
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
                    title: "Id",
                    data: "id",
                    className: "itemId",
                    searchable: false,
                    width: "auto"
                },
                {
                    title: "CODIGO",
                    data: "codigo",
                    width: "auto"
                },
                {
                    title: "Insumo",
                    data: "nombre",
                    width: "auto"
                },
                {
                    title:"Costo Promedio",
                    data:"costoPromedio",
                    className:"itemId",
                    width:"auto"
                },
                {//cant.
                    title: "CANTIDAD",
                    "width": "15%",
                    "data": null,
                    "defaultContent": '<input class="cantidad form-control" min="1" max="9999999999" step="1" style="text-align:right;"  type="number" value=1>'
                },
                {//descr.
                    title:"Observaciones",
                    "width": "30%", 
                    "data": null,
                    "defaultContent": '<input class="cantidad form-control" type="text">'
                },
                {
                    title: "Acción",
                    orderable: false,
                    searchable: false,
                    mRender: function () {
                        return '<a class="delete" style="cursor: pointer;" onclick="insumo.DeleteInsumoMerma(this)" > <i class="glyphicon glyphicon-trash"> </i></a>'
                    },
                    visible: true
                }
            ]
        });
    };

    setTableInventarioInsumoReporte(){
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
        
        this.tablainsumo = $('#dsInsumoReporte').DataTable( {
            responsive: true,
            destroy: true,
            order: [1, "desc"],
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    exportOptions: {columns: [ 1, 3, 5, 7, 9, 10, 11, 12, 13, 14, 15 ]},
                    messageTop:'Movimientos de Materia Prima'
                },
                {
                    extend: 'pdfHtml5',
                    orientation : 'landscape',
                    exportOptions: {columns: [ 1, 3, 5, 7, 9, 10, 11, 12, 13, 14, 15 ]}
                }
            ],
            language: {
                "infoEmpty": "Sin movimientos de Materia Prima",
                "emptyTable": "Sin movimientos de Materia Prima",
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
            columns: [
                {
                    title: "ID",
                    data: "id",
                    className: "itemId",
                    width: "auto",
                    searchable: false
                },
                {
                    title: "FECHA",
                    data: "fecha",
                    width: "auto"
                },
                {
                    title: "ORDEN COMPRA",
                    data: "idOrdenCompra",
                    visible: false
                },
                {
                    title: "ENTRADA",
                    data: "ordenEntrada",
                    width: "auto"
                },
                {
                    title: "ORDEN SALIDA",
                    data: "idOrdenSalida",
                    visible: false
                },
                {
                    title: "SALIDA",
                    data: "ordenSalida",
                    width: "auto"
                },
                {
                    title: "ID INSUMO",
                    data: "idInsumo",
                    visible: false
                },
                {
                    title: "INSUMO",
                    data: "insumo",
                    width: "auto"
                },
                {
                    title: "ENTRADA",
                    data: "entrada",
                    width: "auto",
                    mRender: function ( e ) {
                        if (e==null) 
                            return '0'
                        else
                            return e}
                },
                {
                    title: "SALIDA",
                    data: "salida",
                    width: "auto",
                    mRender: function ( e ) {
                        if (e==null) 
                            return '0'
                        else
                            return e}
                },
                {
                    title: "SALDO",
                    data: "saldo",
                    width: "auto"
                },
                {
                    title: "COSTO ADQUISICION",
                    data: "costoAdquisicion",
                    width: "auto",
                    type: 'formatted-num',
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'
                        else
                            return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")}
                },
                {
                    title:"VALOR ENTRADA",
                    data:"valorEntrada",
                    width:"auto",
                    type: 'formatted-num',
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'
                        else
                            return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")}
                },
                {
                    title:"VALOR SALIDA",
                    data:"valorSalida",
                    width:"auto",
                    type: 'formatted-num',
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'
                        else
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")}
                },
                {
                    title:"VALOR SALDO",
                    data:"valorSaldo",
                    width:"auto",
                    type: 'formatted-num',
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'
                        else
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")}
                },
                {
                    title:"COSTO PROMEDIO",
                    data:"costoPromedio",
                    width:"auto",
                    type: 'formatted-num',
                    mRender: function ( e ) {
                        if (e==null) 
                            return '¢0'
                        else
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")}
                }
            ]
        });
    };

    AddInsumo() {
        var id = $(this).find("td:eq(0)").html();
        var codigo = $(this).find("td:eq(1)").html();
        var nombre = $(this).find("td:eq(2)").html();
        var descripcion = $(this).find("td:eq(3)").html();
        var saldoCantidad = $(this).find("td:eq(4)").html();
        //Para campos ocultos
        var saldoCosto = insumo.tablainsumo.row(this).data()[5];
        var costoPromedio = insumo.tablainsumo.row(this).data()[6];
        ordenSalida.AddInsumoEventHandler(id, codigo, nombre, descripcion, saldoCantidad, saldoCosto, costoPromedio);
    };

    UpdateEventHandler() {
        insumo.id = $(this).find(".itemId").text();  //Class itemId = ID del objeto.
        insumo.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e)[0];
        $("#id").val(data.id);
        $("#codigo").val(data.codigo);
        $("#nombre").val(data.nombre);
        $("#descripcion").val(data.descripcion);
        $("#saldoCantidad").val(data.saldoCantidad);
        $("#saldoCosto").val(parseFloat(data.saldoCosto).toFixed(2));
        $("#costoPromedio").val(parseFloat(data.costoPromedio).toFixed(2));
        $(".bs-example-modal-lg").modal('toggle');
    };

    DeleteEventHandler() {
        insumo.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
        // Mensaje de borrado:
        swal({
            title: 'Eliminar?',
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
                insumo.Delete;
            }
        })
    };

    ValorDefault() {
        $("#saldoCantidad").val('0');
        $("#saldoCosto").val('0.00');
        $("#costoPromedio").val('0.00');
    }

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0]);
        $('#frmInsumo').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                insumo.Save;
            return false;
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }

        // datepicker.js
        // $('#dpfechaExpiracion').datetimepicker({
        //     format: 'DD/MM/YYYY'
        // });
    };
}

//Class Instance
let insumo = new Insumo();
var ti;