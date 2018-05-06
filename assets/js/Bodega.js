class Bodega {
    // Constructor
    constructor(id, nombre, descripcion, ubicacion, contacto, telefono, tipo) {
        this.id = id || null;
        this.nombre = nombre || '';
        this.descripcion = descripcion || '';
        this.ubicacion = ubicacion || '';
        this.contacto = contacto || '';
        this.telefono = telefono || '';
        this.tipo = tipo || null;
    }

    //Getter
    get Read() {
        var miAccion = this.id == null ?  'ReadAll'  : 'Read';
        if(miAccion=='ReadAll' && $('#tableBody-Bodega').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/Bodega.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                bodega.Reload(e);
            })
            .fail(function (e) {
                bodega.showError(e);
            });
    }

    get Save() {
        $('#btnBodega').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.nombre = $("#nombre").val();
        this.descripcion = $("#descripcion").val();
        this.ubicacion = $("#ubicacion").val();
        this.contacto = $("#contacto").val();        
        this.telefono = $("#telefono").val();
        this.tipo = $('#tipo option:selected').val();
        $.ajax({
            type: "POST",
            url: "class/Bodega.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(bodega.showInfo)
            .fail(function (e) {
                bodega.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnBodega").removeAttr("disabled")', 1000);
                bodega = new Bodega();
                bodega.ClearCtls();
                bodega.Read;
                $("#nombre").focus();
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/Bodega.php",
            data: {
                action: 'Delete',
                id: this.id
            }
        })
            .done(function () {
                swal({
                    //position: 'top-end',
                    type: 'success',
                    title: 'Eliminado!',
                    showConfirmButton: false,
                    timer: 1000
                });
            })
            .fail(function (e) {
                bodega.showError(e);
            })
            .always(function () {
                bodega = new Bodega();
                bodega.Read;
            });
    }

    get ListTipos() {
        var miAccion= 'ListTipos';
        $.ajax({
            type: "POST",
            url: "class/Bodega.php",
            data: { 
                action: miAccion
            }
        })
        .done(function( e ) {
            bodega.ShowList(e);
        })    
        .fail(function (e) {
            bodega.showError(e);
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
            position: 'top-end',
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

    ClearCtls() {
        $("#id").val('');
        $("#nombre").val('');
        $("#descripcion").val('');
        $("#ubicacion").val('');
        $("#contacto").val('');
        $("#telefono").val('');
        $('#tipo option').prop("selected", false);
    };

    ShowAll(e) {
        // Limpia el div que contiene la tabla.
        $('#tableBody-Bodega').html("");
        // Carga lista
        var data = JSON.parse(e);
        //style="display: none"
        $.each(data, function (i, item) {
            $('#tableBody-Bodega').append(`
                <tr> 
                    <td class="a-center ">
                        <input type="checkbox" class="flat" name="table_records">
                    </td>
                    <td class="itemId" >${item.id}</td>
                    <td>${item.nombre}</td>
                    <td>${item.descripcion}</td>
                    <td>${item.tipo}</td>
                    ${item.nombre!='Primaria' ?
                        `<td class=" last">
                            <a href="#" id="update${item.id}" data-toggle="modal" data-target=".bs-example-modal-lg" > <i class="glyphicon glyphicon-edit" > </i> Editar </a> | 
                            <a href="#" id="delete${item.id}"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>
                        </td>`
                    :
                        `<td class=" last">No editable</td>`}
                </tr>
            `);
            // event Handler
            if(i!=0){
                $('#update'+item.id).click(bodega.UpdateEventHandler);
                $('#delete'+item.id).click(bodega.DeleteEventHandler);
            }
        })
        //datatable         
        if ($.fn.dataTable.isDataTable('#dsProducto')) {
            var table = $('#dsProducto').DataTable();
        }
        else
            $('#dsProducto').DataTable({
                columns: [
                    { title: "Check" },
                    {
                        title: "ID"
                        //,visible: false
                    },
                    { title: "Nombre" },
                    { title: "Descripcion" },
                    { title: "Tipo" },
                    { title: "Action" }
                ],
                paging: true,
                search: true
            });
    };

    UpdateEventHandler() {
        bodega.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
        bodega.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e)[0];
        bodega = new Bodega(data.id, data.nombre, data.descripcion, data.ubicacion, data.contacto, data.telefono, data.tipo);
        // Asigna objeto a controles
        $("#id").val(bodega.id);
        $("#nombre").val(bodega.nombre);
        $("#descripcion").val(bodega.descripcion);
        $("#ubicacion").val(bodega.ubicacion);
        $("#contacto").val(bodega.contacto);
        $("#telefono").val(bodega.telefono);
        //fk 
        $('#tipo option[value=' + bodega.tipo + ']').prop("selected", true);        
    };

    ShowList(e) {
        // carga lista con datos.
        var data = JSON.parse(e);
        // Recorre arreglo.
        $.each(data, function (i, item) {
                $('#tipo').append(`
                    <option value=${item.id}>${item.nombre}</option>
                `);
        })
    };

    DeleteEventHandler() {
        bodega.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                bodega.Delete;
            }
        })
    };

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0]);
        $('#frmProducto').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                bodega.Save;
            return false;
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }

    };
}

//Class Instance
let bodega = new Bodega();