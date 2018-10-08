class Consumible {
    // Constructor
    constructor(id, idProducto, cantidad, tamano) {
        this.id = id || null;
        this.idProducto = idProducto || null;
        this.cantidad = cantidad || 0;
        this.tamano = tamano || 0;
    }

    read() {
        NProgress.start();
        var miAccion = this.id == null ?  'ReadAll'  : 'Read';
        if(miAccion=='ReadAll' && $('#tConsumible8 tbody').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/consumible.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                consumible.Reload(e);
            })
            .fail(function (e) {
                consumible.showError(e);
            })
            .always(NProgress.done()); 
    };

    ReadProdbyCode(cod) {
        if (cod != ""){
            producto.codigo = cod;  //Columna 0 de la fila seleccionda= ID.
            //
            $.ajax({
                type: "POST",
                url: "class/consumible.php",
                data: {
                    action: "ReadByCode",
                    obj: JSON.stringify(producto)
                }
            })
            .done(function (e) {
                consumible.ValidatePrd(e);
            })
            .fail(function (e) {
                consumible.showError(e);
            });
        }
    };

    ValidatePrd(e){
        // carga lista con datos.
        if(e == "[]"){
            swal({
                type: 'warning',
                title: 'Consumibles',
                text: 'El item ' + producto.codigo + ' No existe.',
                showConfirmButton: false,
                timer: 3000
            });
            return;
        }
        if(e != "false" && e != ''){
            var data = JSON.parse(e)[0];
            producto.id= data.id;
            producto.idProducto= data.idProducto;
            producto.codigo= data.codigo; 
            producto.nombre= data.nombre;
            producto.cantidad= 1; 
            var repetido = false;
            //
            var tam=0;
            if(producto.tamano==0)
                tam=8;
            else tam=12;
            if(document.getElementById("tConsumible"+tam).rows.length != 0 && producto != null ){
                $(document.getElementById("tConsumible"+tam).rows).each(function(i,item){
                    if( item.innerText != 'Sin Registros' && item.childNodes[1].innerText==producto.idProducto){
                        repetido=true;
                        swal({
                            type: 'warning',
                            title: 'Consumibles',
                            text: 'El item ' + producto.codigo + ' ya se encuentra en la lista',
                            showConfirmButton: false,
                            timer: 3000
                        });
                    }     
                });
            }    
            if (repetido==false){
                consumible.agregarItem();
                $("#p_searhProducto8").val('');
                $("#p_searhProducto12").val('');
            }
        }
    };

    agregarItem(){
        if(producto.tamano==0){
            var rowNode= t8.row.add(producto)
                .draw() //dibuja la tabla con el nuevo producto
                .node();     
            //
            $('td:eq(4) input', rowNode).attr({id: (producto.codigo), min: "1", step:"1", value: producto.cantidad })
        }
        else{ // 12
            var rowNode= t12.row.add(producto)
                .draw() //dibuja la tabla con el nuevo producto
                .node();     
            //
            $('td:eq(4) input', rowNode).attr({id: (producto.codigo), min: "1", step:"1", value: producto.cantidad })
        }
    };

    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    ShowAll(e) {
        //var t8= $('#tConsumible8').DataTable();
        t8.clear();
        t12.clear();
        var data = JSON.parse(e);
        $.each(data, function (i, item) {
            producto= item;
            consumible.agregarItem();
        });        
    };

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

    showInfo() {
        //$(".modal").css({ display: "none" });   
        swal({
            type: 'success',
            title: 'Listo!',
            showConfirmButton: false,
            timer: 1000
        });
    };

    crear() {
        var miAccion = "Create";
        //
        consumible.lista = [];
        $('#tConsumible8 tbody tr').each(function (i, item) {
            var objlista = new Object();
            objlista.id = $(item).find('td:eq(0)')[0].textContent;
            objlista.idProducto = $(item).find('td:eq(1)')[0].textContent;
            objlista.cantidad = $(item).find('td:eq(4) input').val();
            objlista.tamano =0;
            consumible.lista.push(objlista);
        });
        $('#tConsumible12 tbody tr').each(function (i, item) {
            var objlista = new Object();
            objlista.id = $(item).find('td:eq(0)')[0].textContent;
            objlista.idProducto = $(item).find('td:eq(1)')[0].textContent;
            objlista.cantidad = $(item).find('td:eq(4) input').val();
            objlista.tamano =1;
            consumible.lista.push(objlista);
        });
        if (consumible.lista[0].idProducto == 'Sin Registros') {
            swal({
                type: 'warning',
                title: 'Seleccionar...',
                text: 'Debe seleccionar los productos consumibles'
            });
            return false;
        }
        $('#btnConsumible').attr("disabled", "disabled");
        //
        $.ajax({
            type: "POST",
            url: "class/consumible.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function () {
                consumible.showInfo();
                consumible.read();
            })
            .fail(function (e) {
                consumible.showError(e);
            })
            .always(function () {
                $("#btnConsumible").removeAttr("disabled");
                $("#p_searhProducto8").focus();
            });

    };

    Deleteproducto8(e){
        // consumible.id = $(e).parents('tr').find('td:eq(0)').text();  //Class itemId = ID del objeto.
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
            t8.row( $(e).parents('tr') )
                .remove()
                .draw();
        })
    };

    Deleteproducto12(e){
        // consumible.id = $(e).parents('tr').find('td:eq(0)').text();  //Class itemId = ID del objeto.
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
            t12.row( $(e).parents('tr') )
                .remove()
                .draw();
        })
    };

    setTable(){
        t8 = $('#tConsumible8').DataTable( {
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
            columnDefs: [{className: "text-right", "targets": [4]}],
            columns: [
                {
                    title:"ID",
                    data:"id",
                    className:"itemId",
                    searchable: false,                    
                    width:"auto"
                },
                {
                    title:"IDPRODUCTO",
                    data:"idProducto",
                    className:"itemId",
                    searchable: false,                    
                    width:"auto"
                },
                {
                    title:"CODIGO",
                    data:"codigo",
                    width:"auto"
                },
                {
                    title:"PRODUCTO",
                    data:"nombre",
                    width:"auto"
                },
                {//cant.
                    title:"CANTIDAD",
                    "width": "15%", 
                    "data": "cantidad",
                    // "defaultContent": '<input class="cantidad form-control" type="number" min="1" max="9999999999" step="1" style="text-align:right;" value=1 >'
                    mRender: function () {
                        return '<input class="cantidad form-control" type="number" min="1" max="9999999999" step="1" style="text-align:right;" >'
                    }
                },
                {
                    title:"ACCION",
                    orderable: false,
                    searchable:false,
                    mRender: function () {
                        return '<a class="delete" style="cursor: pointer;" onclick="consumible.Deleteproducto8(this)" > <i class="glyphicon glyphicon-trash"> </i></a>' 
                    },
                    visible:true
                }
            ]
        });
        t12 = $('#tConsumible12').DataTable( {
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
            columnDefs: [{className: "text-right", "targets": [4]}],
            columns: [
                {
                    title:"ID",
                    data:"id",
                    className:"itemId",
                    searchable: false,                    
                    width:"auto"
                },
                {
                    title:"IDPRODUCTO",
                    data:"idProducto",
                    className:"itemId",
                    searchable: false,                    
                    width:"auto"
                },
                {
                    title:"CODIGO",
                    data:"codigo",
                    width:"auto"
                },
                {
                    title:"PRODUCTO",
                    data:"nombre",
                    width:"auto"
                },
                {//cant.
                    title:"CANTIDAD",
                    "width": "15%", 
                    "data": "cantidad",
                    // "defaultContent": '<input class="cantidad form-control" type="number" min="1" max="9999999999" step="1" style="text-align:right;" value=1 >'
                    mRender: function () {
                        return '<input class="cantidad form-control" type="number" min="1" max="9999999999" step="1" style="text-align:right;" >'
                    }
                },
                {
                    title:"ACCION",
                    orderable: false,
                    searchable:false,
                    mRender: function () {
                        return '<a class="delete" style="cursor: pointer;" onclick="consumible.Deleteproducto12(this)" > <i class="glyphicon glyphicon-trash"> </i></a>' 
                    },
                    visible:true
                }
            ]
        });
    };
}

let consumible = new Consumible();
var t8=null;
var t12=null;