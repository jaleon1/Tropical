class Factura {
  // Constructor
  constructor(
    id,
    cajero,
    producto,
    descuento,
    total,
    fechaCreacion,
    importe,
    t,
    idUsuario,
    idcliente
  ) {
    this.id = id || null;
    this.cajero = cajero || '';
    this.idUsuario = idUsuario || '';
    this.idcliente = idcliente || '';
    this.descuento = descuento || 0;
    this.producto = producto || new Array(new Array());
    this.total = total || '';
    this.fechaCreacion = fechaCreacion || null;
    this.importe = importe || 0;
    this.t = t || null;
  }
  //Get
  // get Importe() {
  // return this.cantidad * this.precio;
  // }

  // get Save() {

  // }
}

let factura = new Factura();

// var t; //En esta variable se guarda la tabla de productos a facturar
$(document).ready(function() {
  $('#open_modal_fac').attr('disabled', true);

  btnFormaPago();

  //Valida si se presiona enter -> carga el producto en la lista
  //si preciona "*" -> Quita el "*", pasa el punto de insercion a la cantidad y selecciona el valor para ser reemplazdo con el teclado
  $('#p_searh').keyup(function(e) {
    if (e.which == 13) {
      // Acciones a realizar, por ej: enviar formulario.
      LoadProducto();
    }
    if (e.which == 106) {
      $('#p_searh')[0].value = '';
      // se usa UltPrd xq es el UltimoProductoTocado (si la cantidad del producto es alterada no hay forma de saber cual fue el ultimo modificado.)
      $('#cant_' + producto.UltPrd)
        .focus()
        .select();
    }
  });

  // Recarga la página para limpiar todo
  $('#reload').click(function() {
    location.reload();
  });

  //Abre modal de modo de pago
  $('#open_modal_fac').click(function() {
    $('#total_pagar').empty();
    $('#total_pagar').append('Total a Pagar: ' + $('#total')[0].textContent);
  });

  //Usa la variable t que es el datatable donde estan los productos
  t = $('#prd').DataTable({
    ordering: false,
    // "bSort": false,
    info: false, //Quita el pie de pagina
    language: {
      infoEmpty: 'No hay productos agregados',
      emptyTable: 'No hay productos agregados',
      search: 'Buscar En Factura' //Cambia el texto de Search
    },
    columns: [
      { title: 'ID' },
      { title: 'CODIGO' },
      { title: 'DESCRIPCION' },
      { title: 'PRECIO/U' },
      { title: 'CANTIDAD' },
      { title: 'IMPORTE' }
    ], // crea las columnas
    scrollY: '190px',
    // "searching": false,
    scrollCollapse: true,
    paging: false,
    columnDefs: [
      {
        width: '2%',
        targets: 0,
        visible: false,
        searchable: false
      },
      {
        width: '10%',
        targets: 3
      },
      {
        width: '5%',
        targets: 4,
        data: null,
        defaultContent: '<input class="cantidad form-control" type="number">'
      },
      {
        width: '10%',
        targets: 5
      }
    ]
  });

  t.columns.adjust().draw();

  $('#fecha').append(moment().format('MMM DD YYYY, h:mm:ss a'));
});

// Carga el producto a la lista de la factura
function LoadProducto() {
  if ($('#p_searh').val() != '') {
    producto.codigoRapido = $('#p_searh').val(); //Columna 0 de la fila seleccionda= ID.
    producto.scancode = $('#p_searh').val(); //Columna 0 de la fila seleccionda= ID.
    $.ajax({
      type: 'POST',
      url: 'class/Producto.php',
      data: {
        action: 'ReadByCode',
        obj: JSON.stringify(producto)
      }
    })
      .done(function(e) {
        CleanCtls();
        ValidateProductFac(e);
      })
      .fail(function(e) {
        showError(e);
      });
  }
}

