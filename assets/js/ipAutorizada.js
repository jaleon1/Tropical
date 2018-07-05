class IpAutorizada {
    // Constructor
    constructor(ip) {   
        this.ip = ip || null;
    }

    //Getter
    get Read() {
        var miAccion = this.ip == null ? 'ReadAll' : 'Read';
        if(miAccion=='ReadAll' && $('#tbodyItems').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/IpAutorizada.php",
            data: {
                action: miAccion,
                ip: this.ip
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
        var miAccion = this.ip == null ? 'Create' : 'Update';
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
                ip: this.ip
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
        if (this.ip == null)
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
  
    ClearCtls() {
        $("#ip").val('');
    };

    ShowAll(e) {
        t.clear();
        t.rows.add(JSON.parse(e));
        t.draw();
        //$('.update').click(ipautorizada.UpdateEventHandler);
        $('.delete').click(ipautorizada.DeleteEventHandler);
    };

    UpdateEventHandler() {
        //ipautorizada.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto no visible
        ipautorizada.ip = $(this).parents("tr").find(".itemIdvisible").text();  //Class itemId = ID del objeto. 
        ipautorizada.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e)[0];     
        ipautorizada= new IpAutorizada(data.ip);
        // Asigna objeto a controles        
        $("#ip").val(ipautorizada.ip);
        // Muestra modal
        $(".modal").modal('toggle');
    };

    DeleteEventHandler() {
        ipautorizada.ip = $(this).parents("tr").find(".itemIdvisible").text();  //Class itemId = ID del objeto.
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