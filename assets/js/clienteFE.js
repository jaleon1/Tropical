class ClienteFE {
    // Constructor
    constructor(id, nombre, codigoSeguridad, idCodigoPais, idTipoIdentificacion, identificacion, nombreComercial, idProvincia, idCanton, idDistrito, idBarrio, otrasSenas, 
        idCodigoPaisTel, numTelefono, idCodigoPaisFax, numTelefonoFax, correoElectronico) {
        this.id = id || null;
        this.nombre = nombre || '';
        this.codigoSeguridad = codigoSeguridad || '';
        this.idCodigoPais = idCodigoPais || '';
        this.idTipoIdentificacion = idTipoIdentificacion || '';
        this.identificacion = identificacion || '';
        this.nombreComercial = nombreComercial || '';
        this.idProvincia = idProvincia || null;
        this.idCanton = idCanton || null;
        this.idDistrito = idDistrito || null;
        this.idBarrio = idBarrio || null;
        this.otrasSenas = otrasSenas || null;
        this.idCodigoPaisTel = idCodigoPaisTel || null;
        this.numTelefono = numTelefono || null;
        this.idCodigoPaisFax = idCodigoPaisFax || null;
        this.numTelefonoFax = numTelefonoFax || null;
        this.correoElectronico = correoElectronico || null;
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
        //NProgress.start();
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
            });
            //.always(NProgress.done());
    }

    get ReadAllTipoIdentificacion() {
        var miAccion= 'ReadAllTipoIdentificacion';
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
            data: { 
                action: miAccion
            }
        })
        .done(function( e ) {
            clientefe.ShowTipoIdentificacion(e, $('#idTipoIdentificacion'));
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    }

    get ReadAllUbicacion() {
        $('.ubicacion').attr("disabled", "disabled");
        this.idProvincia = $('#idProvincia option:selected').val() || 1;
        this.idCanton = $('#idCanton option:selected').val() || 1;
        this.idDistrito = $('#idDistrito option:selected').val() || 1;
        var miAccion= 'ReadAllUbicacion';
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
            data: { 
                action: miAccion,
                idProvincia: this.idProvincia,
                idCanton: this.idCanton,
                idDistrito: this.idDistrito
            }
        })
        .done(function( e ) {
            clientefe.ShowList(e);
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    // get ReadAllProvincia() {
    //     $('.ubicacion').attr("disabled", "disabled");
    //     var miAccion= 'ReadAllProvincia';
    //     $.ajax({
    //         type: "POST",
    //         url: "class/ClienteFE.php",
    //         data: { 
    //             action: miAccion
    //         }
    //     })
    //     .done(function( e ) {
    //         clientefe.ShowList(e, $('#idProvincia'));
    //     })    
    //     .fail(function (e) {
    //         clientefe.showError(e);
    //     })
    //     .always(function(){
    //         $(".ubicacion").removeAttr("disabled");
    //     });
    // };

    get ReadAllCanton() {
        var miAccion= 'ReadAllCanton';
        this.idProvincia = $('#idProvincia option:selected').val() || 1;
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
            data: { 
                action: miAccion,
                idProvincia: this.idProvincia
            }
        })
        .done(function( e ) {
            clientefe.ShowList(e, $('#idCanton'));
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    get ReadAllDistrito() {
        var miAccion= 'ReadAllDistrito';
        this.idCanton = $('#idProvincia option:selected').val() || 1;
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
            data: { 
                action: miAccion,
                idCanton: this.idCanton
            }
        })
        .done(function( e ) {
            clientefe.ShowList(e, $('#idDistrito'));
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    get ReadAllBarrio() {
        var miAccion= 'ReadAllBarrio';
        this.idDistrito = $('#idProvincia option:selected').val() || 1;
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
            data: { 
                action: miAccion,
                idDistrito: this.idDistrito
            }
        })
        .done(function( e ) {
            clientefe.ShowList(e, $('#idBarrio'));
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    get Save() {
        // NProgress.start();
        $('#btnSubmit').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.nombre = $("#nombre").val();
        this.codigoSeguridad = $("#codigoSeguridad").val();
        this.idCodigoPais = '52'; //$("#codigoPais").val();
        this.idTipoIdentificacion = $('#idTipoIdentificacion option:selected').val();
        this.identificacion = $("#identificacion").val();
        this.nombreComercial = $("#nombreComercial").val();
        if($('#idProvincia option:selected').val()!="null")
            this.idProvincia = $('#idProvincia option:selected').val();
        else {
            swal({
                type: 'warning',
                title: 'Ubicación...',
                text: 'Debe seleccionar la Provincia'
            });
            return false;
        }
        if($('#idCanton option:selected').val()!="null")
            this.idCanton = $('#idCanton option:selected').val();
        else {
            swal({
                type: 'warning',
                title: 'Ubicación...',
                text: 'Debe seleccionar el Cantón'
            });
            return false;
        }
        if($('#idDistrito option:selected').val()!="null")
            this.idDistrito = $('#idDistrito option:selected').val();
        else {
            swal({
                type: 'warning',
                title: 'Ubicación...',
                text: 'Debe seleccionar el Cantón'
            });
            return false;
        }        
        this.idBarrio = $('#idBarrio option:selected').val();
        this.otrasSenas = $("#otrasSenas").val();
        this.idCodigoPaisTel = '52';//$("#codigoPais").val(); // mismo código del país.
        this.numTelefono = $("#numTelefono").val();
        this.correoElectronico = $("#correoElectronico").val();
        //
        // Llave criptográfica
        //
        
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
                $("#btnSubmit").removeAttr("disabled");
                //clientefe = new clientefe();
                //clientefe.ClearCtls();
                //clientefe.Read;
                //$("#nombre").focus();
                // NProgress.done();
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

    ShowList(e) {
        // carga lista con datos.
        var data = JSON.parse(e);
        //selector.html('<option value=null >Sin seleccionar </option>');
        // Recorre arreglo.
        var selector;
        $.each(data, function (i, item) {
            switch(i){
                case 0:
                    selector = $('#idProvincia');
                break;
                case 1:
                    selector = $('#idCanton');
                break;
                case 2:
                    selector = $('#idDistrito');
                break;
                case 3:
                    selector = $('#idBarrio');
                break;
            }
            selector.html('');
            $.each(item, function (n, d) {
                selector.append(`
                    <option value=${d.id}>${d.value}</option>
                `);
            })
            selector.removeAttr("disabled");
            //$('.ubicacion').attr("disabled", "disabled");
            selector.selectpicker("refresh");
            
        })
    };

    ShowTipoIdentificacion(e, selector) {
        // carga lista con datos.
        var data = JSON.parse(e);
        //selector.html('<option value=null >Sin seleccionar </option>');
        // Recorre arreglo.
        $.each(data, function (i, item) {
            selector.append(`
                <option value=${item.id} ${i==0?`selected`:``} >${item.value}</option>
            `);            
        })
        selector.selectpicker("refresh");
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
        // $('.update').click(clientefe.UpdateEventHandler);
        // $('.delete').click(clientefe.DeleteEventHandler);
        // $('.open').click(clientefe.OpenEventHandler);
        // $('#tclientefe tbody tr').dblclick(clientefe.viewType==undefined || clientefe.viewType==clientefe.tUpdate ? clientefe.UpdateEventHandler : clientefe.SelectEventHandler);
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
        //NProgress
        $(function()
        {
            $(document)
                .ajaxStart(NProgress.start)
                .ajaxStop(NProgress.done);
        });
        // validaciones segun el tipo de ident.
        $('#idTipoIdentificacion').on('change', function(e){
            var p,lr,ph;
            switch($(this).val()){
                case '1': // física
                    p= "([0-9])";
                    lr= "9,9";
                    ph=  "9 digitos, sin cero al inicio y sin guiones.";                    
                    break;
                case '2': // jurídica
                    p= "([0-9]){9,10}$";
                    lr= "10,10";
                    ph= "10 digitos y sin guiones.";
                    break;
                case '3': // DIMEX
                    p= "([0-9]){9,10}$";
                    lr= "11,12";
                    ph= "11 o 12 digitos, sin ceros al inicio y sin guiones.";                    
                    break;
                case '4': // NITE
                    p= "([0-9]){10,10}$";
                    lr="10,10";
                    ph= "10 digitos y sin guiones.";
                    break;
            }
            $('#identificacion').attr('pattern', p);
            $('#identificacion').attr('data-validate-length-range', lr);
            $('#identificacion').attr('placeholder', ph);
            clientefe.Init();
        });
        // ubicaciones
        $('#idProvincia').on('change', function(e){
            clientefe.ReadAllUbicacion;
            // clientefe.ReadAllDistrito;
            // clientefe.ReadAllBarrio;
        });
        $('#idCanton').on('change', function(e){
            clientefe.ReadAllUbicacion;
            // clientefe.ReadAllDistrito;
            // clientefe.ReadAllBarrio;
        });
        $('#idDistrito').on('change', function(e){
            clientefe.ReadAllUbicacion;
            // clientefe.ReadAllBarrio;
        });
        // submit
        $('#btnSubmit').click(function () {
            $('#frm').submit();
        });
        // dropzone
        Dropzone.options.frmLlave = {
            init: function() {
              this.on("addedfile", function(file) { alert("Added file."); });
            },
            accept : ".p12",
            maxFiles: 1
          };
        // var myDropzone = new Dropzone("div#myId", { url: "/file/post"});
        // $("div#myId").dropzone({ url: "/file/post" });

    };
}

//Class Instance
let clientefe = new ClienteFE();