// valida que el producto nuevo a ingresar no este en la lista
// si esta en la lista lo suma a la cantidad
// si es nuevo lo agrega a la lista
function ValidateProductFac(e) {
  //compara si el articulo ya existe
  // carga lista con datos.
  if (e != 'false') {
    producto = JSON.parse(e)[0];
    producto.UltPrd = producto.codigoRapido;
    var repetido = false;

    if (
      document.getElementById('productos').rows.length != 0 &&
      producto != null
    ) {
      $(document.getElementById('productos').rows).each(function(i, item) {
        if (item.childNodes[0].innerText == producto.codigoRapido) {
          item.childNodes[3].childNodes['0'].attributes[3].value =
            producto.cantidad;
          var CantAct = parseInt(item.childNodes[3].firstElementChild.value);
          if (parseInt(producto.cantidad) > CantAct) {
            item.childNodes[3].firstElementChild.value =
              parseFloat(item.childNodes[3].firstElementChild.value) + 1;
            item.childNodes[04].firstChild.textContent =
              '¢' +
              parseFloat(
                item.childNodes[2].firstChild.textContent.replace('¢', '')
              ) *
                parseFloat(item.childNodes[3].firstElementChild.value);
            calcTotal();
          } else {
            // alert("No hay mas de este producto");
            alertSwal(producto.cantidad);
            // $("#cant_"+ producto.UltPrd).val($("#cant_"+ producto.UltPrd)[0].attributes[3].value);
            $('#cant_' + producto.UltPrd).val(producto.cantidad);
          }
          repetido = true;
          calcTotal();
        }
      });
    }
    if (repetido == false) {
      // showDataProducto(e);
      AgregaPrd();
    }
  } else {
    CleanCtls();
  }
}

//Agrega el producto a la factura
function AgregaPrd() {
  producto.UltPro = producto.codigoRapido;
  var rowNode = t.row //t es la tabla de productos
    .add([
      producto.id,
      producto.codigoRapido,
      producto.descripcion,
      '¢' + producto.precio,
      '1',
      '¢' + producto.precio
    ])
    .draw() //dibuja la tabla con el nuevo producto
    .node();
  $('td:eq(2)', rowNode).attr({ id: 'prec_' + producto.codigoRapido });
  $('td:eq(4)', rowNode).attr({ id: 'impo_' + producto.codigoRapido });
  $('td:eq(3) input', rowNode).attr({
    id: 'cant_' + producto.codigoRapido,
    max: producto.cantidad,
    min: '0',
    step: '1',
    value: '1',
    onchange: 'CalcImporte(' + producto.codigoRapido + ')'
  });
  $('td:eq(3) input', rowNode).change(function() {
    CalcImporte(producto.codigoRapido);
  });
  t.order([0, 'desc']).draw();
  t.columns.adjust().draw();
  calcTotal();
  $('#open_modal_fac').attr('disabled', false);
}

//Calcula el nuevo importe al cambiar la cantidad del prodcuto seleccionado de forma manual y no por producto repetido.
function CalcImporte(prd) {
  producto.UltPrd = prd; //validar
  pUnit = $(`#prec_${prd}`)[0].textContent.replace('¢', '');
  cant = parseInt($(`#cant_${prd}`)[0].value);

  if (cant <= parseInt($(`#cant_${prd}`)[0].attributes[3].value)) {
    $(`#impo_${prd}`)[0].textContent =
      '¢' + (parseFloat(pUnit) * parseFloat(cant)).toString();
  } else {
    // alert("Cantidad invalida, la cantidad maxima disponible es: "+ $(`#cant_${prd}`)[0].attributes[3].value)
    alertSwal(producto.cantidad);
    $('#cant_' + producto.UltPrd).val($(`#cant_${prd}`)[0].attributes[3].value);
  }

  $(`#impo_${prd}`)[0].textContent =
    '¢' + (parseFloat(pUnit) * parseInt($(`#cant_${prd}`)[0].value)).toString();
  // $(`#importe_${prd}`)[0].textContent
  $(`#cant_${prd}`).keyup(function(e) {
    if (e.which == 13) {
      if (cant == 0) {
        BorraRow(prd);
        calcTotal();
      }
      $(`#impo_${prd}`)[0].textContent =
        '¢' +
        (parseFloat(pUnit) * parseInt($(`#cant_${prd}`)[0].value)).toString();
      calcTotal();
      $('#p_searh').focus();
    }
  });
  if (cant == 0) {
    BorraRow(prd);
    calcTotal();
    $('#p_searh').focus();
  }
}

