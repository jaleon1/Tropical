class ClienteFE {
    // Constructor
    constructor(id, nombre, codigoSeguridad, idCodigoPais, idnombreComercialIdentificacion, identificacion, nombreComercial, idProvincia, idCanton, idDistrito, idBarrio, otrasSenas, idCodigoPaisTel, numTelefono, idCodigoPaisFax, numTelefonoFax) {
        this.id = id || null;
        this.nombre = nombre || '';
        this.codigoSeguridad = codigoSeguridad || '';
        this.idCodigoPais = idCodigoPais || '';
        this.idnombreComercialIdentificacion = idnombreComercialIdentificacion || '';
        this.identificacion = identificacion || '';
        this.nombreComercial = nombreComercial || null;
    }

    get tUpdate()  {
        return this.update ="update"; 
    }

    get tSelect()  {
        return this.select = "select";
    }

    set viewEventHandler(_t) {
        this.viewType = _t;        
    }

    //Getter
    get Read() {
        NProgress.start();
        var miAccion = this.id == null ?  'ReadAll'  : 'Read';
        if(miAccion=='ReadAll' && $('#tclientefe tbody').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/clientefe.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                clientefe.Reload(e);
            })
            .fail(function (e) {
                clientefe.showError(e);
            })
            .always(NProgress.done());
    }

    get Save() {
        NProgress.start();
        $('#btnclientefe').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.nombre = $("#nombre").val();
        this.codigoSeguridad = $("#codigoSeguridad").val();
        this.idCodigoPais = $("#idCodigoPais").val();
        this.idnombreComercialIdentificacion = $("#idnombreComercialIdentificacion").val();        
        this.identificacion = $("#identificacion").val();
        this.nombreComercial = $('#nombreComercial option:selected').val();
        $.ajax({
            type: "POST",
            url: "class/clientefe.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(clientefe.showInfo)
            .fail(function (e) {
                clientefe.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnclientefe").removeAttr("disabled")', 1000);
                clientefe = new clientefe();
                clientefe.ClearCtls();
                clientefe.Read;
                $("#nombre").focus();
                NProgress.done();
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/clientefe.php",
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
                clientefe.showError(e);
            })
            .always(function () {
                clientefe = new clientefe();
                clientefe.Read;
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

    ClearCtls() {
        $("#id").val('');
        $("#nombre").val('');
        $("#codigoSeguridad").val('');
        $("#idCodigoPais").val('');
        $("#idnombreComercialIdentificacion").val('');
        $("#identificacion").val('');
        $('#nombreComercial option').prop("selected", false);
    };

    ShowAll(e) {
        var t= $('#tclientefe').DataTable();
        t.clear();
        t.rows.add(JSON.parse(e));
        t.draw();
        $('.update').click(clientefe.UpdateEventHandler);
        $('.delete').click(clientefe.DeleteEventHandler);
        $('.open').click(clientefe.OpenEventHandler);
        $('#tclientefe tbody tr').dblclick(clientefe.viewType==undefined || clientefe.viewType==clientefe.tUpdate ? clientefe.UpdateEventHandler : clientefe.SelectEventHandler);
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e)[0];
        clientefe = new clientefe(data.id, data.nombre, data.codigoSeguridad, data.idCodigoPais, data.idnombreComercialIdentificacion, data.identificacion, data.nombreComercial);
        // Asigna objeto a controles
        $("#id").val(clientefe.id);
        $("#nombre").val(clientefe.nombre);
        $("#myModalLabel").html('<h1>' + clientefe.nombre + '<h1>' );
        $("#codigoSeguridad").val(clientefe.codigoSeguridad);
        $("#idCodigoPais").val(clientefe.idCodigoPais);
        $("#idnombreComercialIdentificacion").val(clientefe.idnombreComercialIdentificacion);
        $("#identificacion").val(clientefe.identificacion);
        //fk 
        $('#nombreComercial option[value=' + clientefe.nombreComercial + ']').prop("selected", true);    
        $("#nombreComercial").selectpicker("refresh");
        $(".bs-clientefe-modal-lg").modal('toggle');
    };

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms["frm"]);
        $('#frm').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                clientefe.Save;
            return false;
        });

        // on form "reset" event
        document.forms["frm"].onreset = function (e) {
            validator.reset();
        }

    };
}

//Class Instance
let clientefe = new ClienteFE();