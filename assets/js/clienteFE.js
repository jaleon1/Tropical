class ClienteFE {
    // Constructor
    constructor(id, nombre, codigoSeguridad, idCodigoPais, idTipoIdentificacion, identificacion, nombreComercial, idProvincia, idCanton, idDistrito, idBarrio, otrasSenas, 
        idCodigoPaisTel, numTelefono, idCodigoPaisFax, numTelefonoFax, correoElectronico, username, password, llave, idBodega) {
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
        this.username = username || null; //ATV
        this.password = password || null; //ATV
        this.llave = llave || null;       //ATV
        this.idBodega = idBodega || null;
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

    get ReadProfile() {
        //NProgress.start();
        var miAccion = 'ReadProfile';
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
            data: {
                action: miAccion
            }
        })
            .done(function (e) {
                clientefe.ShowItemData(e);
            })
            .fail(function (e) {
                clientefe.showError(e);
            });
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
            clientefe.ShowList(e, $('#idTipoIdentificacion'));
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
            clientefe.ShowListUbicacion(e);
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    get ReadAllProvincia() {
        $('.ubicacion').attr("disabled", "disabled");
        var miAccion= 'ReadAllProvincia';
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
            data: { 
                action: miAccion
            }
        })
        .done(function( e ) {
            clientefe.ShowList(e, $('#idProvincia'));
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    get ReadAllCanton() {
        // $('#idCanton').attr("disabled", "disabled");
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
            // modifica la lista de distritos según la selección de cantón.
            clientefe.ReadAllDistrito;
        })    
        .fail(function (e) {
            clientefe.showError(e);
        })
        .always(function(){
            $('#idCanton').removeAttr("disabled");  
        });
    };

    get ReadAllDistrito() {
        //$('.ubicacion').attr("disabled", "disabled");
        var miAccion= 'ReadAllDistrito';
        this.idCanton = $('#idCanton option:selected').val() || 1;
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
            // modifica la lista de barrios según la selección de distrito.
            clientefe.ReadAllBarrio;
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    get ReadAllBarrio() {
        //$('.ubicacion').attr("disabled", "disabled");        
        var miAccion= 'ReadAllBarrio';
        this.idDistrito = $('#idDistrito option:selected').val() || 1;
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
        this.username = $("#username").val();
        this.password = $("#password").val();
        //
        if(dz==null){
            swal({
                type: 'warning',
                title: 'Cerfificado...',
                text: 'Debe agregar el certificado'
            });
            return false;
        }                    
        //
        $('#btnSubmit').attr("disabled", "disabled");
        $.ajax({
            type: "POST",
            url: "class/clientefe.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function(){
                dz.processQueue();
                //clientefe.showInfo();
            })
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

    ShowListUbicacion(e) {
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
            selector.selectpicker("refresh");
            
        })
    };

    ShowList(e, selector) {
        // carga lista con datos.
        var data = JSON.parse(e);
        //selector.html('<option value=null >Sin seleccionar </option>');
        // Recorre arreglo.
        selector.html('');
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
        $('#idTipoIdentificacion option').prop("selected", false);        
        $("#identificacion").val('');
        $("#nombreComercial").val('');
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
        clientefe= new ClienteFE(data.id, data.nombre, data.codigoSeguridad, data.idCodigoPais, data.idTipoIdentificacion, data.identificacion, data.nombreComercial, data.idProvincia, data.idCanton, data.idDistrito, data.idBarrio, data.otrasSenas, data.
            idCodigoPaisTel, data.numTelefono, data.idCodigoPaisFax, data.numTelefonoFax, data.correoElectronico, data.username, data.password, data.llave);
        // Asigna objeto a controles
        $("#idBodega").val($('.call_Bodega').text());
        $("#id").val(clientefe.id);
        $("#nombre").val(clientefe.nombre);
        $("#contribuyente").html('<h3>Registro de Contribuyente de Factura Electrónica: ' + $('.call_Bodega').text() + '<h3>' );
        $("#codigoSeguridad").val(clientefe.codigoSeguridad);
        $("#idCodigoPais").val(clientefe.idCodigoPais);
        $('#idTipoIdentificacion option[value=' + clientefe.idTipoIdentificacion + ']').prop("selected", true);  
        $("#idTipoIdentificacion").selectpicker("refresh");
        $("#identificacion").val(clientefe.identificacion);
        $("#nombreComercial").val(clientefe.nombreComercial);

        
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
            clientefe.ReadAllCanton;
        });
        $('#idCanton').on('change', function(e){
            clientefe.ReadAllDistrito;
        });
        $('#idDistrito').on('change', function(e){
            clientefe.ReadAllBarrio;
        });
        // submit
        $('#btnSubmit').click(function () {
            $('#frm').submit();
        });
        // dropzone        
        Dropzone.options.frmLlave = {
            init: function() {
                this.on("addedfile", function(file) { 
                    dz= this;
                    clientefe.llave= dz.files[0].name;
                });    
                this.on("complete", function(file) { 
                    if(file.xhr.response!='UPLOADED')
                        swal({
                            type: 'error',
                            title: 'Oops...',
                            text: 'Ha ocurrido un error al subir el Certificado.',
                            footer: '<a href>Contacte a Soporte Técnico</a>',
                        })
                    else clientefe.showInfo();
                });
                this.on("error", function(file) {
                    swal({
                        type: 'error',
                        title: 'Oops...',
                        text: 'Certificado con error',
                        footer: '<a href>Contacte a Soporte Técnico</a>',
                    })
                    this.removeFile(file);
                    
                });
                this.on("canceled", function(file) { 
                    swal({
                        type: 'error',
                        title: 'Oops...',
                        text: 'Certificado cancelado',
                        footer: '<a href>Contacte a Soporte Técnico</a>',
                })
                });
            },
            autoProcessQueue: false,
            acceptedFiles: "application/x-pkcs12",
            maxFiles: 1,
            autoDiscover: false
        };
        //Dropzone.options.frmLlave.
    };
}
//Class Instance
var dz;
let clientefe = new ClienteFE();