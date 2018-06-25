class OrdenSalida {
    // Constructor
constructor(id, fecha, numeroorden, idusuarioentrega, idusuariorecibe, fechaliquida, estado, i) {
        this.id = id || null;
        this.numeroorden = numeroorden || '';
        this.fecha = fecha || '';
        this.idusuarioentrega = idusuarioentrega || '';
        this.idusuariorecibe = idusuariorecibe || '';
        this.fechaliquida = fechaliquida || '';
        this.estado = estado || 0;
        this.listainsumo = i || [];
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
                ordensalida.Reload(e);
            })
            .fail(function (e) {
                ordensalida.showError(e);
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
        // this.fechaliquida = $("#dt_fechaliquida").val();
        this.usuariorecibe = ordensalida.idusuariorecibe;
        this.estado = 0;
        // lista de insumos
        ordensalida.listainsumo = [];
        $('#tableBody-InsumosOrdenSalida tr').each(function() {
            var objInsumo = new Object();
            objInsumo.id= $(this).find('td:eq(0)').html();
            objInsumo.cantidad= $(this).find('td:eq(7) input').val();
            objInsumo.costopromedio= $(this).find('td:eq(6)').html();
            ordensalida.listainsumo.push(objInsumo);
        });
        $.ajax({
            type: "POST",
            url: "class/OrdenSalida.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(ordensalida.showInfo)
            .fail(function (e) {
                ordensalida.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnOrdenSalida").removeAttr("disabled")', 1000);
                ordensalida = new OrdenSalida();
                ordensalida.ClearCtls();
                ordensalida.Read;
            });
    }

    get ReadbyOrden() {
        $('#orden').attr("disabled", "disabled");
        var miAccion = 'ReadbyOrden';
        this.numeroorden= $('#p_searh').val();
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
                        position: 'top-end',
                        type: 'warning',
                        title: 'Orden no encontrada!',
                        showConfirmButton: false,
                        timer: 1000
                    });
                }
                else{
                    ordensalida.ShowItemData(e);
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
            .done(function () {
                var data = JSON.parse(e);
                if (data.status == 0)
                    swal({
                        //position: 'top-end',
                        type: 'success',
                        title: 'Eliminado!',
                        showConfirmButton: false,
                        timer: 1000
                    });
                else if (data.status == 1) {
                    swal({
                        type: 'error',
                        title: 'No es posible eliminar...',
                        text: 'El registro que intenta eliminar tiene objetos relacionados'                        
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
                ordensalida.showError(e);
            })
            .always(function () {
                ordensalida = new OrdenSalida();
                ordensalida.Read;
            });
    }

    // Methods
    UpdateCantidadProducto(){
        productobodega.idproducto = $(this).parents("tr").find("td:eq(1)").html();
        productobodega.cantidad = $(this).parents("tr").find("td:eq(5)").html();
        productobodega.idbodega = '22a80c9e-5639-11e8-8242-54ee75873a00';
        var idordensalida = $(this).parents("tr").find("td:eq(0)").html();
        productobodega.SaveCantidad(idordensalida);        
    };

    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    // Muestra información en ventana
    showInfo() {
        $(".close").click();
        swal({
            position: 'top-end',
            type: 'success',
            title: 'Good!',
            showConfirmButton: false,
            timer: 10000
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
        $("#p_searh").val('');
        $("#orden").val('');
        $("#fecha").val('');
        $("#usuarioentrega").val('');
        $("#usuariorecibe").val('');
        $('#tableBody-InsumosOrdenSalida').html("");
    };

    ShowAll(e) {
        var url;
        url = window.location.href;
        if (url.indexOf("ProductoTemporal.html")!=-1){
            // Limpia el div que contiene la tabla.
            $('#tableBody-OrdenSalida').html("");
            // // Carga lista
            var data = JSON.parse(e);
            //style="display: none"
            var estado="EN PROCESO";
            $.each(data, function (i, item) {
                if (item.idestado=="0") 
                    estado="EN PROCESO";
                else
                    estado="LIQUIDADO";
                $('#tableBody-OrdenSalida').append(`
                    <tr> 
                        <td class="a-center ">
                        <input id="chkaddordensalida${item.id}" type="checkbox" class="flat" name="table_records">
                        </td>
                        <td>${item.numeroorden}</td>
                        <td class="itemId">${item.id}</td>
                        <td class="oculto">${item.idusuarioentrega}</td>
                        <td class="oculto">${item.idusuariorecibe}</td>
                        <td>${item.fecha}</td>
                        <td>${item.usuarioentrega}</td>
                        <td>${item.usuariorecibe}</td>
                        <td>${item.fechaliquida}</td>
                        <td>${estado}</td>
                    </tr>
                `);
                $('#chkaddordensalida'+item.id).click(productotemporal.AddOrdenSalida);
            })    
        }
        else{
            // Limpia el div que contiene la tabla.
            $('#tableBody-OrdenSalida').html("");
            // // Carga lista
            var data = JSON.parse(e);
            //style="display: none"
            var estado="EN PROCESO";
            $.each(data, function (i, item) {
                if (item.idestado=="0") 
                    estado="EN PROCESO";
                else
                    estado="LIQUIDADO";
                $('#tableBody-OrdenSalida').append(`
                    <tr> 
                        <td class="a-center ">
                        <input id="chkaddordensalida${item.id}" type="checkbox" class="flat" name="table_records">
                        </td>
                        <td>${item.numeroorden}</td>
                        <td class="itemId">${item.id}</td>
                        <td class="oculto">${item.idusuarioentrega}</td>
                        <td class="oculto">${item.idusuariorecibe}</td>
                        <td>${item.fecha}</td>
                        <td>${item.usuarioentrega}</td>
                        <td>${item.usuariorecibe}</td>
                        <td>${item.fechaliquida}</td>
                        <td>${estado}</td>
                        <td class=" last">
                            <a id="update${item.id}" class="update" data-toggle="modal" data-target=".bs-example-modal-lg" > <i class="glyphicon glyphicon-edit" > </i> Editar </a> | 
                            <a id="delete${item.id}" class="delete"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>
                        </td>
                    </tr>
                `);
                $('#update'+item.id).click(ordensalida.UpdateEventHandler);
                // $('#delete'+item.id).click(ordensalida.DeleteEventHandler);
            })    
        }
    
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsOrdenSalida' ) ) {
            var table = $('#dsOrdenSalida').DataTable();

        }
        else 
            $('#dsOrdenSalida').DataTable();
    };

    AddTableInsumo(id,codigo,nombre,descripcion,saldocantidad,saldocosto,costopromedio) {
        $('#tableBody-InsumosOrdenSalida').append(`
            <tr id="row"${id}> 
                <td class="itemId" >${id}</td>
                <td class=oculto>${codigo}</td>
                <td>${nombre}</td>
                <td class=oculto>${descripcion}</td>
                <td class=oculto>${saldocantidad}</td>
                <td class=oculto>${saldocosto}</td>
                <td class=oculto>${costopromedio}</td>
                <td>
                    <input id="cantidadInsumo" class="form-control col-3" name="cantidadInsumo" type="text" placeholder="Cantidad de paquetes" autofocus="" value="1">
                </td>
                <td class=" last">
                    <a id ="delete_row${id}" onclick="ordensalida.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
                </td>
            </tr>
        `);
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsInsumosOrdenSalida' ) ) {
            var table = $('#dsInsumosOrdenSalida').DataTable();
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
    };

    DeleteInsumo(btn) {
        var row = btn.parentNode.parentNode;
        row.parentNode.removeChild(row);
    }

    UpdateEventHandler() {
        // 
        ordensalida.id = $(this).parents("tr").find(".itemId").text(); //Class itemId = ID del objeto.
        ordensalida.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e);
    
        ordensalida = new OrdenSalida(
            data.id, 
            data.numeroorden,                        
            data.fecha, 
            data.fechaliquida,                                      
            data.idusuarioentrega, 
            data.idusuariorecibe,
            data.usuarioentrega, 
            data.usuariorecibe, 
            data.idestado, 
            data.listainsumo
        );

        $.each(data.listainsumo, function (i, item) {
            $('#tableBody-InsumosOrdenSalida').append(`
                <tr id="row"${item.id}> 
                    <td class="itemId" >${item.id}</td>
                    <td class=oculto>${item.codigo}</td>
                    <td>${item.nombreinsumo}</td>
                    <td class=oculto>${item.descripcion}</td>
                    <td class=oculto>${item.saldocantidad}</td>
                    <td class=oculto>${item.saldocosto}</td>
                    <td class=oculto>${item.costopromedio}</td>
                    <td>
                        <input id="cantidadInsumo" class="form-control col-3" name="cantidadInsumo" type="text" placeholder="Cantidad de paquetes" autofocus="" value="${item.cantidad}"readonly>
                    </td>
                </tr>
            `);
            //datatable         
            if ( $.fn.dataTable.isDataTable( '#dsInsumosOrdenSalida' ) ) {
                var table = $('#dsInsumosOrdenSalida').DataTable();
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
        $("#orden").val(data.numeroorden);
        $("#fecha").val(data.fecha);
        $("#usuarioentrega").val(data.usuarioentrega);
        $("#usuariorecibe").val(data.usuariorecibe);
        if (ordensalida.idestado==0) 
            $('#estado option:contains("EN PROCESO")')
        else
            $('#estado option:contains("LIQUIDADO")')
    };

    DeleteEventHandler() {
        ordensalida.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                ordensalida.Delete;
            }
        })
    };

    AddUserEventHandler(){
        $("#usuariorecibe").val($(this).parents("tr").find("td:eq(2)").html());
        ordensalida.idusuariorecibe = $(this).parents("tr").find("td:eq(1)").html();
        $('#modal-usuariorecibe').modal('toggle');
        $("#estado").focus();
    }

    /* PENDIENTE */ 
    AddInsumoEventHandler(){
        var id=$(this).parents("tr").find("td:eq(1)").html();
        var codigo=$(this).parents("tr").find("td:eq(2)").html(); 
        var nombre=$(this).parents("tr").find("td:eq(3)").html();
        var descripcion=$(this).parents("tr").find("td:eq(4)").html();
        var saldocantidad=$(this).parents("tr").find("td:eq(5)").html();
        var saldocosto=$(this).parents("tr").find("td:eq(6)").html();
        var costopromedio=$(this).parents("tr").find("td:eq(7)").html();
        var ids_insumos = [];

        if ($(this).is(':checked')) {
            $('#tableBody-InsumosOrdenSalida tr').each(function() {
                ids_insumos.push($(this).find('td:eq(0)').html());   
            });
            if (ids_insumos.length==0) {
                ordensalida.AddTableInsumo(id,codigo,nombre,descripcion,saldocantidad,saldocosto,costopromedio);
            }
            else{
                if (ids_insumos.indexOf(id)!=-1) 
                    $('#chk-addinsumo'+id).attr("checked",false);
                else
                    ordensalida.AddTableInsumo(id,codigo,nombre,descripcion,saldocantidad,saldocosto,costopromedio);
            }
        }
    }

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0][0]);
        $('#frmOrdenSalida').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                ordensalida.Save;
            return false;
        });

        $('#frmInventarioOrdenSalida').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                ordensalida.Save;
            return false;
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }
    };

    
}

//Class Instance
let ordensalida = new OrdenSalida();