//Calcula los totales cada vez que un producto es modificado
function calcTotal() {
  var subT = 0;
  if ($(document.getElementById('productos').rows)['0'].childElementCount > 2) {
    $(document.getElementById('productos').rows).each(function(i, item) {
      // alert(item.childNodes[3].innerText);

      subT = subT + parseFloat(item.childNodes[4].textContent.replace('¢', ''));
    });
    $('#subTotal')[0].textContent = '¢' + subT.toFixed(2);
    factura.descuento = $('#desc_val')[0].textContent =
      '¢' +
      (
        (subT * parseFloat($('#desc_100')[0].textContent.replace('%', ''))) /
        100
      ).toFixed(2);
    factura.impuesto = $('#iv_val')[0].textContent =
      '¢' +
      (
        subT *
          (parseFloat($('#iv_100')[0].textContent.replace('%', '')) / 100) -
        parseFloat($('#desc_val')[0].textContent.replace('¢', ''))
      ).toFixed(2);
    $('#total')[0].textContent =
      '¢' +
      (
        $('#subTotal')[0].textContent.replace('¢', '') -
        parseFloat($('#desc_val')[0].textContent.replace('¢', '')) +
        parseFloat($('#iv_val')[0].textContent.replace('¢', ''))
      ).toFixed(2);
  } else {
    $('#open_modal_fac').attr('disabled', true);
    $('#subTotal')[0].textContent = '¢0';
    $('#desc_val')[0].textContent = '¢0';
    $('#iv_val')[0].textContent = '¢0';
    $('#total')[0].textContent = '¢0';
  }
}

//Elimana el producto de la factura
function BorraRow(prd) {
  $(`#prec_${prd}`)['0'].parentElement.attributes[1].value =
    $(`#prec_${prd}`)['0'].parentElement.attributes[1].value + ' selected';
  t.row('.selected')
    .remove()
    .draw(false);
}

function facCard() {
  $('#formapago').empty();
  var DivCard = `<div class="row">
        <div class="col-md-4 col-md-offset-4 col-sm-offset-0 col-xs-6 col-xs-offset-0">
            <h3 class="text-left" >Ingrese Ref.:</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <input class="input-lg valPago" type="text" onkeyup="valPago(this.value)" placeholder="Ingrese Numero Referencia" required="" minlength="5" autofocus="">
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4 col-sm-offset-0 col-xs-6 col-xs-offset-0">
            <button type="button" onclick="CreateFact()" class="btn btn-primary procesarFac" disabled style="margin-top:10px;">Procesar</button>
        </div>
    </div>`;
  $('#formapago').append(DivCard);

  $('#btn-formapago').empty();
  var DivCash = `<button type="button" id="modalFormaPago" onclick="btnFormaPago()"class="btn btn-primary">Atras</button>`;
  $('#btn-formapago').append(DivCash);
}

function facCash() {
  $('#formapago').empty();

  var DivCash = `<div class="row">
        <div class="col-md-4 col-md-offset-4 col-sm-offset-0 col-xs-6 col-xs-offset-0">
            <h3 class="text-left" >Paga con:</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <input id="pagocash" class="input-lg valPago" onkeyup="valPago(this.value)" type="text" placeholder="Ingrese Monto en Efectivo"  required="" minlength="5" autofocus="">
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4 col-sm-offset-0 col-xs-6 col-xs-offset-0">
            <button type="button" onclick="CreateFact()" class="btn btn-primary procesarFac" disabled style="margin-top:10px;">Procesar</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4 col-sm-offset-0 col-xs-6 col-xs-offset-0">
            <h3 class="text-left" id="vuelto">Su vuelto:</h3>
        </div>
    </div>`;
  $('#formapago').append(DivCash);

  $('#btn-formapago').empty();
  var DivCash = `<button type="button" id="modalFormaPago" onclick="btnFormaPago()"class="btn btn-primary">Atras</button>`;
  $('#btn-formapago').append(DivCash);
}

