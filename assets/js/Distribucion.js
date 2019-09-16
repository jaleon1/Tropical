class Distribucion {
  // Constructor
  constructor(
    id,
    orden,
    fechaCreacion,
    idUsuario,
    idBodega,
    porcentajeDescuento,
    porcentajeIva,
    detalleFactura,
    bodega,
    fechaInicial,
    fechaFinal,
    totalImpuesto,
    totalComprobante,
    tDistribucion
  ) {
    this.id = id || null;
    this.orden = orden || '';
    this.fechaCreacion = fechaCreacion || '';
    this.idUsuario = idUsuario || null;
    this.idBodega = idBodega || null;
    this.bodega = bodega || null;
    this.porcentajeDescuento = porcentajeDescuento || 0;
    this.porcentajeIva = porcentajeIva || 0;
    this.totalImpuesto = totalImpuesto || 0;
    this.totalComprobante = totalComprobante || 0;
    this.detalleFactura = detalleFactura || [];
    this.fechaInicial = fechaInicial || '';
    this.fechaFinal = fechaFinal || '';
    this.tDistribucion = tDistribucion || null;
  }

  get tUpdate() {
    return (this.update = 'update');
  }

  get tSelect() {
    return (this.select = 'select');
  }

  set viewEventHandler(_t) {
    this.viewType = _t;
  }

  get Read() {
    NProgress.start();
    var miAccion = this.id == null ? 'ReadAll' : 'Read';
    if (miAccion == 'ReadAll' && $('#tDistribucion tbody').length == 0) return;
    $.ajax({
      type: 'POST',
      url: 'class/Distribucion.php',
      data: {
        action: miAccion,
        id: this.id
      }
    })
      .done(function(e) {
        distr.Reload(e);
      })
      .fail(function(e) {
        distr.showError(e);
      })
      .always(NProgress.done());
  }

  get Save() {
    if ($('#tDistribucion tbody tr').length == 0) {
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
    $('#btnDistribucion').attr('disabled', 'disabled');
    var miAccion = distr.id == null ? 'Create' : 'Update';
    //
    distr.totalVenta = 0;
    distr.totalDescuentos = 0;
    distr.totalVentaneta = 0;
    distr.totalImpuesto = 0;
    distr.totalComprobante = 0;
    distr.detalleFactura = [];
    $('#tDistribucion tbody tr').each(function(i, item) {
      var objlista = new Object();
      objlista.idProducto = $(item).find('td:eq(0)')[0].textContent; // id del item.
      objlista.codigo = $(this)
        .find('td:eq(1)')
        .html();
      objlista.valor = $(item)
        .find('td:eq(6)')
        .attr('value'); // valor: precio de venta para distribucióncion bodega externa.
      // campos de facturación electrónica.
      objlista.cantidad = parseFloat(
        $(item)
          .find('td:eq(5) input')
          .val()
      );
      objlista.detalle = objlista.codigo;
      objlista.precioUnitario = parseFloat(
        parseFloat(objlista.valor).toFixed(5)
      );
      objlista.numeroLinea = i + 1;
      objlista.idTipoCodigo = 1; // 1 = codigo de vendedor
      objlista.codigo = objlista.codigo;
      objlista.idUnidadMedida = 78; // 78 =  unidades.
      objlista.montoTotal = parseFloat(
        (objlista.precioUnitario * objlista.cantidad).toFixed(5)
      );
      objlista.montoDescuento = 0;
      objlista.naturalezaDescuento = 'No aplican descuentos';
      objlista.subTotal = parseFloat(
        (objlista.montoTotal - objlista.montoDescuento).toFixed(5)
      );
      //
      // objlista.codigoImpuesto = 1; // 1 = Impuesto General sobre las Ventas.
      // objlista.tarifaImpuesto = 13;
      //
      // objlista.montoImpuesto = parseFloat((objlista.subTotal * (objlista.tarifaImpuesto / 100)).toFixed(5)); // debe tomar el impuesto como parametro de un tabla).
      // objlista.montoTotalLinea = parseFloat((objlista.subTotal + objlista.montoImpuesto).toFixed(5));
      //
      // iva
      //
      objlista.impuestos = [];
      var montoTotalImpuestosLinea = 0; // sumatoria de iva de la linea.
      //if(/* TIENE IMPUESTOS */){
      var impuesto = new Object();
      impuesto.idCodigoImpuesto = 1; // 1 = Impuesto Valor Agregado.
      impuesto.idCodigoTarifa = 8;
      impuesto.tarifa = 13;
      impuesto.monto = parseFloat(
        (objlista.subTotal * (impuesto.tarifa / 100)).toFixed(5)
      );
      montoTotalImpuestosLinea += impuesto.monto;

      objlista.montoTotalLinea = parseFloat(
        (objlista.subTotal + montoTotalImpuestosLinea).toFixed(5)
      );
      objlista.impuestos.push(impuesto);
      // actualiza totales de distr.
      distr.totalVenta = parseFloat(
        (distr.totalVenta + objlista.montoTotal).toFixed(5)
      );
      distr.totalDescuentos = parseFloat(
        (distr.totalDescuentos + objlista.montoDescuento).toFixed(5)
      );
      distr.totalImpuesto = parseFloat(
        (distr.totalImpuesto + montoTotalImpuestosLinea).toFixed(5)
      );
      //
      distr.detalleFactura.push(objlista);
    });
    //
    distr.totalServGravados = 0;
    distr.totalServExentos = 0;
    distr.totalMercanciasGravadas = distr.totalVenta;
    distr.totalMercanciasExentas = 0;
    distr.totalGravado = parseFloat(
      (distr.totalServGravados + distr.totalMercanciasGravadas).toFixed(5)
    );
    distr.totalExento = parseFloat(
      (distr.totalServExentos + distr.totalMercanciasExentas).toFixed(5)
    );
    distr.totalVenta = parseFloat(
      (distr.totalGravado + distr.totalExento).toFixed(5)
    );
    // total venta neta.
    distr.totalVentaneta = parseFloat(
      (distr.totalVenta - distr.totalDescuentos).toFixed(5)
    );
    // total comprobante.
    distr.totalComprobante = parseFloat(
      (distr.totalVentaneta + distr.totalImpuesto).toFixed(5)
    );
    distr.idReceptor = bodega.id;
    //
    distr.orden = $('#orden').val();
    distr.idBodega = bodega.id;
    distr.porcentajeDescuento = $('#desc_100').val();
    distr.porcentajeIva = $('#iv_100').val();
    //
    $.ajax({
      type: 'POST',
      url: 'class/Distribucion.php',
      data: {
        action: miAccion,
        obj: JSON.stringify(this)
      }
    })
      .done(function(e) {
        // muestra el numero de orden: IMPRIMIR.
        if (JSON.parse(e) == 'NORECEPTOR') {
          swal({
            type: 'warning',
            title: 'Receptor',
            text: 'Receptor no registrado para Facturación Electrónica',
            allowOutsideClick: false
          });
        } else if (JSON.parse(e) == 'NOCONTRIB') {
          swal({
            type: 'warning',
            title: 'Contibuyente',
            text: 'Emisor no registrado para Facturación Electrónica',
            allowOutsideClick: false
          });
        } else distr.ticketPrint(e);
        // var data = JSON.parse(e)[0];
        // swal({
        //     type: 'success',
        //     title: 'Número de Orden:' + data.orden,
        //     text: 'Número de orden de Distribución:',
        //     showConfirmButton: true
        // });
      })
      .fail(function(e) {
        distr.showError(e);
      })
      .always(function() {
        $('#btnDistribucion').removeAttr('disabled');
        distr = new Distribucion();
        distr.CleanCtls();
        $('#p_searh').focus();
      });
  }

  ticketPrint(e) {
    if (bodega.tipo == 'Interna')
      localStorage.setItem('lsTipoBodega', 'interna');
    else localStorage.setItem('lsTipoBodega', 'externa');

    var data = JSON.parse(e);
    localStorage.setItem('lsRePrint', false);
    localStorage.setItem('lsOrden', data.orden);
    localStorage.setItem('lsBodega', $('#nombre').val());
    localStorage.setItem('lsDescripcion', $('#descripcion').val());
    localStorage.setItem('lsSubTotal', $('#subtotal').text());
    localStorage.setItem('lsTotal', $('#total').text());
    localStorage.setItem('lsFechaDistribucion', data.fechaCreacion);
    localStorage.setItem('lsPorcentajeDescuento', $('#desc_val').text());
    localStorage.setItem('lsIV', $('#iv_val').text());
    localStorage.setItem(
      'lsListaProducto',
      JSON.stringify(data.detalleFactura)
    );
    localStorage.setItem('lsUsuarioDistribucion', $('#call_username').text());
    localStorage.setItem('lsClaveDis', data.clave);
    location.href = '/TicketDistribucion.html';
  }

  ticketRePrint() {
    var listaProducto = [];
    var subtotal = 0;
    var iv = 0;
    if (bodega.tipo == 'Externa')
      localStorage.setItem('lsTipoBodega', 'externa');
    else localStorage.setItem('lsTipoBodega', 'interna');

    $('#tb_detalle_distribucion tbody tr').each(function() {
      var lsListaProducto = new Object();
      lsListaProducto.cantidad = $(this)
        .find('td:eq(2)')
        .html();
      lsListaProducto.codigo = $(this)
        .find('td:eq(0)')
        .html();
      lsListaProducto.montoTotal =
        parseFloat(
          $(this)
            .find('td:eq(3)')
            .html()
            .replace('¢', '')
            .replace(',', '')
        ) * lsListaProducto.cantidad;
      lsListaProducto.montoTotal =
        '¢' +
        parseFloat(lsListaProducto.montoTotal)
          .toFixed(2)
          .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
      subtotal =
        subtotal +
        parseFloat(
          $(this)
            .find('td:eq(3)')
            .html()
            .replace('¢', '')
            .replace(',', '')
        ) *
          lsListaProducto.cantidad;
      listaProducto.push(lsListaProducto);
    });
    localStorage.setItem('lsListaProducto', JSON.stringify(listaProducto));
    localStorage.setItem('lsRePrint', true);
    localStorage.setItem(
      'lsSubTotal',
      '¢' +
        parseFloat(subtotal)
          .toFixed(2)
          .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
    );
    localStorage.setItem(
      'lsIV',
      '¢' +
        parseFloat(subtotal * 0.13)
          .toFixed(2)
          .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
    );
    localStorage.setItem('lsTotal', $('#total').text());
    localStorage.setItem('lsFechaDistribucion', $('#fechaDistribucion').text());
    localStorage.setItem('lsBodega', $('#bodega').text());
    localStorage.setItem('lsOrden', $('#consecutivo').text());
    localStorage.setItem('lsUsuarioDistribucion', $('#call_username').text());

    // location.href ="/TicketDistribucion.html";
    location.href = '/TicketDistribucion.html';
  }

  get ReadbyOrden() {
    $('#orden').attr('disabled', 'disabled');
    var miAccion = 'ReadbyOrden';
    distr.orden = $('#p_searh').val();
    $.ajax({
      type: 'POST',
      url: 'class/Distribucion.php',
      data: {
        action: miAccion,
        obj: JSON.stringify(this)
      }
    })
      .done(function(e) {
        if (e == 'null' || e == '') {
          swal({
            type: 'warning',
            title: 'Orden no encontrada!',
            title:
              'La Orden no existe o no se encuentra disponible para esta bodega.',
            showConfirmButton: false,
            timer: 3000
          });
        } else distr.ShowOrderData(e);
      })
      .fail(function(e) {
        distr.showError(e);
      })
      .always(function() {
        $('#orden').removeAttr('disabled');
      });
  }

  Aceptar() {
    $('#btnDistribucion').attr('disabled', 'disabled');
    var miAccion = 'Aceptar';
    distr.detalleFactura = [];
    $('#tDistribucion tbody tr').each(function(i, item) {
      var objlista = new Object();
      objlista.idProducto = $(item).find('td:eq(0)')[0].textContent;
      objlista.cantidad = $(item)
        .find('td:eq(5) input')
        .val();
      objlista.costo = $(item)
        .find('td:eq(6)')
        .attr('value'); // costo: precio de venta para distrcion bodega externa.
      objlista.valor = parseFloat(
        parseInt(objlista.cantidad) * parseFloat(objlista.costo)
      ); // valor. costo*cantidad.
      distr.detalleFactura.push(objlista);
    });
    $.ajax({
      type: 'POST',
      url: 'class/Distribucion.php',
      data: {
        action: miAccion,
        obj: JSON.stringify(this)
      }
    })
      .done(distr.showInfo)
      .fail(function(e) {
        distr.showError(e);
      })
      .always(function() {
        $('#btnDistribucion').removeAttr('disabled');
        distr = new Distribucion();
        distr.CleanCtls();
        $('#p_searh').focus();
      });
  }

  Reload(e) {
    if (this.id == null) this.ShowAll(e);
    else this.ShowItemData(e);
  }

  ShowAll(e) {
    var t = $('#tDistribucion').DataTable();
    t.clear();
    t.rows.add(JSON.parse(e));
    // $('td:eq(5)').attr({ align: "right" });
    t.order([1, 'desc']).draw();
    //$('.delete').click(distr.DeleteEventHandler);
    //$( "#tDistribucion tbody tr" ).live("click", distr.viewType==undefined || distr.viewType==distr.tUpdate ? distr.UpdateEventHandler : distr.SelectEventHandler);
    //

    //$( document ).on( 'click', '.update', distr.UpdateEventHandler);
    // $(document).on('click', '#tDistribucion tbody tr td:not(.buttons)', distr.viewType == undefined || distr.viewType == distr.tUpdate ? distr.UpdateEventHandler : distr.SelectEventHandler);
    // $( document ).on( 'click', '.delete', distr.DeleteEventHandler);
    // $( document ).on( 'click', '.open', distr.OpenEventHandler);
  }

  ShowOrderData(e) {
    // Limpia el controles
    this.CleanCtls();
    // carga objeto.
    var data = JSON.parse(e);
    distr = new Distribucion(
      data.id,
      data.orden,
      data.fechaCreacion,
      data.idUsuario,
      data.idBodega,
      data.porcentajeDescuento,
      data.porcentajeIva,
      data.detalleFactura
    );
    // datos
    $('#orden').val(distr.orden);
    $('#fechaCreacion').val(distr.fechaCreacion);
    bodega.id = distr.idBodega;
    bodega.Read;
    // carga lista.
    $.each(distr.detalleFactura, function(i, item) {
      producto = item;
      distr.AgregaProducto();
    });
  }

  ShowItemData(e) {
    $('#mensajeRechazo').text('');
    var data = JSON.parse(e);
    localStorage.setItem('lsClaveDis', data.clave);
    distr = new Distribucion(
      data.id,
      data.orden,
      data.fechaCreacion,
      data.idUsuario,
      data.idBodega,
      data.porcentajeDescuento,
      data.porcentajeIva,
      data.detalleFactura,
      data.bodega
    );
    distr.totalComprobante = data.totalComprobante;
    distr.totalImpuesto = data.totalImpuesto;
    //
    var detalleDistribucion = null;
    $('#detalleDistribucion').empty();
    if (data.orden == data.idReferencia) {
      detalleDistribucion = `<button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">X</span>
            </button>
            <h4 class="modal-title" id="myModalLabel">Traslado #<label id=consecutivo>${
              distr.orden
            }</label></h4>
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <p>Fecha: <label id=fechaDistribucion>${
                      distr.fechaCreacion
                    }</label></p>
                </div>
            </div>
            <div class="row">                
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <p>Destino: <label id=bodega>${distr.bodega}</label></p>
                </div>
            </div>
            <div class="row">                
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <p>TOTAL: <label id=total>${'¢' +
                      parseFloat(distr.totalComprobante)
                        .toFixed(2)
                        .replace(/\B(?=(\d{3})+(?!\d))/g, '.')}</label></p>
                </div>
            </div>
            <div class="row">                
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <p>Clave Factura: <label id=clave>${data.clave}</label></p>
                </div>
            </div>
            <div class="row">                
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <p>Clave Nota de Credito: <label id=claveNC>${
                      data.claveNC
                    }</label></p>
                </div>
            </div>`;
    } else {
      detalleDistribucion = `<button type="button" class="close" data-dismiss="modal">
                <span aria-hidden="true">X</span>
            </button>
            <h4 class="modal-title" id="myModalLabel">Traslado #<label id=consecutivo>${
              distr.orden
            }</label></h4>
            <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <p>Fecha: <label id=fechaDistribucion>${
                      distr.fechaCreacion
                    }</label></p>
                </div>
            </div>
            <div class="row">                
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <p>Destino: <label id=bodega>${distr.bodega}</label></p>
                </div>
            </div>
            <div class="row">                
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <p>TOTAL: <label id=total>${'¢' +
                      parseFloat(distr.totalComprobante)
                        .toFixed(2)
                        .replace(/\B(?=(\d{3})+(?!\d))/g, '.')}</label></p>
                </div>
            </div>
            <div class="row">                
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <p>Clave Factura: <label id=clave>${data.clave}</label></p>
                </div>
            </div>`;
    }
    $('#detalleDistribucion').append(detalleDistribucion);
    $('#totalDistribucion').empty();

    // detalle
    this.tb_prdXFact = $('#tb_detalle_distribucion').DataTable({
      data: distr.detalleFactura,
      destroy: true,
      searching: false,
      paging: false,
      info: false,
      ordering: false,
      // "retrieve": true,
      order: [[0, 'desc']],
      columns: [
        {
          title: 'CODIGO',
          data: 'codigo'
        },
        {
          title: 'NOMBRE',
          data: 'nombre'
        },
        {
          title: 'CANTIDAD',
          data: 'cantidad'
        },
        {
          title: 'PRECIO VENTA',
          data: 'montoTotal',
          className: 'text-right',
          mRender: function(e) {
            return (
              '¢' +
              parseFloat(e)
                .toFixed(2)
                .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
            );
          }
        },
        {
          title: 'IV',
          data: 'montoImpuesto',
          className: 'text-right',
          mRender: function(e) {
            return (
              '¢' +
              parseFloat(e)
                .toFixed(2)
                .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
            );
          }
        },
        {
          title: 'SUBTOTAL',
          data: 'subTotal',
          className: 'text-right',
          mRender: function(e) {
            return (
              '¢' +
              parseFloat(e)
                .toFixed(2)
                .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
            );
          }
        }
      ]
    });
    distr.ReadRespuestaRachazo(
      data.id,
      data.idEstadoComprobante,
      data.idEstadoNC
    );
    $('#modalDistribucion').modal('toggle');
  }

  // Muestra información en ventana
  showInfo() {
    //$(".modal").css({ display: "none" });
    $('.close').click();
    swal({
      type: 'success',
      title: 'Listo!',
      showConfirmButton: false,
      timer: 1000
    });
  }

  // Muestra errores en ventana
  showError(e) {
    //$(".modal").css({ display: "none" });
    var data = JSON.parse(e.responseText);
    swal({
      type: 'error',
      title: 'Oops...',
      text: 'Algo no está bien (' + data.code + '): ' + data.msg,
      footer: '<a href>Contacte a Soporte Técnico</a>'
    });
  }

  CleanCtls() {
    $('#p_searh').val('');
    $('#proveedor').val('');
    $('#orden').val('');
    var t = $('#tDistribucion').DataTable();
    t.rows()
      .remove()
      .draw();
    // totales
    $('#subtotal')[0].textContent = '¢0';
    $('#desc_val')[0].textContent = '¢0';
    $('#iv_val')[0].textContent = '¢0';
    $('#total')[0].textContent = '¢0';
    //bodega
    $('#nombre').val('');
    $('#descripcion').val('');
  }

  ResetSearch() {
    $('#p_searh').val('');
  }

  LoadProducto() {
    if ($('#p_searh').val() != '') {
      NProgress.start();
      $('#p_searh').attr('disabled', 'disabled');
      producto.codigo = $('#p_searh').val();
      //
      $.ajax({
        type: 'POST',
        url: 'class/Producto.php',
        data: {
          action: 'ReadByCode',
          obj: JSON.stringify(producto)
        }
      })
        .done(function(e) {
          distr.ResetSearch();
          distr.ValidateProductoFac(e);
        })
        .fail(function(e) {
          distr.showError(e);
        })
        .always(function() {
          $('#p_searh').removeAttr('disabled');
          $('#p_searh').focus();
          NProgress.done();
        });
    }
  }

  ValidateProductoFac(e) {
    if (e != 'false') {
      producto = JSON.parse(e)[0];
      var tableRow = $('#tDistribucion tbody tr td').filter(function() {
        return $(this).text() == producto.id;
      }).length;
      if (producto.saldoCantidad <= 0) {
        swal({
          type: 'warning',
          title: 'Determinación de Producto',
          text: 'El producto No tiene Saldo.',
          showConfirmButton: false,
          timer: 3000
        });
      } else {
        if (tableRow == 0) distr.AgregaProducto();
        else
          swal({
            type: 'warning',
            title: 'El producto ' + producto.codigo + ' ya está en la lista.',
            showConfirmButton: false,
            timer: 3000
          });
      }
    } else {
      swal({
        type: 'warning',
        title: 'El producto ' + producto.codigo + ' NO existe.',
        //text: 'Debe agregar el producto a la lista',
        showConfirmButton: false,
        timer: 3000
      });
    }
  }

  AgregaProducto() {
    var t = $('#tDistribucion').DataTable();
    var rowNode = t.row
      .add(producto)
      .draw()
      .node();
    //
    $('td:eq(4)', rowNode).attr({
      id: 'saldoCantidad' + producto.id,
      value: producto.saldoCantidad,
      align: 'right'
    })[0].textContent = parseFloat(producto.saldoCantidad)
      .toFixed(2)
      .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    $('td:eq(5) input', rowNode)
      .attr({
        id: 'cantidad' + producto.id,
        max: producto.saldoCantidad,
        min: '1',
        step: '1',
        value: producto.cantidad || 1
      })
      .on('keyup keypress mouseup', function(e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode == 109) {
          e.preventDefault();
          return false;
        }
        distr.setProducto(
          $(this)
            .parents('tr')
            .find('td:eq(0)')
            .html()
        );
        if (producto.saldoCantidad < producto.cantidad) {
          swal({
            type: 'warning',
            title: 'Saldo Insuficiente',
            text:
              'El producto contiene unicamente ' +
              producto.saldoCantidad +
              ' unidades',
            showConfirmButton: false,
            timer: 3000
          });
          $(this).val(producto.saldoCantidad);
          distr.setProducto(
            $(this)
              .parents('tr')
              .find('td:eq(0)')
              .html()
          );
        }
        distr.CalcImporte();
      });
    // Precio Venta
    $('td:eq(6)', rowNode).attr({
      id: 'precioVenta' + producto.id,
      value: producto.precioVenta / 1.13,
      align: 'right'
    })[0].textContent =
      '¢' +
      parseFloat(producto.precioVenta / 1.13)
        .toFixed(2)
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    // subtotal
    $('td:eq(7)', rowNode).attr({
      id: 'subtotal' + producto.id,
      value: 0,
      align: 'right'
    })[0].textContent = 0;
    t.columns.adjust().draw();
    //
    // $(".cantidad").bind('keyup mouseup', function () {
    //     distr.CalcImporte();
    // });
    //
    distr.setProducto(producto.id);
    distr.CalcImporte();
  }

  UpdateEventHandler() {
    distr.id =
      $(this)
        .parents('tr')
        .find('.itemId')
        .text() ||
      $(this)
        .find('.itemId')
        .text();
    if (
      $(this)
        .parents('tr')
        .find('td:eq(7)')
        .text() == 'Externa'
    )
      bodega.tipo = 'Externa';
    else bodega.tipo = 'Interna';
    distr.Read;
  }

  DeleteEventHandler(btn) {
    var t = $('#tDistribucion').DataTable();
    t.row($(btn).parents('tr'))
      .remove()
      .draw();
    // recalcula
    distr.setProducto(
      $(btn)
        .parents('tr')
        .find('td:eq(0)')
        .html()
    );
    distr.calcTotal();
  }

  DeleteDistr(e) {
    distr.estado = $(e)
      .parents('tr')
      .find('td:eq(6)')
      .text();
    if (distr.estado != 'LIQUIDADO') {
      swal({
        type: 'warning',
        title: 'Distribución',
        text:
          'No es posible Eliminar una orden de Distribución sin ACEPTAR o CANCELADA.',
        allowOutsideClick: false
      });
    } else {
      swal({
        title: 'Eliminar?',
        text: 'Esta acción es irreversible!',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Si, eliminar!',
        cancelButtonText: 'No, cancelar!',
        confirmButtonClass: 'btn btn-success',
        cancelButtonClass: 'btn btn-danger'
      }).then(result => {
        if (result.value) {
          distr.id = $(e)
            .parents('tr')
            .find('.itemId')
            .text();
          distr.orden = $(e)
            .parents('tr')
            .find('td:eq(2)')
            .text();
          $.ajax({
            type: 'POST',
            url: 'class/Distribucion.php',
            data: {
              action: 'Delete',
              id: distr.id,
              orden: distr.orden
            }
          })
            .done(distr.showInfo)
            .fail(function(e) {
              distr.showError(e);
            })
            .always(function() {
              //$("#btndistr").removeAttr("disabled");
              distr = new Distribucion();
              //distr.CleanCtls();
              //$("#p_searh").focus();
              distr.CargaTrasladosRango();
            });
        }
      });
      // t.row( $(e).parents('tr') )
      // .remove()
      // .draw();
    }
  }

  setProducto(idp) {
    producto.id = idp;
    producto.saldoCantidad = parseFloat(
      $(`#saldoCantidad${idp}`).attr('value')
    );
    producto.cantidad = $(`#cantidad${idp}`).val();
    producto.precioVenta = parseFloat($(`#precioVenta${idp}`).attr('value'));
    producto.subtotal = (producto.cantidad * producto.precioVenta).toFixed(10);
  }

  CalcImporte() {
    // Subtotal de linea.
    $(`#subtotal${producto.id}`).attr({
      value: producto.subtotal
    });
    $(`#subtotal${producto.id}`)[0].textContent =
      '¢' +
      parseFloat(producto.subtotal)
        .toFixed(2)
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    //
    distr.calcTotal();
  }

  calcTotal() {
    // subtotal de la distribución.
    var subtotal = 0;
    distr.porcentajeDescuento = 0;
    distr.porcentajeIva = 13;
    //
    $('#desc_100').val(distr.porcentajeDescuento);
    $('#iv_100').val(distr.porcentajeIva);
    $('#subtotal')[0].textContent = '¢0';
    $('#desc_val')[0].textContent = '¢0';
    $('#iv_val')[0].textContent = '¢0';
    $('#total')[0].textContent = '¢0';
    //
    $('#tDistribucion tr')
      .find('td:eq(7)')
      .each(function(i, item) {
        subtotal += parseFloat($(item).attr('value'));
      });
    if (subtotal > 0) {
      $('#subtotal')[0].textContent =
        '¢' +
        parseFloat(subtotal)
          .toFixed(2)
          .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
      // distr.descuento = subtotal * (parseFloat(distr.porcentajeDescuento).toFixed(2) / 100);
      distr.descuento =
        subtotal * (parseFloat(distr.porcentajeDescuento) / 100);
      $('#desc_val')[0].textContent =
        '¢' +
        parseFloat(distr.descuento)
          .toFixed(2)
          .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
      distr.iva = subtotal * (parseFloat(distr.porcentajeIva) / 100);
      $('#iv_val')[0].textContent =
        '¢' +
        parseFloat(distr.iva)
          .toFixed(2)
          .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
      distr.totalComprobante = subtotal - distr.descuento + distr.iva;
      $('#total')[0].textContent =
        '¢' +
        parseFloat(distr.totalComprobante)
          .toFixed(2)
          .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }
  }

  setTable(buttons = true, nPaging = 10) {
    $('#tDistribucion').DataTable({
      responsive: true,
      info: false,
      iDisplayLength: nPaging,
      paging: false,
      language: {
        infoEmpty: 'Sin Productos Ingresados',
        emptyTable: 'Sin Productos Ingresados',
        search: 'Buscar',
        zeroRecords: 'No hay resultados',
        lengthMenu: 'Mostrar _MENU_ registros',
        paginate: {
          first: 'Primera',
          last: 'Ultima',
          next: 'Siguiente',
          previous: 'Anterior'
        }
      },
      columnDefs: [
        {
          className: 'text-center',
          targets: [4]
        }
      ],
      columns: [
        {
          title: 'ID',
          data: 'id',
          className: 'itemId',
          searchable: false
        },
        {
          title: 'CODIGO',
          data: 'codigo'
        },
        {
          title: 'NOMBRE',
          data: 'nombre'
        },
        {
          title: 'DESCRIPCION',
          data: 'descripcion'
        },
        {
          title: 'SALDO CANTIDAD',
          data: 'saldoCantidad'
        },
        {
          title: 'CANTIDAD',
          data: 'cantidad',
          // defaultContent: '<input class="cantidad form-control" type="number" min="1" max="9999999999" step="1" style="text-align:right;" >'
          mRender: function() {
            return '<input class="cantidad form-control" type="number" min="1" max="9999999999" step="1" style="text-align:right;" >';
          }
        },
        {
          title: 'PRECIO VENTA',
          data: 'precioVenta'
        },
        {
          title: 'SUBTOTAL',
          data: null
        },
        {
          title: 'ACCION',
          orderable: false,
          searchable: false,
          visible: buttons,
          className: 'buttons',
          width: '5%',
          mRender: function() {
            return '<a class="delete" onclick="distr.DeleteEventHandler(this)" style="cursor: pointer;"> <i class="glyphicon glyphicon-trash"> </i>  </a>';
          }
        }
      ]
    });
  }

  sendContingenciaMasiva() {
    $.ajax({
      type: 'POST',
      url: 'class/Distribucion.php',
      data: {
        action: 'sendContingenciaMasiva'
      }
    }).done(function(e) {
      distr.CargaTrasladosRango();
    });
  }

  drawDistribucion(e) {
    var distribuciones = JSON.parse(e);
    $('#tDistribucion').DataTable({
      footerCallback: function(row, data, start, end, display) {
        var api = this.api();
        // Remueve el formato de la columna
        var intVal = function(i) {
          return typeof i === 'string'
            ? parseFloat(i.replace(/[\¢,]/g, ''))
            : typeof i === 'number'
            ? i
            : 0;
        };
        // Total de todas las paginas filtradas
        var subTotal = display
          .map(el => data[el]['totalComprobante'])
          .reduce((a, b) => intVal(a) + intVal(b), 0);

        // Actualiza el footer
        $(api.column(1).footer()).html('TOTALES');
        $(api.column(5).footer()).html(
          '¢' +
            parseFloat(Number(subTotal))
              .toFixed(2)
              .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
        );
      },
      responsive: true,
      destroy: true,
      order: [[1, 'desc']],
      dom: 'Bfrtip',
      buttons: [
        {
          extend: 'excelHtml5',
          exportOptions: { columns: [1, 2, 3, 4, 5, 6] },
          messageTop: 'Traslados y facturación'
        },
        {
          extend: 'pdfHtml5',
          messageTop: 'Traslados y facturación',
          exportOptions: {
            columns: [1, 2, 3, 4, 5, 6]
          }
        }
      ],
      language: {
        infoEmpty: 'Sin Traslados Registrados',
        emptyTable: 'Sin Traslados Registrados',
        search: 'Buscar',
        zeroRecords: 'No hay resultados',
        lengthMenu: 'Mostrar _MENU_ registros',
        paginate: {
          first: 'Primera',
          last: 'Ultima',
          next: 'Siguiente',
          previous: 'Anterior'
        }
      },
      data: distribuciones,
      columns: [
        {
          title: 'ID',
          data: 'id',
          className: 'itemId',
          searchable: false
        },
        {
          title: 'FECHA',
          data: 'fechaCreacion'
        },
        {
          title: 'ORDEN',
          data: 'orden'
        },
        {
          title: 'USUARIO',
          data: 'userName'
        },
        {
          title: 'BODEGA',
          data: 'bodega'
        },
        {
          title: 'TOTAL',
          data: 'totalComprobante',
          className: 'text-right',
          // className: "total",
          mRender: function(e) {
            return (
              '¢' +
              parseFloat(e)
                .toFixed(2)
                .replace(/\B(?=(\d{3})+(?!\d))/g, '.')
            );
          }
        },
        {
          title: 'ESTADO',
          data: 'idEstadoComprobante',
          render: function(data, type, row, meta) {
            if (row['claveNC'] != null) data = row['idEstadoNC'];
            if (row['tipoBodega'] != 'Interna')
              switch (data) {
                case '1':
                  return '<i class="fa fa-paper-plane" aria-hidden="true" style="color:red"> Sin Enviar</i>';
                  break;
                case '2':
                  return '<i class="fa fa-paper-plane" aria-hidden="true" style="color:green"> Enviado</i>';
                  break;
                case '3':
                  return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green"> Aceptado</i>';
                  break;
                case '4':
                  return '<i class="fa fa-times-circle" aria-hidden="true" style="color:red"> Rechazado</i>';
                  break;
                case '5':
                  return '<i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:#FF6F00"> Otro</i>';
                  break;
                case '99':
                  return '<i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:green"> Reportado</i>';
                  break;
                default:
                  return 'Desconocido';
                  break;
              }
            else
              return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green"> Interna</i>';
          }
        },
        {
          title: 'TIPO BODEGA',
          data: 'tipoBodega'
        },
        {
          title: 'ACCION',
          className: 'buttons',
          data: 'claveNC',
          render: function(data, type, row, meta) {
            if (row['tipoBodega'] != 'Interna')
              if (data == null)
                switch (row['idEstadoComprobante']) {
                  case '1':
                    return '<button class=btnEnviarFactura>&nbsp Enviar</button>'; // Sin enviar // No se envio en el momento, no salio del sistema local No llego a MH //Envio en Contingencia
                    break;
                  case '2':
                    return '<i class="fa fa-check-square-o">&nbsp Enviada</i>'; // Enviado //Quitar Boton y que diga enviado
                    break;
                    idEstadoNC;
                  case '3':
                    return '<button class=btnCancelaFactura>&nbsp Cancelar Factura</button>'; // Aceptado  //Solo cancelar // NC
                    break;
                  case '4':
                    return '<button class=btnNC_CreateFact_Ref>&nbsp Cancelar & Reenviar</button>'; // Rechazado //NC //Nueva con referencia Confeccion de Factura  // BTNCancelar y enviar
                    break;
                  case '5':
                    return '<i class="fa fa-cloud-upload" aria-hidden="true">&nbsp Enviar Contingencia</i>'; // Error (Otros) //Envio en Contingencia
                    break;
                  default:
                    return '<button>Soporte</button>';
                    break;
                }
              else
                return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green">Factura Cancelada por NC!</i>';
            // return '<i class="fa fa-check-square-o" aria-hidden="true" style="color:green"> Interna</i>'
            else
              return '<button class=btn_ReversarDistribucionInterna>&nbsp Cancelar Interna</button>';
          }
        },
        {
          title: 'ESTADO NC',
          data: 'idEstadoNC',
          visible: false
        }
      ]
    });
  }

  CargaTrasladosRango() {
    var referenciaCircular = distr.tDistribucion;
    distr.tDistribucion = [];
    $.ajax({
      type: 'POST',
      url: 'class/Distribucion.php',
      data: {
        action: 'ReadAllbyRange',
        obj: JSON.stringify(distr)
      }
    })
      .done(function(e) {
        distr.tDistribucion = referenciaCircular;
        distr.drawDistribucion(e);
      })
      .fail(function(e) {
        distr.showError(e);
      });
  }

  ReadRespuestaRachazo(idFactura, idEstadoComprobante, idEstadoNC) {
    var resultado = '';
    // var referenciaCircular = inventarioFacturas.tb_facturas;
    // inventarioFacturas.tb_facturas = [];
    var estadoComprobante = parseInt(idEstadoComprobante);
    var estadoNC = parseInt(idEstadoNC);

    if (estadoComprobante <= 3 || estadoNC <= 3) return false;
    else
      $.ajax({
        type: 'POST',
        url: 'class/Factura.php',
        data: {
          action: 'ReadRespuestaRachazo',
          id: idFactura
        }
      }).done(function(e) {
        // inventarioFacturas.tb_facturas = referenciaCircular;
        if (e != ' []') {
          resultado = JSON.parse(e);
          $('#mensajeRechazo').text('');
          // $("#mensajeRechazo").append('</br><label class="control-label">FACTURA RECHAZADA - Respuesta Ministerio de Hacienda</label></br>');
          $('#mensajeRechazo').append(resultado[0].respuesta);
        }
      });
  }
}

let distr = new Distribucion();

$('#tb_facturasExternas tbody').on('click', 'td', function() {
  inventarioFacturas.ReadbyID(inventarioFacturas.tb_facturas.row(this).data());
});
