class OrdenCompra {
    // Constructor
    constructor(id, orden, fecha, idProdveedor, idUsuario, lista, tablaOrdenCompra, fechaInicial, fechaFinal) {
        this.id = id || null;
        this.orden = orden || '';
        this.fecha = fecha || '';
        this.idProdveedor = idProdveedor || '';
        this.idUsuario = idUsuario || '';
        this.lista = lista || [];
        this.tablaOrdenCompra = tablaOrdenCompra || [];
        this.fechaInicial = fechaInicial || "";
        this.fechaFinal = fechaFinal || "";
    }

    //Getter
    get Read() {
        var miAccion = this.id == null ? 'ReadAll' : 'ReadbyOrden';
        $.ajax({
                type: "POST",
                url: "class/OrdenCompra.php",
                data: {
                    action: miAccion,
                    id: this.id
                }
            })
            .done(function (e) {
                ordenCompra.Reload(e);
            })
            .fail(function (e) {
                // ordenCompra.showError(e);
            });
    }

    get Save() {
        if ($('#orden').val() == '') {
            swal({
                type: 'warning',
                title: 'Orden de Compra',
                text: 'Debe digitar el número de factura de proveedor',
                showConfirmButton: false,
                timer: 3000
            });
            return;
        }

        if ($('#productos').length == 0) {
            swal({
                type: 'warning',
                title: 'Orden de Compra',
                text: 'Debe agregar items a la lista',
                showConfirmButton: false,
                timer: 3000
            });
            return;
        }
        //
        $('#btnOrdenCompra').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.orden = $("#orden").val();
        this.idProveedor = $("#proveedor").val();
        //
        ordenCompra.lista = [];
        $('#productos tr').each(function (i, item) {
            var objlista = new Object();
            objlista.idInsumo = $('#dsitems').dataTable().fnGetData(item)[0]; // id del item.
            objlista.esVenta = $('#dsitems').dataTable().fnGetData(item)[3]; // tipo insumo / articulo.
            objlista.costoUnitario = $(this).find('td:eq(3) input').val();
            objlista.cantidadBueno = $(this).find('td:eq(4) input').val();
            objlista.cantidadMalo = $(this).find('td:eq(5) input').val();
            objlista.valorBueno = $(this).find('td:eq(6) input.valor').val();
            objlista.valorMalo = $(this).find('td:eq(7) input.valor').val();
            ordenCompra.lista.push(objlista);
        });
        $.ajax({
                type: "POST",
                url: "class/OrdenCompra.php",
                data: {
                    action: miAccion,
                    obj: JSON.stringify(this)
                }
            })
            .done(ordenCompra.showInfo)
            .fail(function (e) {
                ordenCompra.showError(e);
            })
            .always(function () {
                $("#btnOrdenCompra").removeAttr("disabled");
                ordenCompra = new OrdenCompra();
                ordenCompra.CleanCtls();
                $("#p_searh").focus();
            });
    };

    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    ShowAll(e) {
        //Crea los eventos según sea el url
        var t = $('#dsOrdenCompra').DataTable();
        if (t.rows().count() == 0) {
            t.clear();
            t.rows.add(JSON.parse(e));
            t.draw();
            $(document).on('click', '#dsOrdenCompra tbody tr td:not(.buttons)', ordenCompra.SelectEventHandler);
        } else {
            t.clear();
            t.rows.add(JSON.parse(e));
            t.draw();
        }
    };