function btnFormaPago() {
  $('#formapago').empty();
  var DivCash = `<div class="col-md-2"></div>
    <div class="col-md-3" onclick="facCard()">
        <img id="fac-ccard" src="images/credit-cards.png" class="modal-img-pago">
        <p class="text-center">Tarjeta</p>
    </div>
    <div class="col-md-2"></div>
    <div class="col-md-3" onclick="facCash()">
        <img id="fac-cash" src="images/cash.png" class="modal-img-pago">
        <p class="text-center">Efectivo</p>
    </div>`;
  $('#formapago').append(DivCash);

  $('#btn-formapago').empty();
  var DivCash = `<button type="button" id="modalPago" class="btn btn-primary" data-dismiss="modal">Atras</button>`;
  $('#btn-formapago').append(DivCash);
}

function valPago(val) {
  xPagar = parseFloat($('#total')[0].textContent.replace('¢', ''));
  pago = parseFloat($('.valPago').val());

  if (isNaN($('.valPago').val())) {
    // alert("numero");
    val = val.replace(/[^0-9]/g, '');
    $('.valPago').val(val);
  } else {
    if (pago >= xPagar) {
      $('.procesarFac').prop('disabled', false);
      calcVuelto(pago, xPagar);
    } else {
      $('.procesarFac').prop('disabled', true);
    }
  }
}

function CreateFact() {
  $(t.columns().data()[0]).each(function(ic, c) {
    factura.producto[ic] = $(t.rows().data()[ic]);
  });

  var miAccion = this.id == null ? 'Create' : 'Update';

  $.ajax({
    type: 'POST',
    url: 'class/Factura.php',
    data: {
      action: miAccion,
      obj: JSON.stringify(factura)
    }
  })
    .done(alertFact())
    .fail(function(e) {
      producto.showError(e);
    })
    .always(function() {
      $('#btnProducto').removeAttr('disabled');
      producto = new Producto();
      producto.ClearCtls();
      producto.Read;
      $('#nombre').focus();
    });
}

//informa de cantidad de producto
function alertSwal(cant) {
  swal({
    type: 'info',
    title: 'Oops...',
    text: 'Cantidad Inexistente de Producto!',
    footer: '<h3>Cantidad maxima de producto disponble es: ' + cant + '</h3>',
    // showConfirmButton: false,
    timer: 3500
  });
  // alert('La cantidad maxima de producto disponble es: '+ cant);
}

//Informa que la factura fue agregada
function alertFact() {
  swal({
    type: 'success',
    text: 'Factura Lista!',
    timer: 2000
  });
  $('.procesarFac').prop('disabled', true);
  // calcVuelto();
  setTimeout(function() {
    location.reload();
  }, 2000);
}

function calcVuelto(pago, xPagar) {
  // $("#vuelto").val(pago-xPagar);
  vuelto = (pago - xPagar).toFixed(2).toString();

  // $("#vuelto").val("EJEMPLO");
  $('#vuelto')['0'].textContent = 'Su cambio: ' + vuelto;
}

// Muestra errores en ventana
function showError(e) {
  //$(".modal").css({ display: "none" });
  var data = JSON.parse(e.responseText);
  alert('ERROR');
  // swal({
  //     type: 'error',
  //     title: 'Oops...',
  //     text: 'Algo no está bien (' + data.code + '): ' + data.msg,
  //     footer: '<a href>Contacte a Soporte Técnico</a>',
  //   })
}

function CleanCtls() {
  $('#p_searh').val('');
}