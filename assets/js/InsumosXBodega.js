class InsumoBodega {
  // Constructor
  constructor(
    id,
    idBodega,
    codigo,
    nombre,
    descripcion,
    saldoCantidad,
    saldoCosto,
    costoPromedio,
    agencia
  ) {
    this.id = id || null;
    this.idBodega = idBodega || null;
    this.codigo = codigo || '';
    this.nombre = nombre || '';
    this.descripcion = descripcion || '';
    this.saldoCantidad = saldoCantidad || 0;
    this.saldoCosto = saldoCosto || 0;
    this.costoPromedio = costoPromedio || 0;
    this.agencia = agencia || '';
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
    var miAccion = this.id == null ? 'ReadAll' : 'Read';
    if (miAccion == 'ReadAll' && $('#tInsumo tbody').length == 0) return;
    $.ajax({
      type: 'POST',
      url: 'class/InsumosXBodega.php',
      data: {
        action: miAccion,
        id: this.id
        // idBodega: this.idBodega no envpia el idBodega, toma el de la sesion.
      }
    })
      .done(function(e) {
        insumobodega.Reload(e);
      })
      .fail(function(e) {
        insumobodega.showError(e);
      });
  }

  get ReadCompleto() {
    var miAccion = 'ReadCompleto';
    if (miAccion == 'ReadAll' && $('#tInsumo tbody').length == 0) return;
    $.ajax({
      type: 'POST',
      url: 'class/InsumosXBodega.php',
      data: {
        action: miAccion,
        id: this.id
        // idBodega: this.idBodega no envpia el idBodega, toma el de la sesion.
      }
    })
      .done(function(e) {
        insumobodega.Reload(e);
      })
      .fail(function(e) {
        insumobodega.showError(e);
      });
  }

  get ReadByBodega() {
    var miAccion = this.id == null ? 'ReadAll' : 'Read';
    if (miAccion == 'ReadAll' && $('#tInsumo tbody').length == 0) return;
    $.ajax({
      type: 'POST',
      url: 'class/InsumosXBodega.php',
      data: {
        action: miAccion,
        idBodega: this.idBodega
      }
    })
      .done(function(e) {
        insumobodega.Reload(e);
      })
      .fail(function(e) {
        insumobodega.showError(e);
      });
  }

  get Save() {
    $('#btnSubmit').attr('disabled', 'disabled');
    var miAccion = this.id == null ? 'Create' : 'Update';
    this.saldoCantidad = $('#saldoCantidad').val();
    this.saldoCosto = $('#saldoCosto').val();
    this.costoPromedio = $('#costoPromedio').val();
    if (arrInventario != null) {
      this.arrInventario = new Array();
      this.arrInventario = arrInventario;
    }
    $.ajax({
      type: 'POST',
      url: 'class/InsumosXBodega.php',
      data: {
        action: miAccion,
        obj: JSON.stringify(this)
      }
    })
      .done(insumobodega.showInfo)
      .fail(function(e) {
        insumobodega.showError(e);
      })
      .always(function() {
        $('#btnSubmit').removeAttr('disabled');
        insumobodega = new InsumoBodega();
        insumobodega.ClearCtls();
        insumobodega.ReadCompleto;
      });
  }

  Reload(e) {
    if (this.id == null) this.ShowAll(e);
    else this.ShowItemData(e);
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

  ClearCtls() {
    $('#codigo').val('');
    $('#nombre').val('');
    $('#descripcion').val('');
    $('#producto').val('');
    $('#saldoCantidad').val('');
    $('#saldoCosto').val('');
    $('#costoPromedio').val('');
    $('#cantidadMod').val('0');
    arrInventario = new Array();
  }

  ShowAll(e) {
    var t = $('#tInsumo').DataTable();
    if (t.rows().count() == 0) {
      t.clear();
      var data = JSON.parse(e);
      $.each(data, function(i, item) {
        item.saldoCosto =
          '¢' +
          parseFloat(item.saldoCosto)
            .toFixed(2)
            .toString();
        item.costoPromedio =
          '¢' +
          parseFloat(item.costoPromedio)
            .toFixed(2)
            .toString();
      });
      t.rows.add(data);
      t.draw();
      $(document).on(
        'click',
        '#tInsumo tbody tr',
        document.URL.indexOf('InsumosBodegaTodos.html') != -1
          ? insumobodega.UpdateEventHandler
          : null
      );
    } else {
      t.clear();
      var data = JSON.parse(e);
      $.each(data, function(i, item) {
        item.saldoCosto =
          '¢' +
          parseFloat(item.saldoCosto)
            .toFixed(2)
            .toString();
        item.costoPromedio =
          '¢' +
          parseFloat(item.costoPromedio)
            .toFixed(2)
            .toString();
      });
      t.rows.add(data);
      t.draw();
    }
  }

  UpdateEventHandler() {
    insumobodega.id =
      $(this)
        .parents('tr')
        .find('.itemId')
        .text() ||
      $(this)
        .find('.itemId')
        .text();
    // abre modal para editar la cantidad.
    insumobodega.Read;
  }

  ShowItemData(e) {
    // Limpia el controles
    this.ClearCtls();
    // carga objeto.
    var data = JSON.parse(e)[0];
    insumobodega = new InsumoBodega(
      data.id,
      data.idBodega,
      data.codigo,
      data.producto,
      data.descripcion,
      data.saldoCantidad,
      data.saldoCosto,
      data.costoPromedio,
      data.agencia
    );
    $('#codigo').val(insumobodega.codigo);
    $('#nombre').val(insumobodega.nombre);
    $('#descripcion').val(insumobodega.descripcion);
    $('#saldoCantidad').val(insumobodega.saldoCantidad);
    $('#saldoCosto').val(insumobodega.saldoCosto);
    $('#costoPromedio').val(insumobodega.costoPromedio);
    //
    $('#myModalLabel').html('<h1>' + insumobodega.agencia + '<h1>');
    $('.bs-bodega-modal-lg').modal('toggle');
  }

  DeleteEventHandler() {
    insumobodega.id = $(this)
      .parents('tr')
      .find('.itemId')
      .text(); //Class itemId = ID del objeto.
    // Mensaje de borrado:
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
        insumobodega.Delete;
      }
    });
  }

  setTable(buttons = true, completo = false) {
    jQuery.extend(jQuery.fn.dataTableExt.oSort, {
      'formatted-num-pre': function(a) {
        a = a === '-' || a === '' ? 0 : a.replace(/[^\d\-\.]/g, '');
        return parseFloat(a);
      },
      'formatted-num-asc': function(a, b) {
        return a - b;
      },
      'formatted-num-desc': function(a, b) {
        return b - a;
      }
    });

    $('#tInsumo').DataTable({
      responsive: true,
      destroy: true,
      order: [[5, 'desc']],
      dom: 'Bfrtip',
      buttons: [
        {
          extend: 'excelHtml5',
          exportOptions: { columns: [1, 2, 3, 4, 5] },
          messageTop: 'Inventario por Agencia'
        },
        {
          extend: 'pdfHtml5',
          orientation: 'landscape',
          messageTop: 'Inventario por Agencia',
          exportOptions: {
            columns: [1, 2, 3, 4, 5]
          }
        }
      ],
      language: {
        infoEmpty: 'Sin Productos Agencia',
        emptyTable: 'Sin Productos Agencia',
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
      columnDefs: [{ className: 'text-right', targets: [4, 5] }],
      columns: [
        {
          title: 'ID',
          data: 'id',
          className: 'itemId',
          searchable: false
        },
        {
          title: 'AGENCIA',
          data: 'agencia',
          visible: completo
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
          title: 'CANTIDAD',
          data: 'saldoCantidad'
        },
        {
          title: 'COSTO',
          data: 'saldoCosto',
          visible: false
        },
        {
          title: 'COSTO PROMEDIO',
          data: 'costoPromedio',
          visible: false
        },
        {
          title: 'ACCION',
          orderable: false,
          searchable: false,
          visible: buttons,
          className: 'buttons',
          width: '5%',
          mRender: function() {
            return '<a class="delete"> <i class="glyphicon glyphicon-trash"> </i>  </a>';
          }
        }
      ]
    });
  }

  Init() {
    // validator.js
    var validator = new FormValidator(
      { events: ['blur', 'input', 'change'] },
      document.forms['frmInsumo']
    );
    $('#frmInsumo').submit(function(e) {
      e.preventDefault();
      var validatorResult = validator.checkAll(this);
      if (validatorResult.valid) insumobodega.Save;
      return false;
    });

    // on form "reset" event
    if ($('#frmInsumo').length > 0)
      document.forms['frmInsumo'].onreset = function(e) {
        validator.reset();
      };
  }

  setTableInventarioInsumoReporte() {
    jQuery.extend(jQuery.fn.dataTableExt.oSort, {
      'formatted-num-pre': function(a) {
        a = a === '-' || a === '' ? 0 : a.replace(/[^\d\-\.]/g, '');
        return parseFloat(a);
      },
      'formatted-num-asc': function(a, b) {
        return a - b;
      },
      'formatted-num-desc': function(a, b) {
        return b - a;
      }
    });

    this.tablainsumo = $('#dsInsumoReporte').DataTable({
      responsive: true,
      destroy: true,
      order: [1, 'desc'],
      dom: 'Bfrtip',
      buttons: [
        {
          extend: 'excelHtml5',
          exportOptions: { columns: [1, 3, 5, 7, 9, 10, 11, 12, 13, 14, 15] },
          messageTop: 'Movimientos de Materia Prima'
        },
        {
          extend: 'pdfHtml5',
          orientation: 'landscape',
          exportOptions: { columns: [1, 3, 5, 7, 9, 10, 11, 12, 13, 14, 15] }
        }
      ],
      language: {
        infoEmpty: 'Sin movimientos de Materia Prima',
        emptyTable: 'Sin movimientos de Materia Prima',
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
      columns: [
        {
          title: 'ID',
          data: 'id',
          className: 'itemId',
          width: 'auto',
          searchable: false
        },
        {
          title: 'FECHA',
          data: 'fecha',
          width: 'auto'
        },
        {
          title: 'BODEGA',
          data: 'agencia',
          visible: true
        },
        {
          title: 'ENTRADA',
          data: 'ordenEntrada',
          width: 'auto'
        },
        // {
        //     title: "ORDEN SALIDA",
        //     data: "idOrdenSalida",
        //     visible: false
        // },
        {
          title: 'SALIDA',
          data: 'ordenSalida',
          width: 'auto'
        },
        {
          title: 'ID INSUMO',
          data: 'idInsumo',
          visible: false
        },
        {
          title: 'INSUMO',
          data: 'insumo',
          width: 'auto'
        },
        {
          title: 'ENTRADA',
          data: 'entrada',
          width: 'auto',
          mRender: function(e) {
            if (e == null) return '0';
            else return e;
          }
        },
        {
          title: 'SALIDA',
          data: 'salida',
          width: 'auto',
          mRender: function(e) {
            if (e == null) return '0';
            else return e;
          }
        },
        {
          title: 'SALDO',
          data: 'saldo',
          width: 'auto'
        },
        {
          title: 'COSTO ADQUISICION',
          data: 'costoAdquisicion',
          width: 'auto',
          type: 'formatted-num',
          mRender: function(e) {
            if (e == null) return '¢0';
            else
              return (
                '¢' +
                parseFloat(e)
                  .toFixed(2)
                  .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
              );
          }
        },
        {
          title: 'VALOR ENTRADA',
          data: 'valorEntrada',
          width: 'auto',
          type: 'formatted-num',
          mRender: function(e) {
            if (e == null) return '¢0';
            else
              return (
                '¢' +
                parseFloat(e)
                  .toFixed(2)
                  .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
              );
          }
        },
        {
          title: 'VALOR SALIDA',
          data: 'valorSalida',
          width: 'auto',
          type: 'formatted-num',
          mRender: function(e) {
            if (e == null) return '¢0';
            else
              return (
                '¢' +
                parseFloat(e)
                  .toFixed(2)
                  .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
              );
          }
        },
        {
          title: 'VALOR SALDO',
          data: 'valorSaldo',
          width: 'auto',
          type: 'formatted-num',
          mRender: function(e) {
            if (e == null) return '¢0';
            else
              return (
                '¢' +
                parseFloat(e)
                  .toFixed(2)
                  .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
              );
          }
        },
        {
          title: 'COSTO PROMEDIO',
          data: 'costoPromedio',
          width: 'auto',
          type: 'formatted-num',
          mRender: function(e) {
            if (e == null) return '¢0';
            else
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
  }

  CargaInsumoRango() {
    var referenciaCircular = insumobodega.tablainsumo;
    insumobodega.tablainsumo = [];
    $.ajax({
      type: 'POST',
      url: 'class/InsumosXBodega.php',
      data: {
        action: 'ReadAllbyRange',
        obj: JSON.stringify(insumobodega)
      }
    }).done(function(e) {
      insumobodega.tablainsumo = referenciaCircular;
      insumobodega.ShowAllInventario(e);
    });
  }

  ShowAllInventario(e) {
    //Crea los eventos según sea el url
    var t = $('#dsInsumoReporte').DataTable();
    if (t.rows().count() == 0) {
      t.clear();
      t.rows.add(JSON.parse(e));
      t.draw();
    } else {
      t.clear();
      t.rows.add(JSON.parse(e));
      t.draw();
    }
  }
}

//Class Instance
let insumobodega = new InsumoBodega();