    ShowItemData(e) {
        //Crea los eventos según sea el url
        var t = $('#dsInsumoOrdenCompra').DataTable();
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

    SelectEventHandler() {
        ordenCompra.id = $(this).parents("tr").find(".itemId").text() || $(this).find(".itemId").text();
        var fecha = $(this).parents('tr').find('td:eq(1)').html();
        var usuario = $(this).parents('tr').find('td:eq(3)').html();
        var orden = $(this).parents('tr').find('td:eq(2)').html();
        ordenCompra.setTableInsumoOrdenCompra(orden, usuario, fecha);
        ordenCompra.Read;
        $(".bs-ordenCompra-modal-lg").modal('toggle');
    };

    setTableOrdenCompra() {
        jQuery.extend(jQuery.fn.dataTableExt.oSort, {
            "formatted-num-pre": function (a) {
                a = (a === "-" || a === "") ? 0 : a.replace(/[^\d\-\.]/g, "");
                return parseFloat(a);
            },
            "formatted-num-asc": function (a, b) {
                return a - b;
            },
            "formatted-num-desc": function (a, b) {
                return b - a;
            }
        });

        this.tablaOrdenCompra = $('#dsOrdenCompra').DataTable({
            responsive: true,
            destroy: true,
            order: [1, "desc"],
            dom: 'Bfrtip',
            buttons: [{
                    extend: 'excelHtml5',
                    exportOptions: {
                        columns: [1, 2, 3]
                    },
                    messageTop: 'Reporte Orden de Compra'
                },
                {
                    extend: 'pdfHtml5',
                    exportOptions: {
                        columns: [1, 2, 3]
                    },
                    messageTop: 'Reporte Orden de Compra',
                    customize: function (doc) {
                        doc.defaultStyle.alignment = 'right';
                        doc.styles.tableHeader.alignment = 'right';
                    }
                }
            ],
            language: {
                "infoEmpty": "Sin Ordenes de Compra",
                "emptyTable": "Sin Ordenes de Compra",
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
                    data: "usuario"
                },
                {
                    title: "ACCION",
                    orderable: false,
                    searchable: false,
                    mRender: function () {
                        return '<a class="delete buttons" style="cursor: pointer;" onclick="ordenCompra.DeleteOrdenCompra(this)" > <i class="glyphicon glyphicon-trash"> </i></a>'
                    },
                    visible: true
                }
            ]
        });
    };

