class Insumo {
    // Constructor
    constructor(id, codigo,nombre, descripcion, saldoCantidad, saldoCosto, costoPromedio, tablainsumo) {
        this.id = id || null;
        this.codigo = codigo || '';
        this.nombre = nombre || '';
        this.descripcion = descripcion || '';
        this.saldoCantidad = saldoCantidad || 0;
        this.saldoCosto = saldoCosto || 0;
        this.costoPromedio = costoPromedio || 0;
        //this.tablainsumo;
    }

    //Getter
    get Read() {
        var miAccion = this.id == null ? 'ReadAll' : 'Read';
        if(document.URL.indexOf("OrdenSalida.html")!=-1)
            miAccion='ReadSaldoPositivo';
        if(miAccion=='ReadAll' && $('#tableBody-Insumo').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                insumo.Reload(e);
            })
            .fail(function (e) {
                insumo.showError(e);
            });
    }

    get Save() {
        $('#btnInsumo').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.codigo = $("#codigo").val();
        this.nombre = $("#nombre").val();
        this.descripcion = $("#descripcion").val();
        this.saldoCantidad = $("#saldoCantidad").val();
        this.saldoCosto = $("#saldoCosto").val();
        this.costoPromedio = $("#costoPromedio").val();
        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(insumo.showInfo)
            .fail(function (e) {
                insumo.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnInsumo").removeAttr("disabled")', 1000);
                insumo = new Insumo();
                insumo.ClearCtls();
                insumo.Read;
                $("#nombre").focus();
                insumo.ValorDefault();
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
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
                insumo.showError(e);
            })
            .always(function () {
                insumo = new Insumo();
                insumo.Read;
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
        $("#codigo").val('');
        $("#nombre").val('');
        $("#descripcion").val('');
        $("#saldoCantidad").val('0');
        $("#saldoCosto").val('0');
        $("#costoPromedio").val('0');
    };

    ShowAll(e) {
        //Crea los eventos según sea el url
        var t= $('#dsInsumo').DataTable();
        if(t.rows().count()==0){
           t.clear();
           t.rows.add(JSON.parse(e));
           t.draw();
           $( document ).on( 'click', '#dsInsumo tbody tr', document.URL.indexOf("OrdenSalida.html")!=-1? insumo.AddInsumo:insumo.UpdateEventHandler);
           $( document ).on( 'click', '.delete',insumo.DeleteEventHandler);
        }else{
           t.clear();
           t.rows.add(JSON.parse(e));
           t.draw();
        }
    };

    ReadbyCode(cod) {
        if (cod != ""){
            insumo.codigo = cod;  //Columna 0 de la fila seleccionda= ID.
            //
            $.ajax({
                type: "POST",
                url: "class/Insumo.php",
                data: {
                    action: "ReadByCode",
                    obj: JSON.stringify(insumo)
                }
            })
            .done(function (e) {
                insumo.ValidateInsumoFac(e);
            })
            .fail(function (e) {
                insumo.showError(e);
            });
        }
    };

    ValidateInsumoFac(e){
        //compara si el articulo ya existe
        // carga lista con datos.
        if(e == "[]"){
            swal({
                type: 'warning',
                title: 'Orden de Compra',
                text: 'El item ' + insumo.codigo + ' No existe.',
                showConfirmButton: false,
                timer: 3000
            });
            return;
        }
        if(e != "false" && e != ''){
            var data = JSON.parse(e)[0];
            insumo.id= data.id; 
            insumo.codigo= data.codigo; 
            insumo.nombre= data.nombre; 
            insumo.descripcion= data.descripcion;
            var repetido = false;
            //
            if(document.getElementById("tInsumo").rows.length != 0 && insumo != null){
                $(document.getElementById("tInsumo").rows).each(function(i,item){
                    if(item.childNodes[0].innerText==insumo.id){
                        repetido=true;
                        swal({
                            type: 'warning',
                            title: 'Orden de Compra',
                            text: 'El item ' + producto.codigo + ' ya se encuentra en la lista',
                            showConfirmButton: false,
                            timer: 3000
                        });
                    }
                });
            }    
            if (repetido==false){
                // showDataProducto(e);
                insumo.agregarItem();
                //insumo.ResetSearch();
                $("#p_searhInsumo").val('');
            }
        }
    };

    agregarItem(){
        ti.row.add(insumo)
            .draw() //dibuja la tabla con el nuevo insumo
            .node();     
        //
        // $('td:eq(2) input', rowNode).attr({id: ("prec_"+insumo.codigo), max:  "9999999999", min: "0", step:"1", value:"1" }).change(function(){
        //     ordenCompra.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        // });
        // //
        // $('td:eq(3) input', rowNode).attr({id: ("cantBueno_"+insumo.codigo), max:  "9999999999", min: "1", step:"1", value:"1"}).change(function(){
        //      ordenCompra.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        // });

        // //$('td:eq(4)', rowNode).attr({id: ("cantMalo_"+insumo.codigo)});
        // $('td:eq(4) input', rowNode).attr({id: ("cantMalo_"+insumo.codigo), max:  "9999999999", min: "0", step:"1", value:"0"}).change(function(){
        //      ordenCompra.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        // });
        //
        // $('td:eq(5) input.valor', rowNode).attr({id: ("valorBueno_v"+insumo.codigo), style: "display:none"});
        // $('td:eq(5) input.display', rowNode).attr({id: ("valorBueno_d"+insumo.codigo)});    
        // $('td:eq(6) input.valor', rowNode).attr({id: ("valorMalo_v"+insumo.codigo), style: "display:none"});
        // $('td:eq(6) input.display', rowNode).attr({id: ("valorMalo_d"+insumo.codigo)});
        // $('td:eq(7) input.valor', rowNode).attr({id: ("subtotal_v"+insumo.codigo), style: "display:none"});
        // $('td:eq(7) input.display', rowNode).attr({id: ("subtotal_d"+insumo.codigo)});   
        //t.order([0, 'desc']).draw();
        //t.columns.adjust().draw();
        //ordenCompra.CalcImporte(insumo.codigo);
        //calcTotal();
        //$('#open_modal_fac').attr("disabled", false);
    };

    Merma(){
        $('#btnMerma').attr("disabled", "disabled");
        var miAccion = "Merma";
        insumo.lista = [];
        $('#tInsumo tbody tr').each(function(i, item) {
            var objlista = new Object();
            objlista.id= $(item).find('td:eq(0)')[0].textContent;
            objlista.cantidad= $(item).find('td:eq(4) input').val();
            insumo.lista.push(objlista);
        });
        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(insumo.showInfo)
            .fail(function (e) {
                insumo.showError(e);
            })
            .always(function () {
                $("#btnMerma").removeAttr("disabled");
                insumo = new Insumo();
                insumo.CleanCtls();
                $("#p_searh").focus();
            });

    }

    setTableOrdenSalida(){
        this.tablainsumo = $('#dsInsumo').DataTable( {
            responsive: true,
            destroy: true,
            order: [[ 1, "asc" ]],
            columnDefs: [{className: "text-right", "targets": [4]}],
            columns: [
                {
                    title:"ID",
                    data:"id",
                    className:"itemId",
                    searchable: false},
                {
                    title:"CODIGO",
                    data:"codigo"},
                {
                    title:"NOMBRE",
                    data:"nombre"},
                {
                    title:"DESCRIPCION",
                    data:"descripcion"},
                {
                    title:"SALDO CANTIDAD",
                    data:"saldoCantidad"},
                {
                    title:"SALDO COSTO",
                    data:"saldoCosto",
                    className:"oculto_saldoCosto", 
                    visible:false},
                {
                    title:"COSTO PROMEDIO",
                    data:"costoPromedio",
                    className:"oculto_costoPromedio", 
                    visible:false},
                {
                    title:"ACCIÓN",
                    orderable: false,
                    searchable:false,
                    mRender: function () {
                        return '<a class="update"> <i class="glyphicon glyphicon-edit" > </i> Editar </a> | '+
                                '<a class="delete"> <i class="glyphicon glyphicon-trash"> </i> </a>' 
                    },
                    visible:false}
            ]
        });
    };

    setTableInventarioInsumo(){
        this.tablainsumo = $('#dsInsumo').DataTable( {
            responsive: true,
            destroy: true,
            order: [[ 1, "asc" ]],
            language: {
                "infoEmpty": "Sin Usuarios Registrados",
                "emptyTable": "Sin Usuarios Registrados",
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
            columnDefs: [{className: "text-right", "targets": [4,5,6]}],
            columns: [
                {
                    title:"ID",
                    data:"id",
                    className:"itemId",                    
                    width:"auto",
                    searchable: false},
                {
                    title:"CODIGO",
                    data:"codigo",
                    width:"auto"},
                {
                    title:"NOMBRE",
                    data:"nombre",
                    width:"auto"},
                {
                    title:"DESCRIPCION",
                    data:"descripcion",
                    width:"auto"},
                {
                    title:"SALDO CANTIDAD",
                    data:"saldoCantidad",
                    width:"auto"},
                {
                    title:"SALDO COSTO",
                    data:"saldoCosto",
                    width:"auto",
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")}},
                {
                    title:"COSTO PROMEDIO",
                    data:"costoPromedio",
                    width:"auto",
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")}},
                {
                    title:"ACCIÓN",
                    orderable: false,
                    searchable:false,
                    className: "buttons",
                    width: "auto",
                    mRender: function () {
                        return '<a class="delete" style="cursor: pointer;"> <i class="glyphicon glyphicon-trash"> </i> </a>' 
                    },
                }
            ]
        });
    };

    setTableInventarioOrdenSalida(){
        this.tablainsumo = $('#dsInsumo').DataTable( {
            responsive: true,
            destroy: true,
            order: [[ 1, "asc" ]],
            language: {
                "infoEmpty": "Sin Usuarios Registrados",
                "emptyTable": "Sin Usuarios Registrados",
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
            columnDefs: [{className: "text-right", "targets": [4]}],
            columns: [
                {
                    title:"ID",
                    data:"id",
                    className:"itemId",
                    searchable: false},
                {
                    title:"CODIGO",
                    data:"codigo"},
                {
                    title:"NOMBRE",
                    data:"nombre"},
                {
                    title:"DESCRIPCION",
                    data:"descripcion"},
                {
                    title:"SALDO CANTIDAD",
                    data:"saldoCantidad"},
                {
                    title:"SALDO COSTO",
                    data:"saldoCosto",
                    className:"oculto_saldoCosto", 
                    visible:false},
                {
                    title:"COSTO PROMEDIO",
                    data:"costoPromedio",
                    className:"oculto_costoPromedio", 
                    visible:false},
                {
                    title:"ACCIÓN",
                    orderable: false,
                    searchable:false,
                    mRender: function () {
                        return '<a class="update"> <i class="glyphicon glyphicon-edit" > </i> Editar </a> | '+
                                '<a class="delete"> <i class="glyphicon glyphicon-trash"> </i> </a>' 
                    },
                    visible:false}
            ]
        });
    }

    setTableMerma(){
        ti = $('#tInsumo').DataTable( {
            responsive: true,
            destroy: true,
            order: [[ 1, "asc" ]],
            language: {
                "infoEmpty": "Sin Registros",
                "emptyTable": "Sin Registros",
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
            columnDefs: [{className: "text-right", "targets": [5]}],
            columns: [
                {
                    title:"Id",
                    data:"id",
                    className:"itemId",
                    searchable: false,                    
                    width:"auto"
                },
                {
                    title:"Codigo",
                    data:"codigo",
                    width:"auto"
                },
                {
                    title:"Nombre",
                    data:"nombre",
                    width:"auto"
                },
                {
                    title:"Descripción",
                    data:"descripcion",
                    width:"auto"
                },
                {//cant.
                    title:"Cantidad",
                    "width": "15%", 
                    "data": null,
                    "defaultContent": '<input class="cantidad form-control" type="number" value=1>'
                },
                {
                    title:"Acción",
                    orderable: false,
                    searchable:false,
                    mRender: function () {
                        return '<a class="delete" style="cursor: pointer;"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>' 
                    },
                    visible:true
                }
            ]
        });
    };

    AddInsumo(){
        var id=$(this).find("td:eq(0)").html();
        var codigo=$(this).find("td:eq(1)").html(); 
        var nombre=$(this).find("td:eq(2)").html();
        var descripcion=$(this).find("td:eq(3)").html();
        var saldoCantidad=$(this).find("td:eq(4)").html();
        //Para campos ocultos
        var saldoCosto = insumo.tablainsumo.row(this).data()[5];
        var costoPromedio = insumo.tablainsumo.row(this).data()[6];
        ordenSalida.AddInsumoEventHandler(id,codigo,nombre,descripcion,saldoCantidad,saldoCosto,costoPromedio);
    }; 

    UpdateEventHandler() {
        insumo.id = $(this).find(".itemId").text();  //Class itemId = ID del objeto.
        insumo.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e)[0];
        $("#id").val(data.id);
        $("#codigo").val(data.codigo);
        $("#nombre").val(data.nombre);
        $("#descripcion").val(data.descripcion);
        $("#saldoCantidad").val(data.saldoCantidad);
        $("#saldoCosto").val(parseFloat(data.saldoCosto).toFixed(2));
        $("#costoPromedio").val(parseFloat(data.costoPromedio).toFixed(2));
        $(".bs-example-modal-lg").modal('toggle');
    };

    DeleteEventHandler() {
        insumo.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                insumo.Delete;
            }
        })
    };

    ValorDefault(){
        $("#saldoCantidad").val('0');
        $("#saldoCosto").val('0.00');
        $("#costoPromedio").val('0.00');
    }

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0]);
        $('#frmInsumo').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                insumo.Save;
            return false;
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }
        
        // datepicker.js
        // $('#dpfechaExpiracion').datetimepicker({
        //     format: 'DD/MM/YYYY'
        // });
    };
}

//Class Instance
let insumo = new Insumo();
var ti;