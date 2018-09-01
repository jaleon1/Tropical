class Distribucion {
    // Constructor
    constructor(id, orden, fecha, idUsuario, idBodega, porcentajeDescuento, porcentajeIva, lista, bodega) {
        this.id = id || null;        
        this.orden = orden || '';
        this.fecha = fecha || '';
        this.idUsuario = idUsuario || null;
        this.idBodega = idBodega || null;
        this.bodega = bodega || null;
        this.porcentajeDescuento = porcentajeDescuento || 0;
        this.porcentajeIva = porcentajeIva || 0;
        this.lista = lista || [];
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

    get Read() {
        NProgress.start();
        var miAccion = this.id == null ?  'ReadAll'  : 'Read';
        if(miAccion=='ReadAll' && $('#tDistribucion tbody').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/Distribucion.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                distr.Reload(e);
            })
            .fail(function (e) {
                distr.showError(e);
            })
            .always(NProgress.done()); 
    }

    get Save() {
        if($('#tDistribucion tbody tr').length==0 ){
            swal({
                type: 'warning',
                title: 'Orden de Traslado',
                text: 'Debe agregar items a la lista',
                showConfirmButton: false,
                timer: 3000
            });
            return;
        }
        //
        $('#btnDistribucion').attr("disabled", "disabled");
        var miAccion = distr.id == null ? 'Create' : 'Update';        
        distr.orden = $("#orden").val();
        distr.idBodega = bodega.id;
        distr.porcentajeDescuento = $("#desc_100").val();
        distr.porcentajeIva=$("#iv_100").val();
        //
        distr.lista = [];
        $('#tDistribucion tbody tr').each(function(i, item) {
            var objlista = new Object();
            objlista.idProducto= $(item).find('td:eq(0)')[0].textContent; // id del item.
            objlista.cantidad= $(item).find('td:eq(4) input').val();
            objlista.valor= $(item).find('td:eq(5)').attr('value'); // valor: precio de venta para distribucióncion bodega externa. 
            distr.lista.push(objlista);
        });
        $.ajax({
            type: "POST",
            url: "class/Distribucion.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function(e){
                // muestra el numero de orden: IMPRIMIR.
                distr.ticketPrint(e)
                // var data = JSON.parse(e)[0];
                // swal({
                //     type: 'success',
                //     title: 'Número de Orden:' + data.orden,
                //     text: 'Número de orden de Distribución:',
                //     showConfirmButton: true
                // });
            })
            .fail(function (e) {
                distr.showError(e);
            })
            .always(function () {
                $("#btnDistribucion").removeAttr("disabled");
                distr = new Distribucion();
                distr.CleanCtls();
                $("#p_searh").focus();
            });
    };

    ticketPrint(e){
        var data = JSON.parse(e);
        localStorage.setItem("lsOrden",data.orden);
        localStorage.setItem("lsBodega",$("#nombre").val());
        localStorage.setItem("lsDescripcion",$("#descripcion").val());
        localStorage.setItem("lsSubTotal",$("#subtotal").text());
        localStorage.setItem("lsTotal",$("#total").text());
        localStorage.setItem("lsFechaDistribucion",data.fecha);
        localStorage.setItem("lsPorcentajeDescuento",$("#desc_val").text());
        localStorage.setItem("lsPorcentajeIva",$("#iv_val").text());
        localStorage.setItem("lsListaProducto",JSON.stringify(data.lista));
        localStorage.setItem("lsUsuarioDistribucion",$("#call_username").text());
        // location.href ="/Tropical/TicketDistribucion.html";
        location.href ="/TicketDistribucion.html";
    }

    get ReadbyOrden() {
        $('#orden').attr("disabled", "disabled");
        var miAccion = 'ReadbyOrden';
        distr.orden= $('#p_searh').val();
        $.ajax({
            type: "POST",
            url: "class/Distribucion.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function (e) {
                if(e=='null' || e=='')
                {
                    swal({
                        
                        type: 'warning',
                        title: 'Orden no encontrada!',
                        title: 'La Orden no existe o no se encuentra disponible para esta bodega.',
                        showConfirmButton: false,
                        timer: 3000
                    });
                }
                else distr.ShowOrderData(e);
            })
            .fail(function (e) {
                distr.showError(e);
            })
            .always(function () {
                $("#orden").removeAttr("disabled");
            });
    }

    Aceptar(){
        $('#btnDistribucion').attr("disabled", "disabled");
        var miAccion = "Aceptar";
        distr.lista = [];
        $('#tDistribucion tbody tr').each(function(i, item) {
            var objlista = new Object();
            objlista.idProducto= $(item).find('td:eq(0)')[0].textContent;
            objlista.cantidad= $(item).find('td:eq(4) input').val();
            objlista.costo= $(item).find('td:eq(5)').attr('value'); // costo: precio de venta para distrcion bodega externa. 
            objlista.valor= parseFloat(parseInt(objlista.cantidad) * parseFloat(objlista.costo)); // valor. costo*cantidad.
            distr.lista.push(objlista);
        });
        $.ajax({
            type: "POST",
            url: "class/Distribucion.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(distr.showInfo)
            .fail(function (e) {
                distr.showError(e);
            })
            .always(function () {
                $("#btnDistribucion").removeAttr("disabled");
                distr = new Distribucion();
                distr.CleanCtls();
                $("#p_searh").focus();
            });

    }

    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    ShowAll(e) {
        var t= $('#tDistribucion').DataTable();
        t.clear();
        t.rows.add(JSON.parse(e));
        // $('td:eq(4)').attr({ align: "right" });   
        t.order([1, 'desc']).draw();
        //$('.delete').click(distr.DeleteEventHandler);
        //$( "#tDistribucion tbody tr" ).live("click", distr.viewType==undefined || distr.viewType==distr.tUpdate ? distr.UpdateEventHandler : distr.SelectEventHandler);
        //
        //$( document ).on( 'click', '.update', distr.UpdateEventHandler);
        $( document ).on( 'click', '#tDistribucion tbody tr td:not(.buttons)', distr.viewType==undefined || distr.viewType==distr.tUpdate ? distr.UpdateEventHandler : distr.SelectEventHandler);
        // $( document ).on( 'click', '.delete', distr.DeleteEventHandler);
        // $( document ).on( 'click', '.open', distr.OpenEventHandler);
    };

    ShowOrderData(e) {
        // Limpia el controles
        this.CleanCtls();
        // carga objeto.
        var data = JSON.parse(e);
        distr = new Distribucion(data.id, data.orden, data.fecha, data.idUsuario, data.idBodega, data.porcentajeDescuento, data.porcentajeIva, data.lista);
        // datos
        $('#orden').val(distr.orden);
        $('#fecha').val(distr.fecha);
        bodega.id= distr.idBodega;
        bodega.Read;
        // carga lista.
        $.each(distr.lista, function (i, item) {
            producto= item;
            distr.AgregaProducto();
        });
    };

    ShowItemData(e){
        var data = JSON.parse(e);
        distr = new Distribucion(data.id, data.orden, data.fecha, data.idUsuario, data.idBodega, data.porcentajeDescuento, data.porcentajeIva, data.lista, data.bodega);
        $("#detalleDistribucion").empty();
        var detalleDistribucion =
            `<button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">X</span>
            </button>
            <h4 class="modal-title" id="myModalLabel">Traslado #${distr.orden}.</h4>
            <div class="row">
                
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <p>Fecha: ${distr.fecha}</p>
                </div>
            </div>
            <div class="row">                
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <p>Destino: ${distr.bodega}</p>
                </div>
            </div>`;
        $("#detalleDistribucion").append(detalleDistribucion);

        $("#totalDistribucion").empty();

        // var totalDistribucion =
        //     `<h4>Total: ¢${Math.round(0)}</h4>`;
        // $("#totalDistribucion").append(totalDistribucion);
        // detalle
        this.tb_prdXFact = $('#tb_detalle_distribucion').DataTable({
            data: distr.lista,
            destroy: true,
            "searching": false,
            "paging": false,
            "info": false,
            "ordering": false,
            // "retrieve": true,
            "order": [[0, "desc"]],
            columns: [
                {
                    title: "Codigo",
                    data: "codigo"
                },
                {
                    title: "Nombre",
                    data: "nombre"
                },
                {
                    title: "Cantidad",
                    data: "cantidad"
                },
                {
                    title: "Precio Venta",
                    data: "precioVenta"
                }
                // ,
                // {
                //     title: "Subtotal",
                //     data: "subtotal"
                // }
            ]
        });

        $('#modal').modal('toggle');

    }

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

    CleanCtls() {
        $("#p_searh").val('');
        $('#proveedor').val("");
        $('#orden').val("");
        var t = $('#tDistribucion').DataTable();
        t.rows().remove().draw();
        // totales
        $("#subtotal")[0].textContent = "¢0"; 
        $("#desc_val")[0].textContent = "¢0";
        $("#iv_val")[0].textContent = "¢0";
        $("#total")[0].textContent = "¢0";
        //bodega
         $('#nombre').val("");
         $('#descripcion').val("");

    };

    ResetSearch() {
        $("#p_searh").val('');
    };

    LoadProducto() {
        if ($("#p_searh").val() != ""){
            NProgress.start();
            $('#p_searh').attr("disabled", "disabled");
            producto.codigo =  $("#p_searh").val();
            //
            $.ajax({
                type: "POST",
                url: "class/Producto.php",
                data: {
                    action: "ReadByCode",
                    obj: JSON.stringify(producto)
                }
            })
            .done(function (e) {
                distr.ResetSearch();
                distr.ValidateProductoFac(e);
            })
            .fail(function (e) {
                distr.showError(e);
            })
            .always(function () {
                $("#p_searh").removeAttr("disabled");
                $("#p_searh").focus();
                NProgress.done();
            });
        }
    };

    ValidateProductoFac(e){
        if(e != "false"){
            producto = JSON.parse(e)[0];
            var tableRow = $("#tDistribucion tbody tr td").filter(function() {
                return $(this).text() == producto.id;
             }).length;
            if (tableRow==0)
                distr.AgregaProducto();
            else
                swal({
                type: 'warning',
                title: 'El producto '+ producto.codigo +' ya está en la lista.',
                showConfirmButton: false,
                timer: 3000
            });    
        }
        else{
            swal({
                type: 'warning',
                title: 'El producto '+ producto.codigo +' NO existe.',
                //text: 'Debe agregar el producto a la lista',
                showConfirmButton: false,
                timer: 3000
            });
        }
    };

    AgregaProducto(){
        var t = $('#tDistribucion').DataTable();
        var rowNode = t.row.add(producto)
            .draw()
            .node();     
        //
        $('td:eq(4) input', rowNode).attr({id: ("cantidad"+producto.id), value: (producto.cantidad || 1)}).change(function(){
             distr.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        }); 
        // Precio Venta
        // $('td:eq(4) input.valor', rowNode).attr({id: ("precioventa_v"+producto.codigo), style: "display:none", value: producto.precioVenta });
        // $('td:eq(4) input.display', rowNode).attr({id: ("precioventa_d"+producto.codigo), value: ("$"+parseFloat(producto.precioVenta).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")) });
        $('td:eq(5)', rowNode).attr({id: ("precioVenta"+producto.id), value: producto.precioVenta, align: "right" })[0]
            .textContent= ("¢"+parseFloat(producto.precioVenta).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        // subtotal
        // $('td:eq(5) input.valor', rowNode).attr({id: ("subtotal_v"+producto.codigo), style: "display:none"});
        // $('td:eq(5) input.display', rowNode).attr({id: ("subtotal_d"+producto.codigo)});   
        $('td:eq(6)', rowNode).attr({id: ("subtotal"+producto.id), value:0, align: "right" })[0].textContent=0;
        t.columns.adjust().draw();
        //
        distr.CalcImporte(producto.id);
        //distr.calcTotal();
    };

    UpdateEventHandler() {
        distr.id = $(this).parents("tr").find(".itemId").text() || $(this).find(".itemId").text();
        distr.Read;
    };

    DeleteEventHandler(btn){
        var t = $('#tDistribucion').DataTable();
        t.row( $(btn).parents('tr') )
        .remove()
        .draw();      
    }

    CalcImporte(prd){
        producto.cantidad =  $(`#cantidad${prd}`).val();
        producto.precioVenta = $(`#precioVenta${prd}`).attr('value');
        producto.subtotal= (producto.cantidad * producto.precioVenta).toFixed(10);
        // Subtotal de linea.
        $(`#subtotal${prd}`).attr({value: producto.subtotal});
        $(`#subtotal${prd}`)[0].textContent= ("¢"+parseFloat(producto.subtotal).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        //
        distr.calcTotal();
    };

    calcTotal(){
        // subtotal de la distribución.
        var subtotal=0; 
        distr.porcentajeDescuento=0;
        distr.porcentajeIva=13;
        //
        $('#desc_100').val(distr.porcentajeDescuento);
        $('#iv_100').val(distr.porcentajeIva);
        $("#subtotal")[0].textContent = "¢0"; 
        $("#desc_val")[0].textContent = "¢0";
        $("#iv_val")[0].textContent = "¢0";
        $("#total")[0].textContent = "¢0";
        //
        $('#tDistribucion tr').find('td:eq(6)').each(function(i, item) {
            subtotal +=   parseFloat($(item).attr('value'));
        });
        if(subtotal>0){
            $("#subtotal")[0].textContent= "¢"+ parseFloat(subtotal).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            // distr.descuento = subtotal * (parseFloat(distr.porcentajeDescuento).toFixed(2) / 100);
            distr.descuento = subtotal * (parseFloat(distr.porcentajeDescuento) / 100);
            $("#desc_val")[0].textContent= "¢"+ parseFloat(distr.descuento).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            distr.iva = subtotal * (parseFloat(distr.porcentajeIva) / 100);
            $("#iv_val")[0].textContent= "¢" + parseFloat(distr.iva).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            distr.total= subtotal - distr.descuento + distr.iva;
            $("#total")[0].textContent= "¢" + parseFloat(distr.total).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
    };

    setTable(buttons=true, nPaging=10){
        $('#tDistribucion').DataTable({
            responsive: true,
            info: false,
            iDisplayLength: nPaging,
            paging: false,
            "language": {
                "infoEmpty": "Sin Productos Ingresados",
                "emptyTable": "Sin Productos Ingresados",
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
            columns: [
                {
                    title: "id",
                    data: "id",
                    className: "itemId",
                    searchable: false
                },
                { title: "Codigo", data: "codigo" },
                { title: "Nombre", data: "nombre" },
                { title: "Descripción", data: "descripcion" },
                { 
                    title: "Cantidad", 
                    data: "cantidad",
                    // defaultContent: '<input class="cantidad form-control" type="number" min="1" max="9999999999" step="1" style="text-align:right;" >'
                    mRender: function () {
                        return '<input class="cantidad form-control" type="number" min="1" max="9999999999" step="1" style="text-align:right;" >'
                    }
                },
                { 
                    title: "Precio Venta", 
                    data: "precioVenta"
                },
                { 
                    title: "Subtotal", 
                    data: null
                },
                {
                    title: "Accion",
                    orderable: false,
                    searchable:false,
                    visible: buttons,
                    className: "buttons",
                    width: '5%',
                    mRender: function () {
                        return '<a class="delete" onclick="distr.DeleteEventHandler(this)" style="cursor: pointer;"> <i class="glyphicon glyphicon-trash"> </i>  </a>'                            
                    }
                }
            ]
        });
    };

    setTableVista(buttons=true){
        $('#tDistribucion').DataTable({
            responsive: true,
            info: false,
            iDisplayLength: 10,          
            "language": {
                "infoEmpty": "Sin Productos Ingresados",
                "emptyTable": "Sin Productos Ingresados",
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
            columns: [
                {
                    title: "id",
                    data: "id",
                    className: "itemId",                    
                    searchable: false
                },
                { title: "Fecha", data: "fecha" },
                { title: "Orden", data: "orden" },
                { title: "Usuario", data: "userName" },
                { title: "Bodega", data: "bodega" },
                { 
                    title: "Total", 
                    data: "total",
                    className: "text-right",
                    // className: "total",
                    mRender: function ( e ) {
                        return '¢'+ parseFloat(e).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ".")
                    }
                },
                { 
                    title: "Estado", 
                    data: "estado"
                },
                {
                    title: "Accion",
                    orderable: false,
                    searchable:false,
                    visible: buttons,
                    className: "buttons",
                    width: '5%',
                    mRender: function () {
                        return '<a class="delete" style="cursor: pointer;"> <i class="glyphicon glyphicon-trash delete"> </i>  </a>'                            
                    }
                }
            ]
        });
    };

}


let distr = new Distribucion();