    setTableInsumoOrdenCompra(orden, usuario, fecha) {
        jQuery.extend(jQuery.fn.dataTableExt.oSort, {
            "formatted-num-pre": function (a) {
                a = (a === "-" || a === "") ? 0 : a.replace(/[^\d\-\.]/g, "");
                return parseFloat(a);
            },
            "formatted-num-asc": function (a, b) {
                return a - b;
            },
            "formatted-num-desc": function (a, b) {
                return b - a;
            }
        });

        this.tablaOrdenCompra = $('#dsInsumoOrdenCompra').DataTable({
            responsive: true,
            destroy: true,
            order: [
                [3, "asc"]
            ],
            dom: 'Bfrtip',
            buttons: [{
                    extend: 'excelHtml5',
                    footer: true,
                    exportOptions: {
                        columns: [1, 2, 3, 4, 5, 6, 7, 8]
                    },
                    messageTop: 'FECHA:  ' + fecha + '  ORDEN:  ' + orden,
                    messageBottom: 'USUARIO:  ' + usuario,
                },
                {
                    extend: 'pdfHtml5',
                    footer: true,
                    exportOptions: {
                        columns: [1, 2, 3, 4, 5, 6, 7, 8]
                    },
                    messageTop: 'FECHA:  ' + fecha + '  ORDEN:  ' + orden,
                    messageBottom: 'USUARIO:  ' + usuario,
                }
            ],
            columnDefs: [{
                className: "text-right",
                "targets": [3, 4, 5, 6, 7, 8]
            }],
            language: {
                "infoEmpty": "Sin Insumos",
                "emptyTable": "Sin Insumos",
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
                    title: "CODIGO",
                    data: "codigo",
                    width: "auto"
                },
                {
                    title: "INSUMO",
                    data: "insumo",
                    width: "auto"
                },
                {
                    title: "COSTO UNITARIO",
                    data: "costoUnitario",
                    width: "auto",
                    type: 'formatted-num',
                    mRender: function (e) {
                        return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "BUENO",
                    data: "cantidadBueno",
                    width: "auto"
                },
                {
                    title: "MALO",
                    data: "cantidadMalo",
                    width: "auto"
                },
                {
                    title: "VALOR BUENO",
                    data: "valorBueno",
                    width: "auto",
                    type: 'formatted-num',
                    mRender: function (e) {
                        return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "VALOR MALO",
                    data: "valorMalo",
                    width: "auto",
                    type: 'formatted-num',
                    mRender: function (e) {
                        return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                    }
                },
                {
                    title: "SUBTOTAL",
                    data: "subtotal",
                    width: "auto",
                    type: 'formatted-num',
                    mRender: function (e) {
                        return '¢' + parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
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
                var totalCantidadBueno = display.map(el => data[el][5]).reduce((a, b) => intVal(a) + intVal(b), 0);
                var totalCantidadMalo = display.map(el => data[el][6]).reduce((a, b) => intVal(a) + intVal(b), 0);
                var totalBueno = display.map(el => data[el][7]).reduce((a, b) => intVal(a) + intVal(b), 0);
                var totalMalo = display.map(el => data[el][8]).reduce((a, b) => intVal(a) + intVal(b), 0);
                var subTotal = display.map(el => data[el]['subtotal']).reduce((a, b) => intVal(a) + intVal(b), 0);

                // Actualiza el footer
                $(api.column(1).footer()).html("TOTALES");
                $(api.column(4).footer()).html(totalCantidadBueno);
                $(api.column(5).footer()).html(totalCantidadMalo);
                $(api.column(6).footer()).html('¢' + parseFloat(Number(totalBueno)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                $(api.column(7).footer()).html('¢' + parseFloat(Number(totalMalo)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                $(api.column(8).footer()).html('¢' + parseFloat(Number(subTotal)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            }
        });
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

    LoadInsumo() {
        if ($("#p_searh").val() != "") {
            insumo.codigo = $("#p_searh").val(); //Columna 0 de la fila seleccionda= ID.
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
                    ordenCompra.ValidateInsumoFac(e);
                })
                .fail(function (e) {
                    ordenCompra.showError(e);
                });
        }
    };

    LoadArticulo() {
        if ($("#p_searh").val() != "") {
            producto.codigo = $("#p_searh").val();
            //
            $.ajax({
                    type: "POST",
                    url: "class/Producto.php",
                    data: {
                        action: "ReadArticuloByCode",
                        obj: JSON.stringify(producto)
                    }
                })
                .done(function (e) {
                    ordenCompra.ResetSearch();
                    ordenCompra.ValidateInsumoFac(e);
                })
                .fail(function (e) {
                    ordenCompra.showError(e);
                });
        }
    };

    // valida que el insumo nuevo a ingresar no este en la lista
    // si esta en la lista lo suma a la cantidad
    // si es nuevo lo agrega a la lista
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
            insumo = JSON.parse(e)[0];
            insumo.UltPrd = insumo.codigo;
            var repetido = false;
            //
            if (document.getElementById("productos").rows.length != 0 && insumo != null) {
                $(document.getElementById("productos").rows).each(function (i, item) {
                    if (item.childNodes[0].innerText == insumo.codigo) {
                        //item.childNodes[3].childNodes["0"].attributes[3].value = producto.cantidad;
                        //var CantAct = parseInt(item.childNodes[3].firstElementChild.value);
                        //if (parseInt(producto.cantidad) > CantAct ){
                        //    item.childNodes[3].firstElementChild.value = parseFloat(item.childNodes[3].firstElementChild.value) + 1;
                        //}
                        // else{
                        //     // alert("No hay mas de este producto");
                        //     alertSwal(producto.cantidad)
                        //     // $("#cant_"+ producto.UltPrd).val($("#cant_"+ producto.UltPrd)[0].attributes[3].value); 
                        //     $("#cant_"+ producto.UltPrd).val(producto.cantidad);
                        // }
                        repetido = true;
                        swal({
                            type: 'warning',
                            title: 'Orden de Compra',
                            text: 'El item ' + producto.codigo + ' ya se encuentra en la lista',
                            showConfirmButton: false,
                            timer: 3000
                        });

                    }
                });
            }
            if (repetido == false) {
                // showDataProducto(e);
                ordenCompra.AgregaInsumo();
                ordenCompra.ResetSearch();
            }
        } else {
            ordenCompra.LoadArticulo();
        }
    };

    ValidateArticuloFac(e) {
        //compara si el articulo ya existe
        // carga lista con datos.
        if (e != "false") {
            producto = JSON.parse(e)[0];
            producto.UltPrd = producto.codigo;
            var repetido = false;

            if (document.getElementById("productos").rows.length != 0 && producto != null) {
                $(document.getElementById("productos").rows).each(function (i, item) {
                    if (item.childNodes[0].innerText == producto.codigo) {
                        item.childNodes[3].childNodes["0"].attributes[3].value = producto.cantidad;
                        var CantAct = parseInt(item.childNodes[3].firstElementChild.value);
                        if (parseInt(producto.cantidad) > CantAct) {
                            item.childNodes[3].firstElementChild.value = parseFloat(item.childNodes[3].firstElementChild.value) + 1;
                        }
                        // else{
                        //     // alert("No hay mas de este producto");
                        //     alertSwal(producto.cantidad)
                        //     // $("#cant_"+ producto.UltPrd).val($("#cant_"+ producto.UltPrd)[0].attributes[3].value); 
                        //     $("#cant_"+ producto.UltPrd).val(producto.cantidad);
                        // }
                        repetido = true;

                    }
                });
            }
            if (repetido == false) {
                // showDataProducto(e);
                ordenCompra.AgregaInsumo();
                ordenCompra.ResetSearch();
            }
        } else {
            ordenCompra.ResetSearch();
        }
    };

    CleanCtls() {
        $("#p_searh").val('');
        $('#proveedor').val("");
        $('#orden').val("");
        $('#productos').html("");
        t.clear();
    };

    ResetSearch() {
        $("#p_searh").val('');
    };

    //Agrega el insumo a la factura
    AgregaInsumo() {
        //insumo.UltPro = insumo.codigo;
        var rowNode =
            t //t es la tabla de insumos
            .row.add([insumo.id, insumo.codigo, insumo.nombre, insumo.esVenta || -1, "Precio Unitario", "0", "0", "0", "0", "0"])
            .draw() //dibuja la tabla con el nuevo insumo
            .node();
        //
        $('td:eq(3) input', rowNode).attr({
            id: ("prec_" + insumo.codigo),
            max: "9999999999",
            min: "0",
            step: "1",
            value: "1"
        }).change(function () {
            ordenCompra.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        });
        //
        $('td:eq(4) input', rowNode).attr({
            id: ("cantBueno_" + insumo.codigo),
            max: "9999999999",
            min: "1",
            step: "1",
            value: "1"
        }).change(function () {
            ordenCompra.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        });

        //$('td:eq(5)', rowNode).attr({id: ("cantMalo_"+insumo.codigo)});
        $('td:eq(5) input', rowNode).attr({
            id: ("cantMalo_" + insumo.codigo),
            max: "9999999999",
            min: "0",
            step: "1",
            value: "0"
        }).change(function () {
            ordenCompra.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        });
        //
        $('td:eq(6) input.valor', rowNode).attr({
            id: ("valorBueno_v" + insumo.codigo),
            style: "display:none"
        });
        $('td:eq(6) input.display', rowNode).attr({
            id: ("valorBueno_d" + insumo.codigo)
        });
        $('td:eq(7) input.valor', rowNode).attr({
            id: ("valorMalo_v" + insumo.codigo),
            style: "display:none"
        });
        $('td:eq(7) input.display', rowNode).attr({
            id: ("valorMalo_d" + insumo.codigo)
        });
        $('td:eq(8) input.valor', rowNode).attr({
            id: ("subtotal_v" + insumo.codigo),
            style: "display:none"
        });
        $('td:eq(8) input.display', rowNode).attr({
            id: ("subtotal_d" + insumo.codigo)
        });
        //t.order([0, 'desc']).draw();
        t.columns.adjust().draw();
        ordenCompra.CalcImporte(insumo.codigo);
        //calcTotal();
        //$('#open_modal_fac').attr("disabled", false);
    };

    //Calcula el nuevo importe al cambiar la cantidad del prodcuto seleccionado de forma manual y no por insumo repetido.
    CalcImporte(prd) {
        //alert('calculando');
        insumo.UltPrd = prd; //validar
        insumo.precio = $(`#prec_${prd}`).val();
        insumo.cantBueno = $(`#cantBueno_${prd}`).val();
        insumo.cantMalo = $(`#cantMalo_${prd}`).val();
        insumo.valorBueno = parseFloat(insumo.precio) * parseInt(insumo.cantBueno);
        insumo.valorMalo = parseFloat(insumo.precio) * parseInt(insumo.cantMalo);
        insumo.subTotal = insumo.valorBueno + insumo.valorMalo; // subTotal linea
        //
        $(`#valorBueno_v${prd}`).val(insumo.valorBueno.toFixed(10));
        $(`#valorBueno_d${prd}`).val("¢" + insumo.valorBueno.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        $(`#valorMalo_v${prd}`).val(insumo.valorMalo.toFixed(10));
        $(`#valorMalo_d${prd}`).val("¢" + insumo.valorMalo.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        $(`#subtotal_v${prd}`).val(insumo.subTotal.toFixed(10));
        $(`#subtotal_d${prd}`).val("¢" + insumo.subTotal.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    };

    DeleteInsumoOrdenCompra(e) {
        //var t = $('#dsitems').DataTable();
        t.row($(e).parents('tr'))
            .remove()
            .draw();
    };

    DeleteOrdenCompra(e) {
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
                ordenCompra.id= $(e).parents('tr').find(".itemId").text();
                ordenCompra.orden= $(e).parents('tr').find("td:eq(2)").text();
                $.ajax({
                        type: "POST",
                        url: "class/OrdenCompra.php",
                        data: {
                            action: 'Delete',
                            id: ordenCompra.id,
                            orden: ordenCompra.orden
                        }
                    })
                    .done(ordenCompra.showInfo)
                    .fail(function (e) {
                        ordenCompra.showError(e);
                    })
                    .always(function () {
                        //$("#btnOrdenCompra").removeAttr("disabled");
                        ordenCompra = new OrdenCompra();
                        //ordenCompra.CleanCtls();
                        //$("#p_searh").focus();
                        ordenCompra.CargaOrdenCompraRango();
                    });
            }
        })
        // t.row( $(e).parents('tr') )
        // .remove()
        // .draw();  
    }

    CargaOrdenCompraRango() {
        var referenciaCircular = ordenCompra.tablaOrdenCompra;
        ordenCompra.tablaOrdenCompra = [];
        $.ajax({
                type: "POST",
                url: "class/OrdenCompra.php",
                data: {
                    action: "ReadAllbyRange",
                    obj: JSON.stringify(ordenCompra)
                }
            })
            .done(function (e) {
                ordenCompra.tablaOrdenCompra = referenciaCircular;
                ordenCompra.ShowAll(e);
            });
    };

    Init() {
        // validator.js
        // var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms["frmProducto"]);
        // $('#frmProducto').submit(function (e) {
        //     e.preventDefault();
        //     var validatorResult = validator.checkAll(this);
        //     if (validatorResult.valid)
        //         producto.Save;
        //     return false;
        // });

        // // on form "reset" event
        // if($('#frmProducto').length > 0 )
        //     document.forms["frmProducto"].onreset = function (e) {
        //         validator.reset();
        // } 
    };
}

let ordenCompra = new OrdenCompra();