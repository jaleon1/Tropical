class IpAutorizada {
    // Constructor
    constructor(id, ip) {
        this.id = id || null;        
        this.ip = ip || '';
    }

    //Getter
    get Read() {
        var miAccion = this.id == null ? 'ReadAll' : 'Read';
        if(miAccion=='ReadAll' && $('#tableBody-IpAutorizada').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/IpAutorizada.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                ipautorizada.Reload(e);
            })
            .fail(function (e) {
                ipautorizada.showError(e);
            });
    }

    get Save() {
        $('#btnIp').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.ip = $("#ip").val();
        $.ajax({
            type: "POST",
            url: "class/IpAutorizada.php",
            data: {
                action: miAccion,
                ip: this.ip
            }
        })
            .done(ipautorizada.showInfo)
            .fail(function (e) {
                ipautorizada.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnIp").removeAttr("disabled")', 1000);
                ipautorizada = new IpAutorizada();
                ipautorizada.ClearCtls();
                ipautorizada.Read;
                $("#ip").focus();
            });
    }
    
    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/IpAutorizada.php",
            data: {
                action: 'Delete',
                id: this.id
            }
        })
            .done(function () {
                swal({
                    //
                    type: 'success',
                    title: 'Eliminado!',
                    showConfirmButton: false,
                    timer: 1000
                });
            })
            .fail(function (e) {
                ipautorizada.showError(e);
            })
            .always(function () {
                ipautorizada = new IpAutorizada();
                ipautorizada.Read;
            });
    }

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
            title: 'Good!',
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

    LimpiaArticulos(){
        $('#tableBody-ArticuloBodega').html("");
    };

    ClearCtls() {
        $("#ip").val('');
    };

    ShowAll(e) {
        var url;
        url = window.location.href;
        // Limpia el div que contiene la tabla.
        $('#tableBody-IpAutorizada').html("");
        // // Carga lista
        var data = JSON.parse(e);
    };

    UpdateEventHandler() {
        ipautorizada.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
        ipautorizada.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e)[0];
        ipautorizada = new IpAutorizada(data.id, data.ip, data.nombre, data.txtColor, data.bgColor, data.nombreAbreviado, 
        data.descripcion, data.saldoCantidad, data.costoPromedio, data.precioVenta , data.esVenta);
        // Asigna objeto a controles
        $("#id").val(ipautorizada.id);
        $("#ip").val(ipautorizada.ip);
        $("#nombre").val(ipautorizada.nombre);
        $("#txtColor").val(ipautorizada.txtColor);
        $("#bgColor").val(ipautorizada.bgColor);
        $("#nombreAbreviado").val(ipautorizada.nombreAbreviado);
        $("#descripcion").val(ipautorizada.descripcion);
        $("#saldoCantidad").val(ipautorizada.saldoCantidad);
        $("#saldoCosto").val(parseFloat(ipautorizada.saldoCantidad).toFixed(2));
        $("#costoPromedio").val(parseFloat(ipautorizada.costoPromedio).toFixed(2));
        $("#precioVenta").val(parseFloat(ipautorizada.precioVenta).toFixed(2));
        $("#esVenta").val(ipautorizada.esVenta);

        // checkbox
        if(ipautorizada.esVenta==1){
            $("#esVenta")[0].checked=true;
        }
        else {
            $("#esVenta")[0].checked=false;
        }
    };

    DeleteEventHandler() {
        ipautorizada.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                ipautorizada.Delete;
            }
        })
    };

    AddArticuloEventHandler(){
        var posicion=null;
        var id=$(this).parents("tr").find("td:eq(1)").html();
        var nombre=$(this).parents("tr").find("td:eq(2)").html();
        var ip=$(this).parents("tr").find("td:eq(3)").html();
        if ($(this).is(':checked')) {
            if (ipautorizada.lista.indexOf(id)!=-1){
                $(this).attr("checked",false);
                return false;
            }
            else{
                ipautorizada.AddTableArticulo(id,nombre);
            }
        }
        else{
            posicion = ipautorizada.lista.indexOf(id);
            ipautorizada.lista.splice(posicion,1);
            $('#row'+id).remove();
        }
    };

    AddTableArticulo(id,nombre) {
        $('#tableBody-ArticuloBodega').append(`
            <tr id="row"${id}> 
                <td class="itemId" >${id}</td>
                <td>${nombre}</td>
                <td>
                    <input id="cantidad" class="form-control col-3" name="cantidad" type="text" placeholder="Cantidad de artículos" autofocus="" value="1">
                </td>
                <td>
                    <input id="costo" class="form-control col-3" name="costo" type="text" placeholder="Costo del artículo" autofocus="" value="0">
                </td>
                <td class=" last">
                    <a id ="delete_row${id}" onclick="productotemporal.Deleteproducto(this)" > <i class="glyphicon glyphicon-trash" onclick="Deleteproducto(this)"> </i> Eliminar </a>
                </td>
            </tr>
        `);
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsArticulo' ) ) {
            var table = $('#dsArticulo').DataTable();
        }
        else 
            $('#dsArticulo').DataTable( {               
                columns: [
                    { "width":"40%"},
                    { "width":"25%"},
                    { "width":"25%"},
                    { "width":"10%"}
                ],          
                paging: true,
                search: true
            } );
    };

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms["frmIp"]);
        $('#frmIp').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                ipautorizada.Save;
            return false;
        });

        // on form "reset" event
        if($('#frmIp').length > 0 )
            document.forms["frmIp"].onreset = function (e) {
                validator.reset();
        } 
    };

}

//Class Instance
let ipautorizada = new IpAutorizada();