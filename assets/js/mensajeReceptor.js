class MensajeReceptor {
    // Constructor
    constructor(id, clave, identificacion, montoImpuesto, totalComprobante, identificacionReceptor, consecutivoFE, mensaje, detalle, tb_mensajeReceptor, fechaInicial, fechaFinal) {
        this.id = id || null;
        this.clave = clave || '';
        this.identificacion = identificacion || '';
        this.montoImpuesto = montoImpuesto || '';
        this.totalComprobante = totalComprobante || '';
        this.identificacionReceptor = identificacionReceptor || '';
        this.consecutivoFE = consecutivoFE || null;
        this.mensaje = mensaje || null;
        this.detalle = detalle || null;
        this.tb_mensajeReceptor = tb_mensajeReceptor || null;
        this.fechaInicial = fechaInicial || null;
        this.fechaFinal = fechaFinal || null;
    }

    // get Save() {
    //     // NProgress.start();        
    //     var miAccion = this.id == null ? 'Create' : 'Update';
    //     this.mensaje = $('#tipoMensaje option:selected').val();
    //     this.detalle = $("#detalle").val();
    //     $('#btnSubmit').attr("disabled", "disabled");
    //     $.ajax({
    //         type: "POST",
    //         url: "class/mensajeReceptor.php",
    //         data: {
    //             action: miAccion,
    //             obj: JSON.stringify(this)
    //         }
    //     })
    //         .done(function(){
    //             if(dz!=undefined)
    //                 dz.processQueue();
    //             else // No hay cola para subir.
    //                 mr.showInfo();
    //         })
    //         .fail(function (e) {
    //             mr.showError(e);
    //         })
    //         .always(function () {
    //             $("#btnSubmit").removeAttr("disabled");
    //         });
    // }

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
        // session.in(data);
        swal({
            type: 'error',
            title: 'Oops...',
            text: 'Algo no está bien (' + data.code + '): ' + data.msg,
            // // footer: '<a href>Contacte a Soporte Técnico</a>',
        });
    };

    drawRespuesta(e) {
        var tRespuesta = $('#tRespuesta').DataTable({
            data: e,
            destroy: true,
            "searching": false,
            "paging": false,
            "info": false,
            "ordering": false,
            // "retrieve": true,
            "order": [[0, "desc"]],
            columns: [
                {
                    title: "CLAVE",
                    data: "clave"
                },
                {
                    title: "ESTADO",
                    data: "estado"
                }
            ]
        });
    };

    CargaListaMR() {
        var rc=mr.tb_mensajeReceptor;
        mr.tb_mensajeReceptor = [];
        $.ajax({
                type: "POST",
                url: "class/mensajeReceptor.php",
                data: {
                    action: "ReadAllbyRange",
                    obj: JSON.stringify(mr)
                }
            })
            .done(function (e) {
                mr.tb_mensajeReceptor = rc;
                if (e != "null") {
                    mr.drawMensajeReceptor(e)
                } else {
                    swal({
                        type: 'success',
                        title: 'Listo, no hay facturas que cargar!',
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            })
            .fail(function (e) {
                mr.showError(e);
            });
    };

    CargaListaMRExterna() {
        var rc=mr.tb_mensajeReceptor;
        mr.tb_mensajeReceptor = [];
        $.ajax({
                type: "POST",
                url: "class/mensajeReceptor.php",
                data: {
                    action: "ReadAllbyRangeExterna",
                    obj: JSON.stringify(mr)
                }
            })
            .done(function (e) {
                mr.tb_mensajeReceptor = rc;
                if (e != "null") {
                    mr.drawMensajeReceptorExterna(e)
                } else {
                    swal({
                        type: 'success',
                        title: 'Listo, no hay facturas que cargar!',
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            })
            .fail(function (e) {
                mr.showError(e);
            });
    };

    drawMensajeReceptor(e) {
        var mesajesReceptor = JSON.parse(e);

        this.tb_mensajeReceptor = $('#tb_mensajeReceptor').DataTable({
            data: mesajesReceptor,
            footerCallback: function (row, data, start, end, display) {
                var api = this.api();
                // Remove the formatting to get integer data for summation
                var intVal = function (i) {
                    return typeof i === 'string' ?
                        i.replace(/[\¢,]/g, '') * 1 :
                        typeof i === 'number' ?
                        i : 0;
                };
                // Total de todas las paginas filtradas
                var totalComprobante = display.map(el => data[el][5]).reduce((a, b) => intVal(a) + intVal(b), 0 );

                // Actualiza el footer
                $( api.column( 5 ).footer() ).html('¢' + parseFloat(Number(totalComprobante)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            },
            responsive: true,
            destroy: true,
            order: [[ 2, "desc" ]],
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    exportOptions: {columns: [1, 2, 3, 4, 5]},                    
                    messageTop:'Mensaje Receptor'
                },
                {
                    extend: 'pdfHtml5',
                    orientation : 'landscape',
                    messageTop:'Mensaje Receptor',
                    exportOptions: {columns: [1, 2, 3, 4, 5]}
                }
            ],
            language: {
                "infoEmpty": "Sin Mensajes Receptor",
                "emptyTable": "Sin Mensajes Receptor",
                "search": "Buscar",
                "zeroRecords":    "No hay resultados",
                "lengthMenu":     "Mostrar _MENU_ registros",
                "paginate": {
                    "first":      "Primera",
                    "last":       "Ultima",
                    "next":       "Siguiente",
                    "previous":   "Anterior"
                }
            },
            columnDefs: [{className: "text-right", "targets": [4,5,7]}],
            columns: [
                {
                    title:"ID",
                    data:"id",
                    className:"itemId",                    
                    width:"auto",
                    searchable: false
                },
                {
                    title:"CONSECUTIVO",
                    data:"consecutivoFe",
                    width:"auto"
                },
                {
                    title:"FECHA DE CREACION",
                    data:"fechaCreacion",
                    width:"auto"
                },
                {
                    title:"DETALLE",
                    data:"detalle",
                    width:"auto"
                },
                {
                    title:"MENSAJE",
                    data:"mensaje",
                    width:"auto",
                    mRender: function ( e ) {
                        switch (e) {
                            case "1": return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green"> Aceptado</i>';
                            break;
                            case "2": return '<i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:#FF6F00"> Aceptado Parcialmente</i>'; 
                            break;
                            case "3": return '<i class="fa fa-times-circle" aria-hidden="true" style="color:red"> Rechazado</i>'; 
                            break;
                        }
                    }
                },
                {
                    title:"TOTAL",
                    data:"totalComprobante",
                    width:"auto",
                    type: 'formatted-num',
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                        }
                },
                {
                    title:"IDEMISOR",
                    data:"idEmisor",
                    width:"auto",
                    visible: false,
                    searchable: false
                },
                {
                    title: "ESTADO",
                    data: "idEstadoComprobante",
                    mRender: function ( e ) {
                        switch (e) {
                            case "1":
                                return '<i class="fa fa-paper-plane" aria-hidden="true" style="color:red"> Sin Enviar</i>';
                                break;
                            case "2":
                                return '<i class="fa fa-paper-plane" aria-hidden="true" style="color:green"> Enviado</i>';
                                break;
                            case "3":
                                return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green"> Aceptado</i>';
                                break;
                            case "4":
                                return '<i class="fa fa-times-circle" aria-hidden="true" style="color:red"> Rechazado</i>';
                                break;
                            case "5":
                                return '<i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:#FF6F00"> Otro</i>';
                                break;
                            case "99":
                                return '<i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:green"> Reportado</i>';
                                break;
                            default:
                                return 'Desconocido';
                                break;

                        }
                    }
                },
                {
                    title:"ACCION",
                    orderable: false,
                    searchable:false,
                    width:"auto",
                    render: function ( data, type, row, meta ) {
                        if(data==null)
                            switch (row['idEstadoComprobante']) {
                                case "1":
                                    return '<button class=btnEnviarFactura>&nbsp Enviar</button>'; // Sin enviar // No se envio en el momento, no salio del sistema local No llego a MH //Envio en Contingencia
                                    break;
                                case "2":
                                    return '<i class="fa fa-check-square-o">&nbsp Enviada</i>'; // Enviado //Quitar Boton y que diga enviado
                                    break;
                                case "3":
                                    return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green"> Aceptado!</i>'; // Aceptado  //Solo cancelar // NC 
                                    break;
                                case "4":
                                    return '<button class=btnNC_CreateFact_Ref>&nbsp Cancelar & Reenviar</button>'; // Rechazado //NC //Nueva con referencia Confeccion de Factura  // BTNCancelar y enviar
                                    break;
                                case "5":
                                    return '<i class="fa fa-cloud-upload" aria-hidden="true">&nbsp Enviar Contingencia</i>'; // Error (Otros) //Envio en Contingencia
                                    break;
                                default:
                                    return '<button>Soporte</button>';
                                    break;
                            }    
                            else
                                return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green">&nbsp Factura Cancelada!</i>';
                    }
                }
            ]
        });
    };

    drawMensajeReceptorExterna(e) {
        var mesajesReceptor = JSON.parse(e);

        this.tb_mensajeReceptor = $('#tb_mensajeReceptorExterna').DataTable({
            data: mesajesReceptor,
            footerCallback: function (row, data, start, end, display) {
                var api = this.api();
                // Remove the formatting to get integer data for summation
                var intVal = function (i) {
                    return typeof i === 'string' ?
                        i.replace(/[\¢,]/g, '') * 1 :
                        typeof i === 'number' ?
                        i : 0;
                };
                // Total de todas las paginas filtradas
                var totalComprobante = display.map(el => data[el][5]).reduce((a, b) => intVal(a) + intVal(b), 0 );

                // Actualiza el footer
                $( api.column( 5 ).footer() ).html('¢' + parseFloat(Number(totalComprobante)).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            },
            responsive: true,
            destroy: true,
            order: [[ 2, "desc" ]],
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    exportOptions: {columns: [1, 2, 3, 4, 5]},                    
                    messageTop:'Mensaje Receptor'
                },
                {
                    extend: 'pdfHtml5',
                    orientation : 'landscape',
                    messageTop:'Mensaje Receptor',
                    exportOptions: {columns: [1, 2, 3, 4, 5]}
                }
            ],
            language: {
                "infoEmpty": "Sin Mensajes Receptor",
                "emptyTable": "Sin Mensajes Receptor",
                "search": "Buscar",
                "zeroRecords":    "No hay resultados",
                "lengthMenu":     "Mostrar _MENU_ registros",
                "paginate": {
                    "first":      "Primera",
                    "last":       "Ultima",
                    "next":       "Siguiente",
                    "previous":   "Anterior"
                }
            },
            columnDefs: [{className: "text-right", "targets": [4,5,7]}],
            columns: [
                {
                    title:"ID",
                    data:"id",
                    className:"itemId",                    
                    width:"auto",
                    searchable: false
                },
                {
                    title:"CONSECUTIVO",
                    data:"consecutivoFe",
                    width:"auto"
                },
                {
                    title:"FECHA DE CREACION",
                    data:"fechaCreacion",
                    width:"auto"
                },
                {
                    title:"DETALLE",
                    data:"detalle",
                    width:"auto"
                },
                {
                    title:"MENSAJE",
                    data:"mensaje",
                    width:"auto"
                },
                {
                    title:"TOTAL",
                    data:"totalComprobante",
                    width:"auto",
                    type: 'formatted-num',
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                        }
                },
                {
                    title:"IDEMISOR",
                    data:"idEmisor",
                    width:"auto",
                    visible: false,
                    searchable: false
                },
                {
                    title:"ESTADO",
                    data:"idEstadoComprobante",
                    width:"auto",
                    mRender: function ( e ) {
                        var tipo="1";
                        if (e=="0") 
                            tipo="CASO 0";
                        if (e=="1") 
                            tipo="CASO 1";
                        if (e=="2") 
                            tipo="CASO 2";
                        if (e=="3") 
                            tipo="CASO 3";
                        if (e=="4") 
                            tipo="CASO 4";
                        if (e=="5") 
                            tipo="CASO 5";
                        return tipo
                        }
                },
                {
                    title:"ACCION",
                    orderable: false,
                    searchable:false,
                    width:"auto",
                    render: function (data, type, row, meta) {
                        var e=row['idEstadoComprobante'];
                        var opcion=0;
                        if(e==null)
                            opcion = 0;
                        else{
                            if (e=="0") 
                                return '<button type="button" class="btn btn-xs btn-default">CASO 0</button>';
                            if (e=="1") 
                                return '<button type="button" class="btn btn-xs btn-primary">CASO 1</button>';
                            if (e=="2") 
                                return '<button type="button" class="btn btn-xs btn-success">CASO 2</button>';
                            if (e=="3") 
                                return '<button type="button" class="btn btn-xs btn-info">CASO 3</button>';
                            if (e=="4") 
                                return '<button type="button" class="btn btn-xs btn-warning">CASO 4</button>';
                            if (e=="5") 
                                return '<button type="button" class="btn btn-xs btn-danger">CASO 5</button>';
                            }
                        }
                }
            ]
        });
    };

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms["frmXml"]);
        $('#frmXml').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                if (dz != undefined)
                    dz.processQueue();
            //     mr.Save;
            return false;
        });
        // on form "reset" event
        document.forms["frmXml"].onreset = function (e) {
            validator.reset();
        }
        //NProgress
        $(function () {
            $(document)
                .ajaxStart(function(){
                    NProgress.start();
                    $("button").prop("disabled", true);
                })
                .ajaxStop(function(){
                    NProgress.done();
                    $("button").prop("disabled", false);
                });
        });
        // submit
        $('#btnSubmit').click(function () {
            $('#m').val( $('#tipoMensaje option:selected').val());
            $('#d').val( $('#detalleMensaje').val());
            $('#frmXml').submit();            
        });
        // dropzone        
        Dropzone.options.frmXml = {
            init: function () {
                this.on("addedfile", function (file) {
                    dz = this;
                    // mr.certificado= dz.files[0].name;
                });
                this.on("complete", function (file) {
                    // estado de los envios.
                    var data= JSON.parse(file.xhr.response);
                    mr.drawRespuesta(data);                    
                    $('#modalRespuesta').show();      
                    return true;
                    //mr.showInfo();   <option value=${d.id} ${n == 0 ? `selected` : ``}> ${d.value}</option>
                    // if (file.xhr.response != 'UPLOADED') {
                    //     //JSON.parse(file.xhr.response);
                    //     swal({
                    //         type: 'error',
                    //         title: 'Oops...',
                    //         text: 'Ha ocurrido un error al subir los xml.',
                    //         // // footer: '<a href>Contacte a Soporte Técnico</a>',
                    //     });
                    //     $(file.previewElement).addClass('dz-error-message');
                    //     $('#filelist').html('');
                    //     // mr.certificado= null;
                    // } else {
                    //     // var data= JSON.parse(file.xhr.response)
                    //     // sesion.in(data);
                    //     mr.showInfo();
                    // }
                });
                this.on("error", function (file) {
                    var data= JSON.parse(file.xhr.response);
                    sesion.in(data);
                    swal({
                        type: 'error',
                        title: 'Oops...',
                        text: 'Archivo no válido.',
                        // // footer: '<a href>Contacte a Soporte Técnico</a>',
                    })
                    this.removeFile(file);
                });
                this.on("canceled", function (file) {
                    swal({
                        type: 'error',
                        title: 'Oops...',
                        text: 'Certificado cancelado',
                        // // footer: '<a href>Contacte a Soporte Técnico</a>',
                    })
                });
            },
            autoProcessQueue: false,
            acceptedFiles: "text/xml",
            // maxFiles: 1,
            parallelUploads : 100,
            uploadMultiple: true,
            addRemoveLinks: true,
            autoDiscover: false
        };
    };
}
var dz;
let mr = new MensajeReceptor();