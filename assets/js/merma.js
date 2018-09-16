class Merma {
    // Constructor
    constructor(id, idInsumo, idProducto, cantidad, descripcion, fecha) {
        this.id = id || null;
        this.idInsumo = idInsumo || null;
        this.idProducto = idProducto || null;
        this.cantidad = cantidad || 0;
        this.descripcion = descripcion || '';
        this.fecha = fecha || null;
    }

    crear() {
        var miAccion = "Create";
        //
        var listaok = true;
        merma.listaInsumo = [];
        $('#tInsumo tbody tr').each(function (i, item) {
            var objlista = new Object();
            objlista.idInsumo = $(item).find('td:eq(0)')[0].textContent;
            objlista.cantidad = $(item).find('td:eq(4) input').val();
            if ($(item).find('td:eq(5) input').val() == undefined || $(item).find('td:eq(5) input').val() == '') {
                swal({
                    type: 'warning',
                    title: 'Descripción...',
                    text: 'Debe digitar la descripción de la merma'
                });
                listaok = false;
            }
            objlista.descripcion = $(item).find('td:eq(5) input').val();
            merma.listaInsumo.push(objlista);
        });
        merma.listaProducto = [];
        $('#tProducto tbody tr').each(function (i, item) {
            var objlista = new Object();
            objlista.idProducto = $(item).find('td:eq(0)')[0].textContent;
            objlista.cantidad = $(item).find('td:eq(4) input').val();
            if ($(item).find('td:eq(5) input').val() == undefined || $(item).find('td:eq(5) input').val() == '') {
                swal({
                    type: 'warning',
                    title: 'Descripción...',
                    text: 'Debe digitar la descripción de la merma'
                });
                listaok = false;
            }
            objlista.descripcion = $(item).find('td:eq(5) input').val();
            merma.listaProducto.push(objlista);
        });
        if (!listaok)
            return false;
        if (merma.listaInsumo[0].idInsumo == 'Sin Registros') {
            merma.listaInsumo = [];
        }
        if (merma.listaProducto[0].idProducto == 'Sin Registros') {
            merma.listaProducto = [];
        }
        if (merma.listaInsumo.length == 0 && merma.listaProducto.length == 0) {
            swal({
                type: 'warning',
                title: 'Seleccionar...',
                text: 'Debe seleccionar la materia prima o productos'
            });
            return false;
        }
        $('#btnMerma').attr("disabled", "disabled");
        //
        $.ajax({
            type: "POST",
            url: "class/merma.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function () {
                insumo.showInfo;
                // tablas.
                ti.rows().remove().draw();
                tp.rows().remove().draw();
            })
            .fail(function (e) {
                insumo.showError(e);
            })
            .always(function () {
                $("#btnMerma").removeAttr("disabled");
                $("#p_searhInsumo").focus();
            });

    }
}
let merma = new Merma();