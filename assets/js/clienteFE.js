class ClienteFE {
    // Constructor
    constructor(id, nombre, idCodigoPais, idTipoIdentificacion, identificacion, nombreComercial, idProvincia, idCanton, idDistrito, idBarrio, otrasSenas, 
        idCodigoPaisTel, numTelefono, idCodigoPaisFax, numTelefonoFax, correoElectronico, username, password, certificado, idBodega, filename, filesize, filetype, estadoCertificado, pinp12) {
        this.id = id || null;
        this.nombre = nombre || '';        
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
        this.certificado = certificado || null;       //ATV
        this.idBodega = idBodega || null;
        this.filename = filename || null;
        this.filesize = filesize || null;
        this.filetype = filetype || null;
        this.estadoCertificado= estadoCertificado || 0;
        this.pinp12= pinp12 || null;
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
            url: "class/ClienteFE.php",
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
                if(e=='"INTERNA"')
                {
                     $('.x_content').html(`<center><h3>Registro de Contribuyente Interno</h3></center>`);
                     $('.x_content').append(`<center><span>Dirígase a la Agencia Principal para realizar cambios</span></center>`);
                }
                else
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
            $("#idBodega").val($('.call_Bodega').text());
            clientefe.ShowList(e, $('#idTipoIdentificacion'));     
            // luego de cargar las listas, lee el clienteFE.
            clientefe.ReadProfile;       
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    }

    get ReadAllUbicacion() {
        this.idProvincia = $('#idProvincia option:selected').val() || 1;
        this.idCanton = $('#idCanton option:selected').val() || 1;
        this.idDistrito = $('#idDistrito option:selected').val() || 1;
        $('#idProvincia').html("");
        $('#idCanton').html("");
        $('#idDistrito').html("");
        $('#idBarrio').html("");
        $('#idProvincia').attr("title", "Cargando ...");
        $('#idCanton').attr("title", "Cargando ...");
        $('#idDistrito').attr("title", "Cargando ...");
        $('#idBarrio').attr("title", "Cargando ...");
        $('#idProvincia').selectpicker("refresh");
        $('#idCanton').selectpicker("refresh");
        $('#idDistrito').selectpicker("refresh");
        $('#idBarrio').selectpicker("refresh");
        var miAccion= 'ReadAllUbicacion';
        $('#btnSubmit').attr("disabled", "disabled");
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
            $("#btnSubmit").removeAttr("disabled");
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    get ReadAllProvincia() {
        var miAccion= 'ReadAllProvincia';
        $('#btnSubmit').attr("disabled", "disabled");
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
            data: { 
                action: miAccion
            }
        })
        .done(function( e ) {
            clientefe.ShowList(e, $('#idProvincia'));
            $('#idProvincia option[value=' + clientefe.idProvincia + ']').prop("selected", true);  
            $("#idProvincia").selectpicker("refresh");
            clientefe.ReadAllCanton;
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    get ReadAllCanton() {
        $('#idCanton').html("");
        $('#idDistrito').html("");
        $('#idBarrio').html("");
        $('#idCanton').attr("title", "Cargando ...");
        $('#idDistrito').attr("title", "Cargando ...");
        $('#idBarrio').attr("title", "Cargando ...");
        $('#idCanton').selectpicker("refresh");
        $('#idDistrito').selectpicker("refresh");
        $('#idBarrio').selectpicker("refresh");
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
            $('#idCanton option[value=' + clientefe.idCanton + ']').prop("selected", true);  
            $("#idCanton").selectpicker("refresh");                
            // modifica la lista de distritos según la selección de cantón.
            clientefe.ReadAllDistrito;
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    get ReadAllDistrito() {
        $('#idDistrito').html("");
        $('#idBarrio').html("");
        $('#idDistrito').attr("title", "Cargando ...");
        $('#idBarrio').attr("title", "Cargando ...");
        $('#idDistrito').selectpicker("refresh");
        $('#idBarrio').selectpicker("refresh");
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
            $('#idDistrito option[value=' + clientefe.idDistrito + ']').prop("selected", true);  
            $("#idDistrito").selectpicker("refresh");
            // modifica la lista de barrios según la selección de distrito.
            clientefe.ReadAllBarrio;
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    get ReadAllBarrio() {
        $('#idBarrio').html("");
        $('#idBarrio').attr("title", "Cargando ...");
        $('#idBarrio').selectpicker("refresh");
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
            $('#idBarrio option[value=' + clientefe.idBarrio + ']').prop("selected", true);  
            $("#idBarrio").selectpicker("refresh");
            $("#btnSubmit").removeAttr("disabled");
        })    
        .fail(function (e) {
            clientefe.showError(e);
        });
    };

    get Save() {
        // NProgress.start();        
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.nombre = $("#nombre").val();
        // codigo de seguridad autogenerado
        var max = 11111111;
        var min = 99999999;
        this.codigoSeguridad =  Math.floor(Math.random()*(max-min+1)+min);
        this.idCodigoPais = '52'; //$("#codigoPais").val(); 52 = 506 Costa Rica.
        this.idTipoIdentificacion = $('#idTipoIdentificacion option:selected').val();
        this.identificacion = $("#identificacion").val();
        this.nombreComercial = $("#nombreComercial").val();
        if($('#idProvincia option:selected').val()!="null" && $('#idProvincia option:selected').val() != undefined)
            this.idProvincia = $('#idProvincia option:selected').val();
        else {
            swal({
                type: 'warning',    
                title: 'Ubicación...',
                text: 'Debe seleccionar la Provincia'
            });
            return false;
        }
        if($('#idCanton option:selected').val()!="null" && $('#idCanton option:selected').val() != undefined)
            this.idCanton = $('#idCanton option:selected').val();
        else {
            swal({
                type: 'warning',
                title: 'Ubicación...',
                text: 'Debe seleccionar el Cantón'
            });
            return false;
        }
        if($('#idDistrito option:selected').val()!="null" && $('#idDistrito option:selected').val() != undefined)
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
        this.pinp12 = $("#pinp12").val();
        //        
        if(this.certificado == null){
            swal({
                type: 'warning',
                title: 'Cerfificado...',
                text: 'Debe agregar el certificado'
            });
            return false;
        }                    
        $('#btnSubmit').attr("disabled", "disabled");
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
            data: {
                action: miAccion,
                objC: JSON.stringify(this)
            }
        })
            .done(function(){
                // Sube el certificado y crea/actualiza cliente.
                if(dz!=undefined)
                    dz.processQueue();
                else // No hay cola para subir.
                    clientefe.showInfo();
            })
            .fail(function (e) {
                clientefe.showError(e);
            })
            .always(function () {
                $("#btnSubmit").removeAttr("disabled");
                // clientefe = new ClienteFE();
                // clientefe.ClearCtls();
                // clientefe.ReadProfile;
                //$("#nombre").focus();
                // NProgress.done();
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
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

    get DeleteCertificado() {
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
            data: {
                action: 'DeleteCertificado',
                certificado: clientefe.certificado,
                id: clientefe.id
            }
        })
            .done(function () {
                $('#filelist').html('');
                clientefe.certificado= null;
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
            });
    }

    get DownloadCertificado() {
        $.ajax({
            type: "GET",
            url: "class/downloadCert.php",
            data: {
                action: 'DownloadCertificado',
                certificado: clientefe.certificado,
                id: clientefe.id
            }
        })
            .done(function () {
                
            })
            .fail(function (e) {
                clientefe.showError(e);
            });
        // var xhr = new XMLHttpRequest();
        // xhr.open("GET", "class/downloadCert.php");
        // xhr.send();
    }

    // Methods
    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    ShowListUbicacion(e) {
        if(e!='[]'){
            // carga lista con datos.
            var data = JSON.parse(e);
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
                        <option value=${d.id} ${n==0?`selected`:``}> ${d.value}</option>
                    `);
                })
                selector.selectpicker("refresh");
            })        
        }
        else {
            swal({
                type: 'error',
                title: 'Oops...',
                text: 'Algo no está bien, La lista de ubicaciones no puede ser cargada',
                footer: '<a href>Contacte a Soporte Técnico</a>',
            })
        }
    };

    ShowList(e, selector) {
        if(e!='[]'){
            // carga lista con datos.
            var data = JSON.parse(e);
            // Recorre arreglo.
            selector.html('');
            $.each(data, function (i, item) {
                selector.append(`
                    <option value=${item.id} ${i==0?`selected`:``} >${item.value}</option>
                `);            
            })
            selector.selectpicker("refresh");
        }
        else {
            swal({
                type: 'error',
                title: 'Oops...',
                text: 'Algo no está bien, La lista no puede ser cargada'
            })
        }
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
        //$("#idBodega").val('');
        $("#nombre").val('');
        $("#idCodigoPais").val('');
        $('#idTipoIdentificacion option').prop("selected", false);    
        $("#idTipoIdentificacion").selectpicker("refresh"); 
        $("#identificacion").val('');
        $("#nombreComercial").val('');
        $('#idProvincia option').prop("selected", false);
        $('#idCanton option').prop("selected", false);
        $('#idDistrito option').prop("selected", false);
        $('#idBarrio option').prop("selected", false);
        $("#otrasSenas").val('');
        $("#numTelefono").val('');
        $("#correoElectronico").val('');
        $("#username").val('');
        $("#password").val('');
        $("#pinp12").val('');
        $("#filelist").html('');
        if(dz!=undefined)
            dz.removeAllFiles();
    };

    ShowAll(e) {
        var t= $('#tclientefe').DataTable();
        t.clear();
        t.rows.add(JSON.parse(e));
        t.draw();
        // $('.update').click(clientefe.UpdateEventHandler);
        // $('.delete').click(clientefe.DeleteEventHandler);
        // $('.open').click(clientefe.OpenEventHandler);
        // $('#tclientefe tbody tr').click(clientefe.viewType==undefined || clientefe.viewType==clientefe.tUpdate ? clientefe.UpdateEventHandler : clientefe.SelectEventHandler);
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();        
        if(e!="null"){
            // carga objeto.
            var data = JSON.parse(e);
            clientefe= new ClienteFE(data.id, data.nombre, data.idCodigoPais, data.idTipoIdentificacion, data.identificacion, data.nombreComercial, data.idProvincia, data.idCanton, data.idDistrito, data.idBarrio, data.otrasSenas, data.
                idCodigoPaisTel, data.numTelefono, data.idCodigoPaisFax, data.numTelefonoFax, data.correoElectronico, data.username, data.password, data.certificado, data.idBodega,
                data.filename, data.filesize, data.filetype, data.estadoCertificado, data.pinp12
            );
            // Asigna objeto a controles        
            $("#id").val(clientefe.id);
            $("#nombre").val(clientefe.nombre);
            $("#contribuyente").html('<h3>Registro de Contribuyente de Factura Electrónica: ' + $('.call_Bodega').text() + '<h3>' );
            $("#idCodigoPais").val(clientefe.idCodigoPais);
            $('#idTipoIdentificacion option[value=' + clientefe.idTipoIdentificacion + ']').prop("selected", true);  
            $("#idTipoIdentificacion").selectpicker("refresh");
            clientefe.ReglasTipoIdentificacion(clientefe.idTipoIdentificacion);
            $("#identificacion").val(clientefe.identificacion);
            $("#nombreComercial").val(clientefe.nombreComercial);
            // lee las provincias - cantones - distritos - barrios de la provincia seleccionada.
            clientefe.ReadAllProvincia;            
            //
            $("#otrasSenas").val(clientefe.otrasSenas);
            $("#numTelefono").val(clientefe.numTelefono);
            $("#correoElectronico").val(clientefe.correoElectronico);
            $("#username").val(clientefe.username);
            $("#password").val(clientefe.password);
            $("#pinp12").val(clientefe.pinp12);
            //            
            $('#filelist').append(`
                <div class="btn-group">
                    <button type="button" class="btn ${clientefe.estadoCertificado==1? `btn-success` : `btn-danger` }">${clientefe.certificado}</button>
                    <button type="button" class="btn ${clientefe.estadoCertificado==1? `btn-success` : `btn-danger` } dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        <span class="caret"></span>
                        <span class="sr-only">Toggle Dropdown</span>
                    </button>
                    ${clientefe.estadoCertificado==1? `
                        <ul class="dropdown-menu" role="menu">
                            <li><a id='certEliminar'>Eliminar</a></li>
                            <li class="divider"></li>
                            <li><a href='class/downloadCert.php?certificado=${clientefe.certificado}' id='certDescargar'>Descargar</a></li>
                        </ul>` 
                    : `` }
                </div>           
            `).fadeIn();
            if(clientefe.estadoCertificado==0)
                swal({
                    type: 'error',
                    title: 'Oops...',
                    text: 'Ha ocurrido un error al localizar el Certificado.',
                    footer: '<a href>Contacte a Soporte Técnico</a>',
                });  
            // eventos
            $('#certEliminar').click(function(){
                swal({
                    title: 'Eliminar Certificado?',
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
                    // elimina certificado del servidor
                    if (result.value) {
                        clientefe.DeleteCertificado;
                    }
                })
                
            });
            // datos sin modificar = conexion valida.
            testConn.res = true;
            // $('#certDescargar').click(function(){
            //     clientefe.DownloadCertificado;
            // });
            //var mockFile = { name: clientefe.filename, size: clientefe.filesize, type: 'application/x-pkcs12' };
            // dz.options.addedfile.call(dz, mockFile);
        }
        else {
            clientefe.ReadAllUbicacion;
        }
    };

    ReglasTipoIdentificacion(opt){
        var p,lr,ph;
        switch(opt){
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
        // clientefe.Init();
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms["frm"]);
    }

    probarConexion(showMess = false){
        if ($('#username').val() == "" || $('#password').val() == "" ){
            // swal({
            //     type: 'warning',
            //     title: 'Conexión...',
            //     text: 'Debe llenar el formulario para probar la conexión.',
            //     footer: '<a href>Contacte a Soporte Técnico</a>',
            // });
            return;
        }
        var miAccion = 'testConnection';
        this.username = $("#username").val();
        this.password = $("#password").val();
        $.ajax({
            type: "POST",
            url: "class/ClienteFE.php",
            data: {
                action: miAccion,
                username: this.username,
                password: this.password,
                correoElectronico: this.correoElectronico
            }
        })
            .done(function (e) {
                if(e=='true'){
                    if(showMess)
                        swal({
                            type: 'info',
                            title: 'Conexión...',
                            text: 'Conexión Exitosa!',
                        });
                    testConn.res = true;
                }
                else {
                    if(showMess)
                        swal({
                            type: 'error',
                            title: 'Conexión...',
                            text: 'Conexión Fallida, revise su usuario y contraseña de ATV.',
                            footer: '<a href>Contacte a Soporte Técnico</a>'
                        });
                    testConn.res = false;
                }

            })
            .fail(function (e) {
                usuario.showError(e);
            });
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
        {$(document)
                .ajaxStart(NProgress.start)
                .ajaxStop(NProgress.done);
        });
        // validaciones segun el tipo de ident.
        $('#idTipoIdentificacion').on('change', function(e){
            validator.reset();
            clientefe.ReglasTipoIdentificacion($(this).val());
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
                    clientefe.certificado= dz.files[0].name;
                });    
                this.on("complete", function(file) { 
                    if(file.xhr.response!='UPLOADED'){
                        swal({
                            type: 'error',
                            title: 'Oops...',
                            text: 'Ha ocurrido un error al subir el Certificado.',
                            footer: '<a href>Contacte a Soporte Técnico</a>',
                        });                        
                        $(file.previewElement).addClass('dz-error-message');
                        $('#filelist').html('');
                        clientefe.certificado= null;
                    }
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
                // this.on("queuecomplete", function(file) {
                //     this.removeAllFiles();
                // });
            },
            autoProcessQueue: false,
            acceptedFiles: "application/x-pkcs12",
            maxFiles: 1,
            addRemoveLinks: true,
            autoDiscover: false
        };
        $('#btnEliminar').click(function () {
            
        });
        // emisor.
        // prueba de conexion// test conexion
        $('#btnTest').click(function () {
            clientefe.probarConexion(true);
        });
        // prueba de conexion// test conexion
        $('#btnTest').click(function () {
            clientefe.probarConexion(true);
        });
        $('#username').on('change', function (e) {
            clientefe.probarConexion();
        });
        $('#password').on('change', function (e) {
            clientefe.probarConexion();
        });
    };
}
//Class Instance
var dz;
let clientefe = new ClienteFE();
var testConn = {
    aInternal: false,
    aListener: function(val) {},
    set res(val) {
      this.aInternal = val;
      this.aListener(val);
    },
    get res() {
      return this.aInternal;
    },
    registerListener: function(listener) {
      this.aListener = listener;
    }
}
testConn.registerListener(function(val) {
    if(!val){
        $("#btnTest").text('Probar Conexión');
        $("#btnTest").attr('class', 'btn btn-danger');
    }
    else {
        $("#btnTest").text('Conexión Ok!');
        $("#btnTest").attr('class', 'btn btn-success');
    }
});