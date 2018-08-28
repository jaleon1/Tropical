class OrdenSalida {
    // Constructor
constructor(id, fecha, numeroOrden, idUsuarioEntrega, idUsuarioRecibe, fechaLiquida, estado, i, ic, tabla) {
        this.id = id || null;
        this.numeroOrden = numeroOrden || '';
        this.fecha = fecha || '';
        this.idUsuarioEntrega = idUsuarioEntrega || '';
        this.idUsuarioRecibe = idUsuarioRecibe || '';
        this.fechaLiquida = fechaLiquida || '';
        this.estado = estado || 0;
        this.listaInsumo = i || [];
        this.listaInsumoCantidad = ic || [];
        this.tabla;
    }

    //Getter
    get Read() {
        var miAccion = this.id == null ? 'ReadAll' : 'Read';
        if(miAccion=='ReadAll' && $('#tableBody-OrdenSalida').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/OrdenSalida.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                ordenSalida.Reload(e);
            })
            .fail(function (e) {
                ordenSalida.showError(e);
            });
    }

    get Save() {
        if ($('#tableBody-InsumosOrdenSalida tr').length == 0){
            swal({
                type: 'info',
                title: 'Debe agregar los Insumos de la Orden de Salida...'                    
            });
            return;
        }
        $('#btnOrdenSalida').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.fecha = $("#dt_fecha").val();
        // this.usuarioRecibe = ordenSalida.idUsuarioRecibe;
        this.usuarioRecibe = usuario.id;
        this.estado = 0;
        // lista de insumos
        ordenSalida.listaInsumo = [];
        $('#tableBody-InsumosOrdenSalida tr').each(function() {
            var objInsumo = new Object();
            objInsumo.id= $(this).find('td:eq(0)').html();
            objInsumo.nombreInsumo= $(this).find('td:eq(2)').html();
            objInsumo.cantidad= $(this).find('td:eq(7) input').val();
            objInsumo.costoPromedio= $(this).find('td:eq(6)').html();
            ordenSalida.listaInsumo.push(objInsumo);
        });
        $.ajax({
            type: "POST",
            url: "class/OrdenSalida.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function (e) {        
            ordenSalida.showInfo(e);
            
            })
            .fail(function (e) {
                ordenSalida.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnOrdenSalida").removeAttr("disabled")', 1000);
                ordenSalida = new OrdenSalida();
                ordenSalida.ClearCtls();
                ordenSalida.Read;
            });
    }

    get ReadbyOrden() {
        $('#orden').attr("disabled", "disabled");
        var miAccion = 'ReadbyOrden';
        this.numeroOrden= $('#p_searh').val();
        $.ajax({
            type: "POST",
            url: "class/OrdenSalida.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function (e) {
                if(e=='null')
                {
                    swal({
                        
                        type: 'warning',
                        title: 'Orden no encontrada!',
                        showConfirmButton: false,
                        timer: 1000
                    });
                }
                else{
                    ordenSalida.ShowItemData(e);
                } 
            })
            .fail(function (e) {
                distr.showError(e);
            })
            .always(function () {
                setTimeout('$("#orden").removeAttr("disabled")', 1000);
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/OrdenSalida.php",
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
                ordenSalida.showError(e);
            })
            .always(function () {
                ordenSalida = new OrdenSalida();
                ordenSalida.Read;
            });
    }

    // Methods
    UpdateCantidadProducto(){
        productobodega.idProducto = $(this).parents("tr").find("td:eq(1)").html();
        productobodega.cantidad = $(this).parents("tr").find("td:eq(5)").html();
        productobodega.idBodega = '22a80c9e-5639-11e8-8242-54ee75873a00';
        var idordensalida = $(this).parents("tr").find("td:eq(0)").html();
        productobodega.SaveCantidad(idordensalida);        
    };

    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    // Muestra información en ventana
    showInfo(e) {
        /* IMPRIMIR */
        ordenSalida.ticketPrint(e);
    };

    ticketPrint(e){
        // var data = JSON.parse(e);
        localStorage.setItem("lsNumeroOrden",e);
        localStorage.setItem("lsFechaOrdensalida",ordenSalida.fecha);
        localStorage.setItem("lsUsuarioRecibe",$("#nombre").val());
        localStorage.setItem("lsListaInsumo",JSON.stringify(this.listaInsumo));

        // location.href ="/TicketOrdenSalida.html";
        location.href ="/Tropical/TicketOrdenSalida.html";
    }

    // Muestra errores en ventana
    showError(e) {
        var data = JSON.parse(e.responseText);
        swal({
            type: 'error',
            title: 'Oops...',
            text: 'Algo no está bien (' + data.code + '): ' + data.msg,
            footer: '<a href>Contacte a Soporte Técnico</a>',
        })
    };

    ClearCtls() {
        $("#p_searh").val('');
        $("#orden").val('');
        $("#fecha").val('');
        $("#usuarioEntrega").val('');
        $("#usuarioRecibe").val('');
        $('#tableBody-InsumosOrdenSalida').html("");
    };

    ShowAll(e) {
        var t= $('#dsOrdenSalida').DataTable();
        if(t.rows().count()==0){
           t.clear();
           t.rows.add(JSON.parse(e));
           t.draw();
           
           $( document ).on( 'click', '#dsOrdenSalida tbody tr',ordenSalida.UpdateEventHandler);
           $( document ).on( 'click', '.deleteOrdenSalida',ordenSalida.DeleteEventHandler);
        }else{
           t.clear();
           t.rows.add(JSON.parse(e));
           t.draw();
        }

        // $.each(data, function (i, item) {
        //     if (item.idEstado=="0") 
        //         item.idEstado="EN PROCESO";
        //     else
        //         item.idEstado="LIQUIDADO";
        // });

        // this.tabla = $('#dsOrdenSalida').DataTable( {
        //     responsive: true,
        //     data: data,
        //     destroy: true,
        //     order: [[ 0, "desc" ]],
        //     columns: [
        //         {
        //             title:"Orden",
        //             data:"numeroOrden",
        //             "width":"auto"},
        //         {
        //             title:"ID",
        //             data:"id",
        //             className:"itemId",                    
        //             width:"auto"},
        //         {
        //             title:"ID USUARIO ENTREGA",
        //             data:"idUsuarioEntrega",
        //             visible:false},
        //         {
        //             title:"ID USUARIO RECIBE",
        //             data:"idUsuarioRecibe",
        //             visible:false},
        //         {
        //             title:"FECHA",
        //             data:"fecha",
        //             width:"auto"},
        //         {
        //             title:"ENTREGA",
        //             data:"usuarioEntrega",
        //             width:"auto"},
        //         {
        //             title:"RECIBE",
        //             data:"usuarioRecibe",
        //             width:"auto"},
        //         {
        //             title:"FECHA LIQUIDA",
        //             data:"fechaLiquida",
        //             width:"auto"},
        //         {
        //             title:"ESTADO",
        //             data:"idEstado",
        //             width:"auto"},
        //         {
        //             title:"ACCIÓN",
        //             orderable: false,
        //             searchable:false,
        //             className: 'buttons',
        //             mRender: function () {
        //                 return '<a class="deleteOrdenSalida" style="cursor: pointer;" > <i class="glyphicon glyphicon-trash"> </i> </a>' 
        //             },
        //             "width":"5%"}
        //     ]
        // });
        // $('.updateOrdenSalida').click(ordenSalida.UpdateEventHandler);
        // $('.deleteOrdenSalida').click(ordenSalida.DeleteEventHandler);
    };

    setTableOrdenSalida(){
        this.tabla = $('#dsOrdenSalida').DataTable( {
            responsive: true,
            destroy: true,
            order: [[ 0, "desc" ]],
            columns: [
                {
                    title:"Orden",
                    data:"numeroOrden",
                    "width":"auto"},
                {
                    title:"ID",
                    data:"id",
                    className:"itemId",                    
                    width:"auto"},
                {
                    title:"ID USUARIO ENTREGA",
                    data:"idUsuarioEntrega",
                    visible:false},
                {
                    title:"ID USUARIO RECIBE",
                    data:"idUsuarioRecibe",
                    visible:false},
                {
                    title:"FECHA",
                    data:"fecha",
                    width:"auto"},
                {
                    title:"ENTREGA",
                    data:"usuarioEntrega",
                    width:"auto"},
                {
                    title:"RECIBE",
                    data:"usuarioRecibe",
                    width:"auto"},
                {
                    title:"FECHA LIQUIDA",
                    data:"fechaLiquida",
                    width:"auto"},
                {
                    title:"ESTADO",
                    data:"idEstado",
                    width:"auto",
                    mRender: function ( e ) {
                        var estado="1";
                        if (e=="0") 
                            estado="EN PROCESO";
                        if (e=="1") 
                            estado="LIQUIDADO";
                        return estado
                    }},
                {
                    title:"ACCIÓN",
                    orderable: false,
                    searchable:false,
                    className: 'buttons',
                    mRender: function () {
                        return '<a class="deleteOrdenSalida" style="cursor: pointer;" > <i class="glyphicon glyphicon-trash"> </i> </a>' 
                    },
                    "width":"5%"}
            ]
        });        
    };

    AddTableInsumo(id,codigo,nombre,descripcion,saldoCantidad,saldoCosto,costoPromedio) {
        $('#tableBody-InsumosOrdenSalida').append(`
            <tr id="row"${id}> 
                <td class="itemId" >${id}</td>
                <td class=oculto>${codigo}</td>
                <td>${nombre}</td>
                <td class=oculto>${descripcion}</td>
                <td class=oculto>${saldoCantidad}</td>
                <td class=oculto>${saldoCosto}</td>
                <td class=oculto>${costoPromedio}</td>
                <td>
                    <input id="cantidadInsumo" class="form-control col-3" name="cantidadInsumo" type="text" placeholder="Cantidad de paquetes" autofocus="" value="1">
                </td>
                <td class=" last">
                    <a id ="delete_row${id}" onclick="ordenSalida.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
                </td>
            </tr>
        `);
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsInsumosOrdenSalida' ) ) {
            var table = $('#dsInsumosOrdenSalida').DataTable();
            // table.destroy();
            // $('#dsInsumosOrdenSalida').DataTable();
        }
        else 
            $('#dsInsumosOrdenSalida').DataTable( {
                columns: [
                    { "width":"0px"},
                    { "width":"0px"},
                    { "width":"35%"},
                    { "width":"0px"},
                    { "width":"0px"},
                    { "width":"0px"},
                    { "width":"0px"},
                    { "width":"35%"},
                    { "width":"30%"}
                ],          
                "paging": false,
                "ordering": false,
                "info": false,
                "searching": false,
                "scrollCollapse": true
            } );
    };

    DeleteInsumo(btn) {
        var row = btn.parentNode.parentNode;
        row.parentNode.removeChild(row);
    };

    UpdateEventHandler() {
        $('#btnOrdenSalida').attr("disabled", false);
        $('#btnAddUsuarioRecibe').attr("disabled", false);
        $('#btnAddInsumo').attr("disabled", false);
        ordenSalida.id = $(this).parents("tr").find(".itemId").text() || $(this).find(".itemId").text();
        ordenSalida.Read;     
        
        if($(this).parents("tr").find("td:eq(6)").html()=="LIQUIDADO"){              
            swal ({ 
                type: 'info',
                title: 'La orden ya ha sido liquidada, No se puede modificar...'                     
                }).then(function () { 
                    $('#btnOrdenSalida').attr("disabled", true);
                    $('#btnAddUsuarioRecibe').attr("disabled", true);
                    $('#btnAddInsumo').attr("disabled", true);
                });
        }
    };

    ShowItemData(e) {
        if(e==null && (document.URL.indexOf("ElaborarProducto.html")!=-1)){
            $("p_searh").val('');
            swal({
                type: 'info',
                title: 'La orden ya ha sido liquidada...'                    
            });
        }
        else{
            // Limpia el controles
            this.ClearCtls();
            // carga objeto.
            var data = JSON.parse(e);
            if(document.URL.indexOf("ElaborarProducto.html")!=-1)
            {
                $.each(data.listaInsumo, function (i, item) {
                    $('#tableBody-InsumosOrdenSalida').append(`
                        <tr id="row"${item.id}> 
                            <td class="itemId" >${item.idInsumo}</td>
                            <td class=oculto>${item.codigo}</td>
                            <td>${item.nombreInsumo}</td>
                            <td class=oculto>${item.descripcion}</td>
                            <td class=oculto>${item.saldoCantidad}</td>
                            <td class=oculto>${item.saldoCosto}</td>
                            <td class=oculto>${item.costoPromedio}</td>
                            <td>
                                <input id="cantidadInsumo" class="form-control col-3" name="cantidadInsumo" type="text" placeholder="Cantidad de paquetes" autofocus="" value="${item.cantidad}"readonly>
                            </td>
                        </tr>
                    `);
                    //datatable         
                    if ( $.fn.dataTable.isDataTable( '#dsInsumosOrdenSalida' ) ) {
                        var table = $('#dsInsumosOrdenSalida').DataTable();
                        // table.destroy();
                        // $('#dsInsumosOrdenSalida').DataTable();
                    }
                    else 
                        $('#dsInsumosOrdenSalida').DataTable( {
                            columns: [
                                { "width":"0px"},
                                { "width":"0px"},
                                { "width":"50%"},
                                { "width":"0px"},
                                { "width":"0px"},
                                { "width":"0px"},
                                { "width":"0px"},
                                { "width":"50%"},
                            ],          
                            "paging": false,
                            "ordering": false,
                            "info": false,
                            "searching": false
                        } );
                })
                
                // Asigna objeto a controles
                $("#orden").val(data.numeroOrden);
                $("#fecha").val(data.fecha);
                $("#usuarioEntrega").val(data.usuarioEntrega);
                $("#usuarioRecibe").val(data.usuarioRecibe);
                
                if (ordenSalida.idEstado==0) 
                    $('#estado option:contains("EN PROCESO")')
                else
                    $('#estado option:contains("LIQUIDADO")')   
            }
            if(document.URL.indexOf("InventarioOrdenSalida.html")!=-1){
                $(".bs-example-modal-lg").modal();
                $.each(data.listaInsumo, function (i, item) {
                    $('#tableBody-InsumosOrdenSalida').append(`
                        <tr id="row"${item.id}> 
                            <td class="itemId">${item.idInsumo}</td>
                            <td class=oculto>${item.codigo}</td>
                            <td>${item.nombreInsumo}</td>
                            <td class=oculto>${item.descripcion}</td>
                            <td class=oculto>${item.saldoCantidad}</td>
                            <td class=oculto>${item.saldoCosto}</td>
                            <td class=oculto>${item.costoPromedio}</td>
                            <td>
                                <input id="cantidadInsumo" class="form-control col-3" name="cantidadInsumo" type="text" placeholder="Cantidad de paquetes" autofocus="" value="${item.cantidad}">
                            </td>
                            <td class=" last">
                                <a id ="delete_row${item.id}" onclick="ordenSalida.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
                            </td>
                        </tr>
                    `);
                    //datatable         
                    if ( $.fn.dataTable.isDataTable( '#dsInsumosOrdenSalida' ) ) {
                        var table = $('#dsInsumosOrdenSalida').DataTable();
                        // table.destroy();
                        // $('#dsInsumosOrdenSalida').DataTable();
                    }
                    else 
                        $('#dsInsumosOrdenSalida').DataTable( {
                            columns: [
                                { "width":"0px"},
                                { "width":"0px"},
                                { "width":"35%"},
                                { "width":"0px"},
                                { "width":"0px"},
                                { "width":"0px"},
                                { "width":"0px"},
                                { "width":"35%"},
                                { "width":"30%"}
                            ],          
                            "paging": false,
                            "ordering": false,
                            "info": false,
                            "searching": false
                        } );
                })
                
                // Asigna objeto a controles
                this.id=data.id;
                this.idUsuarioEntrega = data.idUsuarioEntrega;
                this.idUsuarioRecibe = data.idUsuarioRecibe;
                usuario.id= data.idUsuarioRecibe;
                this.listaInsumo = data.listaInsumo;
                $("#numeroOrden").val(data.numeroOrden);
                $("#dt_fecha").val(data.fecha);
                $("#nombre").val(data.usuarioRecibe);
                // $("#usuarioRecibe").val(data.usuarioRecibe); 
                
                ordenSalida.listaInsumoCantidad = [];
                $('#tableBody-InsumosOrdenSalida tr').each(function() {
                    var objInsumo = new Object();
                    objInsumo.id= $(this).find('td:eq(0)').html();
                    objInsumo.cantidad= $(this).find('td:eq(7) input').val();
                    ordenSalida.listaInsumoCantidad.push(objInsumo);
                });
            }
        }
    };

    DeleteEventHandler() {
        ordenSalida.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                ordenSalida.Delete;
            }
        })
    };

    AddUserEventHandler(){
        $("#usuarioRecibe").val($(this).parents("tr").find("td:eq(2)").html());
        ordenSalida.idUsuarioRecibe = $(this).parents("tr").find("td:eq(1)").html();
        $('#modal-usuarioRecibe').modal('toggle');
        $("#estado").focus();
    };

    AddInsumoEventHandler(id,codigo,nombre,descripcion,saldoCantidad,saldoCosto,costoPromedio){
        var ids_insumos = [];
        $('#tableBody-InsumosOrdenSalida tr').each(function() {
            ids_insumos.push($(this).find('td:eq(0)').html());   
        });
        if (ids_insumos.length==0) {
            ordenSalida.AddTableInsumo(id,codigo,nombre,descripcion,saldoCantidad,saldoCosto,costoPromedio);
        }
        else{
            if (ids_insumos.indexOf(id)!=-1) 
                $('#chk-addinsumo'+id).attr("checked",false);
            else
                ordenSalida.AddTableInsumo(id,codigo,nombre,descripcion,saldoCantidad,saldoCosto,costoPromedio);
        }
    };

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0][0]);
        $('#frmOrdenSalida').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                ordenSalida.Save;
            return false;
        });

        $('#frmInventarioOrdenSalida').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                ordenSalida.Save;
            return false;
        });

        $('#frmInventarioProductoTemporal').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                ordenSalida.Save;
            return false;
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }
    };
}

let ordenSalida = new OrdenSalida();
